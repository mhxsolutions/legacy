using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using BopsDataAccess;
using FlashGateway.IO;
using log4net;
using NHibernate;
using NHibernate.Expression;
using NHibernateUtilities;

namespace DrServices
{
    /// <summary>
    /// Supports data entry features for harbor DR records.
    /// </summary>
    public class DataEntry
    {
        // NB: the NHibernate configuration file is in the directory above the assembly because
        // this is a web application (i.e., the assembly is in the /bin folder.

        private const string _DwsNoRepData = "../NHibernateDwsNoRepData.xml.config";
        private const string _DwsRepData = "../NHibernateDwsRepData.xml.config";
        private const string _ExceptionErrorMessage = "An exception occurred. Please notify IT support.";
        private static readonly ILog _Log = LogManager.GetLogger(typeof(DataEntry));

        /// <summary>
        /// Retrieves the parent destination of the supplied client ID. If there is no parent, then the
        /// destination matching the ID is returned.
        /// </summary>
        /// <param name="DwsRepData">The NHibernate session to use for retrieving the data.</param>
        /// <param name="DestinationId">The ID of the destination to process.</param>
        /// <returns>The parent destination.</returns>
        private static BopsDestination GetParentDestination(ISession DwsRepData, int DestinationId)
        {
            BopsDestination ReturnValue = DwsRepData.Get<BopsDestination>(DestinationId);
            if (ReturnValue.ParentRef.HasValue && ReturnValue.ParentRef != 0 && ReturnValue.ParentRef != ReturnValue.DestinationId)
                ReturnValue = DwsRepData.Get<BopsDestination>(ReturnValue.ParentRef);
            return ReturnValue;
        }

        /// <summary>
        /// Performs server-side validation on the harbor DR entry using the specified database session.
        /// </summary>
        /// <param name="DwsNoRepData">The [DWS No Rep Data] database session.</param>
        /// <param name="DwsRepData">The [DWS Rep Data] database session.</param>
        /// <param name="Hdr">The harbor DR entry object to be validated.</param>
        /// <param name="ValidateItems">Specifies whether the items should be included in validation.</param>
        /// <returns>An empty string if there are no problems, otherwise a string containing any
        /// applicable error messages.</returns>
        private static string ServerValidation(ISession DwsNoRepData, ISession DwsRepData, HopsDrEntry Hdr, bool ValidateItems)
        {
            string ReturnValue = string.Empty;
            BopsProjectManagerBillOfLading Pmbol = DwsNoRepData.Get<BopsProjectManagerBillOfLading>(Hdr.ProjectManagerBolRef);

            if (Pmbol == null)
            {
                ReturnValue += "BL doesn't exist. ";
            }
            else
            {
                BopsProjectManagerDeliveryOrder Pmdo = DwsNoRepData.Get<BopsProjectManagerDeliveryOrder>(Pmbol.PmdoRef);
                BopsProjectManagerStatus.Codes Status = (BopsProjectManagerStatus.Codes)(Pmdo.ProjectStatusRef);

                if (Status != BopsProjectManagerStatus.Codes.Active)
                    ReturnValue += "Harbor project is not active. ";
            }

            BopsProjectManagerDr Pmdr = DwsNoRepData.Get<BopsProjectManagerDr>(Hdr.DrId);
            if (Pmdr == null)
            {
                ReturnValue += "DR doesn't exist. ";
            }
            else
            {
                if (Pmdr.BillOfLadingRef != Hdr.ProjectManagerBolRef)
                    ReturnValue += "BL does not match DR. ";
            }

            // Validate the PUR if it was provided, which includes matching the PUR destination against 
            // the BOL destination.

            if (!string.IsNullOrEmpty(Hdr.LoadRef))
            {
                BopsLoad Load = DwsNoRepData.Get<BopsLoad>(Hdr.LoadRef);
                if (Load == null)
                {
                    ReturnValue += "Pickup request doesn't exist. ";
                }
                else if (Pmbol != null && Load.DeliveryLocationRef.HasValue && Pmbol.DestinationRef.HasValue)
                {
                    BopsDestination PurDestination = GetParentDestination(DwsRepData, Load.DeliveryLocationRef.Value);
                    BopsDestination BolDestination = GetParentDestination(DwsRepData, Pmbol.DestinationRef.Value);

                    if (PurDestination != BolDestination)
                        ReturnValue += "BL destination does not match PUR destination. ";
                }
            }

            // Finally, validate that any items attached to the DR are valid and aren't already withdrawn.
            // This is only done during a finalize operation, insofar as it will otherwise prevent the
            // user from getting to the items page in the first place.

            if (ValidateItems)
            {
                IList<HopsDrEntryItem> HopsDrItems = DwsNoRepData.CreateCriteria(typeof (HopsDrEntryItem))
                    .Add(Expression.Eq("HopsDrRef", Hdr.DrId))
                    .List<HopsDrEntryItem>();
                if (HopsDrItems.Count > 0)
                {
                    // Load up an array with the project manager detail IDs for use in a couple of queries.

                    int[] BopsItemIds = new int[HopsDrItems.Count];
                    for (int I = 0; I < HopsDrItems.Count; I++)
                        BopsItemIds[I] = HopsDrItems[I].BopsBolDetailRef;

                    // The first query uses the IDs to query the project manager detail records. If the counts
                    // (i.e., the harbor item count versus the project manager item count) don't match, then
                    // at least one of the harbor items is no longer valid.

                    IList<BopsProjectManagerBillOfLadingDetail> BopsDrItems = DwsNoRepData.CreateCriteria(typeof (BopsProjectManagerBillOfLadingDetail))
                        .Add(Expression.In("DetailId", BopsItemIds))
                        .List<BopsProjectManagerBillOfLadingDetail>();
                    if (BopsDrItems.Count != HopsDrItems.Count)
                        ReturnValue += "At least one of the DR items is unknown. ";

                    // The second query uses the IDs to query the withdrawal records. If any records are found,
                    // then at least one of the items is already shipped.

                    IList<BopsProjectManagerBillOfLadingDetailWithdrawal> Withdrawals = DwsNoRepData.CreateCriteria(typeof (BopsProjectManagerBillOfLadingDetailWithdrawal))
                        .Add(Expression.In("DetailRef", BopsItemIds))
                        .List<BopsProjectManagerBillOfLadingDetailWithdrawal>();
                    if (Withdrawals.Count > 0)
                        ReturnValue += "At least one of the DR items is already shipped. ";
                }
            }

            return ReturnValue;
        }

        /// <summary>
        /// Saves the specified harbor DR entry.
        /// </summary>
        /// <param name="Hdr">The harbor DR entry object to be saved.</param>
        /// <returns>An empty string if there are no problems, otherwise a string containing any
        /// applicable error messages.</returns>
        private static string Save(HopsDrEntry Hdr)
        {
            bool CommitChanges = false;
            SessionManager<string> Mgr = new SessionManager<string>();
            string ErrorString;

            try
            {
                String AssemblyPath = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().CodeBase);
                string ConfigurationFileName = Path.Combine(AssemblyPath, _DwsNoRepData);
                ISession DwsNoRepData = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);
                ConfigurationFileName = Path.Combine(AssemblyPath, _DwsRepData);
                ISession DwsRepData = Mgr.AddSession(_DwsRepData, ConfigurationFileName);

                ErrorString = ServerValidation(DwsNoRepData, DwsRepData, Hdr, Hdr.Finalized);
                if (ErrorString != string.Empty)
                {
                    return ErrorString;
                }
                else
                {
                    Mgr.BeginTransaction(_DwsNoRepData);
                    HopsDrEntry NewDrEntry = DwsNoRepData.Get<HopsDrEntry>(Hdr.DrId);
                    if (NewDrEntry == null)
                    {
                        NewDrEntry = new HopsDrEntry();
                        NewDrEntry.DrId = Hdr.DrId;
                    }

                    if (NewDrEntry.Finalized)
                    {
                        ErrorString = string.Format("DRID {0} has already been finalized and cannot be edited", Hdr.DrId);
                        _Log.Error(ErrorString);
                    }
                    else
                    {
                        NewDrEntry.ProjectManagerBolRef = Hdr.ProjectManagerBolRef;
                        NewDrEntry.Count = Hdr.Count;
                        NewDrEntry.Weight = Hdr.Weight; // NB: the class will throw an exception if the weight is out of range.
                        NewDrEntry.LastUpdateTime = DateTime.Now;
                        NewDrEntry.GatePass = Hdr.GatePass;
                        NewDrEntry.LoadRef = Hdr.LoadRef;
                        NewDrEntry.Tractor = Hdr.Tractor;

                        if (Hdr.Finalized)
                        {
                            ErrorString = DoFinalizeProcessing(DwsNoRepData, NewDrEntry, true);
                            if (ErrorString == string.Empty)
                                CommitChanges = true;
                        }
                        else
                        {
                            DwsNoRepData.SaveOrUpdateCopy(NewDrEntry);
                            CommitChanges = true;
                        }
                    }
                }
            }
            catch (Exception E1)
            {
                ErrorString = _ExceptionErrorMessage;
                _Log.Debug("An exception occurred, details follow.", E1);
            }
            finally
            {
                Mgr.CloseAllSessions(CommitChanges);
            }

            return ErrorString;
        }

        /// <summary>
        /// Performs the steps necessary to finalize one of the temporary DR records and move the relevant
        /// bits of its data to the project manager DR table. The method does not catch any exceptions;
        /// the caller is responsible for handling exceptions, as well as the niceties of transaction 
        /// processing.
        /// </summary>
        /// <param name="DwsNoRepData">The database session to use for the unit of work.</param>
        /// <param name="Hdr">The harbor DR entry record to finalize.</param>
        /// <param name="CheckLoadDrAssignments">If true, causes the routine to check whether the specified
        /// load reference is in use on other loads and, if so, return a special code to indicate that
        /// confirmation is needed.</param>
        /// <returns>An emptry string if all went well, or the aforementioned special code if the load
        /// reference has already been used on other loads.</returns>
        private static string DoFinalizeProcessing(ISession DwsNoRepData, HopsDrEntry Hdr, bool CheckLoadDrAssignments)
        {
            BopsLoad Load = DwsNoRepData.Get<BopsLoad>(Hdr.LoadRef);

            if (CheckLoadDrAssignments)
            {
                IList<BopsProjectManagerDr> LoadDrs = DwsNoRepData.CreateCriteria(typeof(BopsProjectManagerDr))
                    .Add(Expression.Eq("LoadKeyRef", Load.LoadKey))
                    .List<BopsProjectManagerDr>();

                if (LoadDrs.Count > 0)
                {
                    DwsNoRepData.SaveOrUpdateCopy(Hdr);
                    return "CONFIRMLOAD";    // Special value indicates that the load assignment needs confirmation.
                }
            }

            // Update the DR properties with the details provided.

            BopsProjectManagerDr Pmdr = DwsNoRepData.Get<BopsProjectManagerDr>(Hdr.DrId);
            Pmdr.Count = Hdr.Count;
            Pmdr.Weight = Hdr.Weight;
            Pmdr.LoadKeyRef = Load.LoadKey;
            Pmdr.GatePass = Hdr.GatePass;
            DwsNoRepData.Update(Pmdr);

            // Update the load's weight values with the weight on the DR.

            Load.ChargedWeight = Load.GrossWeight = Load.NetWeight = Hdr.Weight.Value;
            DwsNoRepData.Update(Load);

            IList<HopsDrEntryItem> Items = DwsNoRepData.CreateCriteria(typeof (HopsDrEntryItem))
                .Add(Expression.Eq("HopsDrRef", Hdr.DrId))
                .List<HopsDrEntryItem>();

            foreach (HopsDrEntryItem Item in Items)
            {
                BopsProjectManagerBillOfLadingDetailWithdrawal NewWithdrawal = new BopsProjectManagerBillOfLadingDetailWithdrawal();
                NewWithdrawal.DetailRef = Item.BopsBolDetailRef;
                NewWithdrawal.DrRef = Hdr.DrId;
                DwsNoRepData.Save(NewWithdrawal);
            }

            Hdr.Finalized = true;
            DwsNoRepData.SaveOrUpdateCopy(Hdr);

            return string.Empty;
        }

        /// <summary>
        /// Retrieves the data for the given DR ID.
        /// </summary>
        /// <param name="DrId">The ID of the DR to get retrieved.</param>
        /// <returns>An ASObject intended to be received by a client Flash application or null if the DR cannot be found.</returns>
        public ASObject GetDr(int DrId)
        {
            SessionManager<string> Mgr = new SessionManager<string>();

            try
            {
                String AssemblyPath = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().CodeBase);
                string ConfigurationFileName = Path.Combine(AssemblyPath, _DwsNoRepData);
                ISession DwsNoRepData = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);
                HopsDrEntry Hdr = DwsNoRepData.Get<HopsDrEntry>(DrId);
                return RemotingTranslator.HopsDrEntryToFlash(Hdr);
            }
            catch (Exception E)
            {
                _Log.Debug("An exception occurred, details follow.", E);
            }
            finally
            {
                Mgr.CloseAllSessions(false);
            }

            return null;
        }

        /// <summary>
        /// Retrieves the data for the given DR ID, including any harbor DR items that may have been attached.
        /// </summary>
        /// <param name="DrId">The ID of the DR to get retrieved.</param>
        /// <returns>An ASObject intended to be received by a client Flash application or null if the DR cannot be found.</returns>
        public ASObject GetDrAndItems(int DrId)
        {
            ASObject ReturnValue = null;
            SessionManager<string> Mgr = new SessionManager<string>();

            try
            {
                String AssemblyPath = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().CodeBase);
                string ConfigurationFileName = Path.Combine(AssemblyPath, _DwsNoRepData);
                ISession DwsNoRepData = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);
                HopsDrEntry Hdr = DwsNoRepData.Get<HopsDrEntry>(DrId);

                if (Hdr != null)
                {
                    IList<HopsDrEntryItem> Items = DwsNoRepData.CreateCriteria(typeof(HopsDrEntryItem))
                        .Add(Expression.Eq("HopsDrRef", Hdr.DrId))
                        .List<HopsDrEntryItem>();
                    DataTable ItemsTable = CreateReturnTable();
                    PopulateItemsTable(DwsNoRepData, Items, ItemsTable);
                    
                    ReturnValue = RemotingTranslator.HopsDrEntryToFlash(Hdr);
                    ReturnValue["itemsDataTable"] = ItemsTable;
                }
            }
            catch (Exception E)
            {
                _Log.Debug("An exception occurred, details follow.", E);
            }
            finally
            {
                Mgr.CloseAllSessions(false);
            }

            return ReturnValue;
        }

        /// <summary>
        /// Saves and optionally finalizes the DR.
        /// </summary>
        /// <param name="Aso">An ASObject received from Flash remoting.</param>
        /// <returns>An empty string if everything went without complications, "CONFIRMLOAD" if the DR was saved but
        /// the load number needs to be confirmed for finalize, or a string filled with error messages if something
        /// went wrong and the DR could not be saved.
        /// </returns>
        public string SaveDr(ASObject Aso)
        {
            HopsDrEntry Hdr = RemotingTranslator.FlashToHopsDrEntry(Aso);
            return Save(Hdr);
        }

        /// <summary>
        /// Performs only the finalize sequence of operations on a HopsDrEntry.
        /// </summary>
        /// <param name="DrId">The DR ID to be finalized.</param>
        /// <returns>A string full of error messages if anything went wrong; otherwise an empty string.</returns>
        public string FinalizeDr(int DrId)
        {
            bool CommitChanges = false;
            SessionManager<string> Mgr = new SessionManager<string>();
            string ReturnValue;

            try
            {
                String AssemblyPath = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().CodeBase);
                string ConfigurationFileName = Path.Combine(AssemblyPath, _DwsNoRepData);
                ISession DwsNoRepData = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);
                Mgr.BeginTransaction(_DwsNoRepData);

                HopsDrEntry DrEntry = DwsNoRepData.Get<HopsDrEntry>(DrId);
                ReturnValue = DoFinalizeProcessing(DwsNoRepData, DrEntry, false);
                if (ReturnValue == string.Empty)
                    CommitChanges = true;
            }
            catch (Exception E1)
            {
                ReturnValue = _ExceptionErrorMessage;
                _Log.Debug("An exception occurred, details follow.", E1);
            }
            finally
            {
                Mgr.CloseAllSessions(CommitChanges);
            }

            return ReturnValue;
        }

        /// <summary>
        /// The format of the data table to be returned must be well established between the Flash application and
        /// the back-end service. The column names in particular are crucial because the Flash ActionScript code must
        /// use them to get at the elements.
        /// </summary>
        /// <returns>A DataTable in the particular format required for communications with the Flash application.</returns>
        private static DataTable CreateReturnTable()
        {
            DataTable ReturnValue = new DataTable("ItemTable");
            ReturnValue.Columns.Add("Item", typeof(string));
            ReturnValue.Columns.Add("Note", typeof(string));
            return ReturnValue;
        }

        /// <summary>
        /// Adds a string pair to the specified table in the format required for communications with the
        /// Flash application.
        /// </summary>
        /// <param name="Item">The item string to be added.</param>
        /// <param name="Note">The note string to be added for the item.</param>
        /// <param name="DestinationTable">The table to which the string pair should be added.</param>
        private static void AddRowToTable(string Item, string Note, DataTable DestinationTable)
        {
            DataRow NewRow = DestinationTable.NewRow();
            NewRow["Item"] = Item;
            NewRow["Note"] = Note;
            DestinationTable.Rows.Add(NewRow);
        }

        /// <summary>
        /// The possible status values for items attempting to be saved. Used by the <see cref="DataEntry.SaveDrItems"/> method.
        /// </summary>
        private enum DrItemStatus
        {
            /// <summary>
            /// The item both exists as a detail item for the bill-of-lading and is not already withdrawn.
            /// </summary>
            Valid,

            /// <summary>
            /// The item does not exist as a detail item for the bill-of-lading.
            /// </summary>
            Invalid,

            /// <summary>
            /// The item exists as a detail item for the bill-of-lading, but it is already marked as withdrawn.
            /// </summary>
            Withdrawn
        }

        /// <summary>
        /// Saves the provided set of items to the specified DR number, deleting any items already saved.
        /// </summary>
        /// <param name="DrId">DR ID for which the item IDs should be saved.</param>
        /// <param name="IdArray">Array of item IDs to be saved for the DR.</param>
        /// <returns>
        /// A data table, the contents of which depend upon the result. In the event that an error occurred which
        /// prevented validation of the items, a single row will be returned, the first column for which will contain
        /// the word "ERROR" while the second will contain the details. In the event that at least one of the item
        /// IDs provided was problematic, the complete list of items will be returned, IDs in the first column and a 
        /// status string in the second column. If everything went well, then a table with three rows will be returned;
        /// the first row/column will contain the word "SUCCESS", while the second and third rows will contain total
        /// count and weight values.
        /// </returns>
        public DataTable SaveDrItems(int DrId, ArrayList IdArray)
        {
            bool CommitChanges = false;
            SessionManager<string> Mgr = new SessionManager<string>();

            DataTable ReturnValue = CreateReturnTable();

            try
            {
                String AssemblyPath = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().CodeBase);
                string ConfigurationFileName = Path.Combine(AssemblyPath, _DwsNoRepData);
                ISession DwsNoRepData = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);

                HopsDrEntry NewDrEntry = DwsNoRepData.Get<HopsDrEntry>(DrId);
                if (NewDrEntry == null)
                {
                    AddRowToTable("ERROR", string.Format("DR ID {0} is invalid.", DrId), ReturnValue);
                }
                else
                {
                    int InvalidIdCount = 0;
                    string[] IdStrings = new string[IdArray.Count];
                    for (int I = 0; I < IdArray.Count; I++)
                    {
                        ASObject Aso = IdArray[I] as ASObject;
                        IdStrings[I] = Aso["Item"].ToString();
                    }

                    // Get the valid items for the bill of lading and whatever withdrawal records exist.

                    IList<BopsProjectManagerBillOfLadingDetail> ValidItems = DwsNoRepData.CreateCriteria(typeof(BopsProjectManagerBillOfLadingDetail))
                        .Add(Expression.Eq("BolRef", NewDrEntry.ProjectManagerBolRef))
                        .Add(Expression.In("ItemId", IdStrings))
                        .List<BopsProjectManagerBillOfLadingDetail>();

                    IList<BopsProjectManagerBillOfLadingDetailWithdrawal> Withdrawals = null;
                    if (ValidItems.Count > 0)
                    {
                        int?[] DetailIdInts = new int?[ValidItems.Count];
                        for (int I = 0; I < ValidItems.Count; I++)
                        {
                            DetailIdInts[I] = ValidItems[I].DetailId;
                        }
                        Withdrawals = DwsNoRepData.CreateCriteria(typeof (BopsProjectManagerBillOfLadingDetailWithdrawal))
                                .Add(Expression.In("DetailRef", DetailIdInts))
                                .List<BopsProjectManagerBillOfLadingDetailWithdrawal>();
                    }

                    // Now run through the strings, checking each to see if it exists and, if so, whether it is
                    // already listed in the withdrawal table. 

                    int TotalCount = 0;
                    double TotalWeight = 0.0;
                    List<HopsDrEntryItem> NewItems = new List<HopsDrEntryItem>();

                    foreach (string S in IdStrings)
                    {
                        DrItemStatus ItemStatus = DrItemStatus.Invalid;
                        HopsDrEntryItem NewItem = new HopsDrEntryItem();
                        NewItem.HopsDrRef = NewDrEntry.DrId;
                        NewItem.ItemId = S;

                        foreach (BopsProjectManagerBillOfLadingDetail Item in ValidItems)
                        {
                            if (string.Compare(S, Item.ItemId, true) == 0)
                            {
                                if (Item.Count.HasValue)
                                    TotalCount += Item.Count.Value;
                                if (Item.Weight.HasValue)
                                    TotalWeight += Item.Weight.Value;

                                NewItem.BopsBolDetailRef = Item.DetailId;
                                ItemStatus = DrItemStatus.Valid;

                                // If we have a list of withdrawals, check whether this item is withdrawn.

                                foreach (BopsProjectManagerBillOfLadingDetailWithdrawal Withdrawal in Withdrawals)
                                {
                                    if (Withdrawal.DetailRef.HasValue && (Withdrawal.DetailRef == Item.DetailId))
                                        ItemStatus = DrItemStatus.Withdrawn;
                                }

                                break;
                            }
                        }

                        AddRowToTable(S, ItemStatus.ToString(), ReturnValue);

                        if (ItemStatus == DrItemStatus.Valid)
                        {
                            NewItems.Add(NewItem);
                        }
                        else
                        {
                            InvalidIdCount++;
                        }
                    }

                    if (InvalidIdCount == 0)
                    {
                        // If we've made it this far, then we begin a transaction, delete any items that already exist
                        // for the DR, and write all the new items.

                        Mgr.BeginTransaction(_DwsNoRepData);

                        IList<HopsDrEntryItem> CurrentItems = DwsNoRepData.CreateCriteria(typeof (HopsDrEntryItem))
                            .Add(Expression.Eq("HopsDrRef", DrId))
                            .List<HopsDrEntryItem>();

                        foreach (HopsDrEntryItem Item in CurrentItems)
                            DwsNoRepData.Delete(Item);

                        foreach (HopsDrEntryItem Item in NewItems)
                            DwsNoRepData.Save(Item);

                        // If the database operations succeeded, we clear out the item ID/status pairs previously added 
                        // to the table and return the total count and weight.

                        ReturnValue.Rows.Clear();
                        AddRowToTable("SUCCESS", string.Empty, ReturnValue);
                        AddRowToTable("COUNT", TotalCount.ToString(), ReturnValue);
                        AddRowToTable("WEIGHT", Math.Round(TotalWeight, MidpointRounding.AwayFromZero).ToString(), ReturnValue);

                        CommitChanges = true;
                    }
                }
            }
            catch (Exception E1)
            {
                ReturnValue.Rows.Clear();
                AddRowToTable("ERROR", _ExceptionErrorMessage, ReturnValue);
                _Log.Debug("An exception occurred, details follow.", E1);
            }
            finally
            {
                Mgr.CloseAllSessions(CommitChanges);
            }

            return ReturnValue;
        }

        /// <summary>
        /// Takes a list of harbor DR items and generates corresponding rows in the supplied table, adding a
        /// textual status for each row indicating whether it is valid, invalid, or withdrawn. This method
        /// centralizes functionality shared by a couple of the public methods.
        /// </summary>
        /// <param name="DwsNoRepData">The database session to use for queries.</param>
        /// <param name="HopsDrItems">The list of harbor DR items to process.</param>
        /// <param name="ReturnValue">The data table to populate with the results.</param>
        private static void PopulateItemsTable(ISession DwsNoRepData, IList<HopsDrEntryItem>HopsDrItems, DataTable ReturnValue)
        {
            // Load up an array with the project manager detail IDs for use in a couple of queries.

            int[] BopsItemIds = new int[HopsDrItems.Count];
            for (int I = 0; I < HopsDrItems.Count; I++)
                BopsItemIds[I] = HopsDrItems[I].BopsBolDetailRef;

            IList<BopsProjectManagerBillOfLadingDetail> BopsDrItems = DwsNoRepData.CreateCriteria(typeof(BopsProjectManagerBillOfLadingDetail))
                .Add(Expression.In("DetailId", BopsItemIds))
                .List<BopsProjectManagerBillOfLadingDetail>();

            IList<BopsProjectManagerBillOfLadingDetailWithdrawal> Withdrawals = DwsNoRepData.CreateCriteria(typeof(BopsProjectManagerBillOfLadingDetailWithdrawal))
                .Add(Expression.In("DetailRef", BopsItemIds))
                .List<BopsProjectManagerBillOfLadingDetailWithdrawal>();

            foreach (HopsDrEntryItem Item in HopsDrItems)
            {
                DrItemStatus ItemStatus = DrItemStatus.Invalid;

                foreach (BopsProjectManagerBillOfLadingDetail BopsItem in BopsDrItems)
                {
                    if (Item.BopsBolDetailRef == BopsItem.DetailId)
                    {
                        ItemStatus = DrItemStatus.Valid;
                        break;
                    }
                }

                foreach (BopsProjectManagerBillOfLadingDetailWithdrawal Withdrawal in Withdrawals)
                {
                    if (Item.BopsBolDetailRef == Withdrawal.DetailRef)
                    {
                        ItemStatus = DrItemStatus.Withdrawn;
                        break;
                    }
                }

                AddRowToTable(Item.ItemId, ItemStatus.ToString(), ReturnValue);
            }
        }
        
        /// <summary>
        /// While methods/services that do more than one thing are generally a bad idea, the need to keep
        /// bandwidth consumption and round trips to a bare minimum justifies its use here. This method
        /// saves the supplied harbor DR entry and, if successful, returns any items that may already have
        /// been added to it. It allows the Flash application to transition from the DR entry scene to the
        /// DR item editing scene with a single call to the server, rather than two.
        /// </summary>
        /// <param name="Aso">The ActionScript object representing the harbor DR entry to be saved.</param>
        /// <returns>An array of item IDs already attached to the harbor DR.</returns>
        public DataTable SaveDrAndGetItsItems(ASObject Aso)
        {
            DataTable ReturnValue = CreateReturnTable();
            HopsDrEntry Hdr = RemotingTranslator.FlashToHopsDrEntry(Aso);
            string ErrorMessage = Save(Hdr);

            if (ErrorMessage == string.Empty)
            {
                SessionManager<string> Mgr = new SessionManager<string>();

                try
                {
                    string AssemblyPath = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().CodeBase);
                    string ConfigurationFileName = Path.Combine(AssemblyPath, _DwsNoRepData);
                    ISession DwsNoRepData = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);

                    IList<HopsDrEntryItem> HopsDrItems = DwsNoRepData.CreateCriteria(typeof(HopsDrEntryItem))
                        .Add(Expression.Eq("HopsDrRef", Hdr.DrId))
                        .List<HopsDrEntryItem>();

                    if (HopsDrItems.Count > 0)
                        PopulateItemsTable(DwsNoRepData, HopsDrItems, ReturnValue);
                }
                catch (Exception E)
                {
                    ReturnValue.Clear();
                    AddRowToTable("ERROR", _ExceptionErrorMessage, ReturnValue);
                    _Log.Error("An exception occurred, details follow.", E);
                }
                finally
                {
                    Mgr.CloseAllSessions(false);
                }
            }
            else
            {
                ReturnValue.Clear();
                AddRowToTable("ERROR", ErrorMessage, ReturnValue);
            }

            return ReturnValue;
        }

        /// <summary>
        /// Creates a datatable from the supplied enumerable DRs. The return format differs from the
        /// other method that creates a return table because the data to be returned is in a different
        /// format. The most important factor is that the column names differ from the column names
        /// everywhere else; this is because the data set is intended for use in a Flash datagrid. It
        /// saves headache on the Flash side, where it's more difficult to develop, simply to return
        /// the data with the column names that should appear in the final display.
        /// </summary>
        /// <param name="Drs">The enumerable set of DRs with which to populate the return table.</param>
        /// <returns>A data table populated with the supplied DRs, with column names intended for 
        /// display (and thus which don't correspond to the ASObject code elsewhere).</returns>
        private static DataTable CreateReturnTable(IEnumerable<HopsDrEntry> Drs)
        {
            DataTable ReturnValue = new DataTable("DrTable");
            ReturnValue.Columns.Add("DR", typeof(int));
            ReturnValue.Columns.Add("BL", typeof(int));
            ReturnValue.Columns.Add("CT", typeof(double));
            ReturnValue.Columns.Add("WT", typeof(double));
            ReturnValue.Columns.Add("Final", typeof(string));
            ReturnValue.Columns.Add("Pass", typeof(string));
            ReturnValue.Columns.Add("PUR", typeof(string));
            ReturnValue.Columns.Add("Tractor", typeof(string));

            foreach (HopsDrEntry Dr in Drs)
            {
                DataRow NewRow = ReturnValue.NewRow();

                NewRow["DR"] = Dr.DrId;
                NewRow["BL"] = Dr.ProjectManagerBolRef;
                if (Dr.Count.HasValue)
                    NewRow["CT"] = Dr.Count.Value;
                if (Dr.Weight.HasValue)
                    NewRow["WT"] = Dr.Weight.Value;
                NewRow["Final"] = Dr.Finalized ? "Y" : "N";
                NewRow["Pass"] = Dr.GatePass;
                NewRow["PUR"] = Dr.LoadRef;
                NewRow["Tractor"] = Dr.Tractor;

                ReturnValue.Rows.Add(NewRow);
            }

            return ReturnValue;
        }

        /// <summary>
        /// Retrieves the DRs whose last update times fall within the specified day.
        /// </summary>
        /// <param name="Day">Specifies the day for which DRs should be retrieved. Any time information will
        /// be ignored; i.e., all DRs from midnight of the day to just before midnight of the next day will
        /// be selected.</param>
        /// <returns>If an error occurs, a DataSet with an items table containing the error. If the method
        /// is successful, then a DataSet with the DR data is returned. If all goes well but no DRs are in
        /// the date range, a null value is returned.</returns>
        public DataSet GetDrsForDay(DateTime Day)
        {
            DataSet ReturnValue = null;
            DateTime BeginDate = Day.Date;
            DateTime EndDate = BeginDate.AddDays(1);
            SessionManager<string> Mgr = new SessionManager<string>();

            try
            {
                string AssemblyPath = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().CodeBase);
                string ConfigurationFileName = Path.Combine(AssemblyPath, _DwsNoRepData);
                ISession DwsNoRepData = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);

                IList<HopsDrEntry> Drs = DwsNoRepData.CreateCriteria(typeof(HopsDrEntry))
                    .Add(Expression.Ge("LastUpdateTime", BeginDate))
                    .Add(Expression.Lt("LastUpdateTime", EndDate))
                    .List<HopsDrEntry>();

                if (Drs.Count > 0)
                {
                    ReturnValue = new DataSet("Drs");
                    ReturnValue.Tables.Add(CreateReturnTable(Drs));
                }
            }
            catch (Exception E)
            {
                _Log.Error("An exception occurred, details follow.", E);
                DataTable ErrorTable = CreateReturnTable();
                AddRowToTable("ERROR", _ExceptionErrorMessage, ErrorTable);
                ReturnValue = new DataSet("Errors");
                ReturnValue.Tables.Add(ErrorTable);
            }
            finally
            {
                Mgr.CloseAllSessions(false);
            }

            return ReturnValue;
        }
    }
}
