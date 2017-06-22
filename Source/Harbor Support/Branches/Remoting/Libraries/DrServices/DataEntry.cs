using System;
using System.Collections.Generic;
using System.IO;
using BopsDataAccess;
using FlashGateway.IO;
using log4net;
using NHibernate;
using NHibernate.Expression;
using NHibernateUtilities;

namespace DrServices
{
    public class DataEntry
    {
        // NB: the NHibernate configuration file is in the directory above the assembly because
        // this is a web application (i.e., the assembly is in the /bin folder.

        private const string _DwsNoRepData = "../NHibernateDwsNoRepData.xml.config";
        private static readonly ILog _Log = LogManager.GetLogger(typeof(DataEntry));

        private string ServerValidation(ISession DwsNoRepData, HopsDrEntry Hdr)
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

            if (Hdr.LoadRef != null && Hdr.LoadRef.Length > 0)
            {
                BopsLoad Load = DwsNoRepData.Get<BopsLoad>(Hdr.LoadRef);
                if (Load == null)
                    ReturnValue += "Pickup request doesn't exist. ";
            }

            return ReturnValue;
        }

        private string Save(HopsDrEntry Hdr)
        {
            bool CommitChanges = false;
            SessionManager<string> Mgr = new SessionManager<string>();
            string ErrorString;

            try
            {
                String AssemblyPath = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().CodeBase);
                string ConfigurationFileName = Path.Combine(AssemblyPath, _DwsNoRepData);
                ISession DwsNoRepData = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);

                ErrorString = ServerValidation(DwsNoRepData, Hdr);
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
                        NewDrEntry.Weight = Hdr.Weight; // NB: the class should throw an exception if the weight is out of range.
                        NewDrEntry.LastUpdateTime = DateTime.Now;
                        NewDrEntry.GatePass = Hdr.GatePass;
                        NewDrEntry.LoadRef = Hdr.LoadRef;
                        NewDrEntry.Tractor = Hdr.Tractor;

                        // If we're supposed to finalize the record, then it's time to migrate the data to the
                        // main [Project Manager DR] table for further processing.

                        if (Hdr.Finalized)
                        {
                            BopsLoad Load = DwsNoRepData.Get<BopsLoad>(NewDrEntry.LoadRef);
                            IList<BopsProjectManagerDr> LoadDrs = DwsNoRepData.CreateCriteria(typeof(BopsProjectManagerDr))
                                .Add(Expression.Eq("LoadKeyRef", Load.LoadKey))
                                .List<BopsProjectManagerDr>();

                            if (LoadDrs.Count > 0)
                            {
                                DwsNoRepData.SaveOrUpdateCopy(NewDrEntry);
                                ErrorString = "CONFIRMLOAD";    // Special value to indicate that the load needs to be confirmed.
                            }
                            else
                            {
                                BopsProjectManagerDr Pmdr = DwsNoRepData.Get<BopsProjectManagerDr>(Hdr.DrId);
                                Pmdr.Count = NewDrEntry.Count;
                                Pmdr.Weight = NewDrEntry.Weight;
                                Pmdr.LoadKeyRef = Load.LoadKey;
                                Pmdr.GatePass = NewDrEntry.GatePass;
                                DwsNoRepData.Update(Pmdr);

                                NewDrEntry.Finalized = Hdr.Finalized;
                                DwsNoRepData.SaveOrUpdateCopy(NewDrEntry);
                            }
                        }
                        else
                        {
                            DwsNoRepData.SaveOrUpdateCopy(NewDrEntry);
                        }

                        CommitChanges = true;
                    }
                }
            }
            catch (Exception e1)
            {
                ErrorString = "An exception occurred. Please notify IT support.";
                _Log.Debug("An exception occured, details follow.", e1);
            }
            finally
            {
                Mgr.CloseAllSessions(CommitChanges);
            }

            return ErrorString;
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
            catch (Exception e)
            {
                _Log.Debug("An exception occured, details follow.", e);
            }
            finally
            {
                Mgr.CloseAllSessions(false);
            }

            return null;
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
            string ReturnValue = string.Empty;

            try
            {
                String AssemblyPath = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().CodeBase);
                string ConfigurationFileName = Path.Combine(AssemblyPath, _DwsNoRepData);
                ISession DwsNoRepData = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);
                Mgr.BeginTransaction(_DwsNoRepData);

                HopsDrEntry DrEntry = DwsNoRepData.Get<HopsDrEntry>(DrId);

                BopsLoad Load = DwsNoRepData.Get<BopsLoad>(DrEntry.LoadRef);
                BopsProjectManagerDr Pmdr = DwsNoRepData.Get<BopsProjectManagerDr>(DrId);
                Pmdr.Count = DrEntry.Count;
                Pmdr.Weight = DrEntry.Weight;
                Pmdr.LoadKeyRef = Load.LoadKey;
                Pmdr.GatePass = DrEntry.GatePass;
                DwsNoRepData.Update(Pmdr);

                DrEntry.Finalized = true;
                DwsNoRepData.SaveOrUpdateCopy(DrEntry);

                CommitChanges = true;
            }
            catch (Exception e1)
            {
                ReturnValue = "An exception occurred. Please notify IT support.";
                _Log.Debug("An exception occured, details follow.", e1);
            }
            finally
            {
                Mgr.CloseAllSessions(CommitChanges);
            }

            return ReturnValue;
        }
    }
}
