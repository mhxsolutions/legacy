using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using BopsDataAccess;
using NHibernate.Criterion;
using log4net;
using NHibernate;

namespace AgilisCore
{
    public class AgilisSynchronizer
    {
        private static readonly ILog Log = LogManager.GetLogger(typeof(AgilisSynchronizer));

        #region Fields

        private List<AgilisOperationFilter> _filters;
        private List<AgilisDriverPlanControl> _driverPlanControls;
        private string _signaturesFolder;
        private AgilisEventHandler _eventHandler;
        private readonly ISession _session;
        #endregion

        #region Properties

        public string AgilisRestUrl { get; set; }
        public string AgilisRestCompany { get; set; }
        public string UserId { get; set; }
        public string Password { get; set; }
        public string DatabaseConnectionString { get; set; }
        public bool ReadAgilisDataFromFile { get; set; }

        public List<AgilisOperationFilter> Filters
        {
            get { return _filters; }
            set { _filters = value; }
        }

        public string SignaturesFolder
        {
            get { return _signaturesFolder; }
            set { _signaturesFolder = value; }
        }

        public List<AgilisDriverPlanControl> DriverPlanControls
        {
            get { return _driverPlanControls; }
            set { _driverPlanControls = value; }
        }

        public AgilisEventHandler EventHandler
        {
            get { return _eventHandler; }
            set { _eventHandler = value; }
        }

        public bool SimulationOnly { get; set; }

        #endregion

        #region Construction
        public AgilisSynchronizer(string agilisRestUrl, string agilisRestCompany, string userId, string password, 
            string databaseConnectionString, ISession databaseSession, bool simulationOnly)
        {
            AgilisRestUrl = agilisRestUrl;
            AgilisRestCompany = agilisRestCompany;
            UserId = userId;
            Password = password;
            DatabaseConnectionString = databaseConnectionString;
            _session = databaseSession;

            _filters = new List<AgilisOperationFilter>();
            _driverPlanControls = new List<AgilisDriverPlanControl>();
            _signaturesFolder = "";
            SimulationOnly = simulationOnly;
        }   
        #endregion

        #region Helper Methods
        private static string GetReaderString(IDataRecord reader, string fieldName)
        {
            try
            {
                return reader[fieldName].ToString();
            }
            catch (Exception e)
            {
                Log.ErrorFormat("Could not retrieve field {0} from data reader.", fieldName);
                Log.Error("Exception details follow.", e);
            }

            return string.Empty;
        }

        private static int GetReaderInteger(IDataRecord reader, string fieldName)
        {
            try
            {
                return Convert.ToInt32(reader[fieldName]);
            }
            catch (Exception e)
            {
                Log.ErrorFormat("Could not retrieve field {0} from data reader.", fieldName);
                Log.Error("Exception details follow.", e);
            }

            return 0;
        }

        private static DateTime GetReaderDateTime(IDataRecord reader, string fieldName, bool convertToUtc)
        {
            try
            {
                DateTime returnValue = Convert.ToDateTime(reader[fieldName]);
                if (convertToUtc)
                    returnValue = AgilisUtilities.LocalTimeToAgilisTime(returnValue);
                return returnValue;
            }
            catch (Exception e)
            {
                Log.ErrorFormat("Could not retrieve field {0} from data reader.", fieldName);
                Log.Error("Exception details follow.", e);
            }

            return DateTime.MinValue;
        }

        private static AgilisWorkOrder GetWorkOrderFromReader(IDataRecord reader, bool dateTimesToUtc)
        {
            var returnValue = new AgilisWorkOrder
                                  {
                                      WorkOrderNumber = GetReaderString(reader, "Work Order"),
                                      DisplayWorkOrderNumber = GetReaderString(reader, "Display Work Order"),
                                      WorkOrderGroup = GetReaderString(reader, "Work Order Group"),
                                      DriverNumber = GetReaderInteger(reader, "Driver Ref"),
                                      SlotStartDate = GetReaderDateTime(reader, "Plan Date", dateTimesToUtc),
                                      CustomerFirstName = GetReaderString(reader, "Destination"),
                                      CustomerStreetAddress1 = GetReaderString(reader, "Dest Add1"),
                                      CustomerStreetAddress2 = GetReaderString(reader, "Dest Add2"),
                                      CustomerCity = GetReaderString(reader, "Dest City"),
                                      CustomerState = GetReaderString(reader, "Dest ST"),
                                      CustomerZipCode = GetReaderString(reader, "Dest Zip"),
                                      PickupFirstName = GetReaderString(reader, "Origin"),
                                      PickupStreetAddress1 = GetReaderString(reader, "Origin Address 1"),
                                      PickupStreetAddress2 = GetReaderString(reader, "Origin Address 2"),
                                      PickupCity = GetReaderString(reader, "Origin City"),
                                      PickupState = GetReaderString(reader, "Origin State"),
                                      PickupZipCode = GetReaderString(reader, "Origin Zip"),
                                      Notes = GetReaderString(reader, "Notes"),
                                      Sequence = GetReaderInteger(reader, "Order"),
                                      PlannerDetailId = GetReaderInteger(reader, "Planner Detail ID"),
                                      OriginId = GetReaderInteger(reader, "Origin ID"),
                                      DestinationId = GetReaderInteger(reader, "Destination ID"),
                                      LoadRef = GetReaderString(reader, "Load Ref"),
                                      Trailer = GetReaderString(reader, "Trailer"),
                                      ScheduledArrive = GetReaderDateTime(reader, "Scheduled Arrive", dateTimesToUtc)
                                  };

            var temporary = new AgilisWorkOrderJob();
            temporary.AgilisJobType = GetReaderString(reader, "Task");
            returnValue.Jobs.Add(temporary);

            return returnValue;
        }

        public List<AgilisWorkOrder> GetDailyPlanWorkOrdersToProcess(DateTime begin, DateTime end, bool dateTimesToUtc,
            DateTime planDateToProcess)
        {
            var currentTime = DateTime.Now;
            List<AgilisWorkOrder> returnValue = GetDailyPlanWorkOrders(begin, end, dateTimesToUtc);

            if (_driverPlanControls.Count > 0)
            {
                var driversToExclude = new Dictionary<int, int>();

                foreach (AgilisDriverPlanControl control in _driverPlanControls)
                {
                    foreach (AgilisWorkOrder t in returnValue)
                    {
                        if (control.DriverRef == t.DriverNumber)
                        {
                            bool excludeDriver = false;

                            switch (control.UploadStrategy)
                            {
                                case AgilisDriverPlanControl.UploadStrategyType.AtHour:
                                    excludeDriver = (currentTime < planDateToProcess.AddHours(control.UploadHour));
                                    break;
                                case AgilisDriverPlanControl.UploadStrategyType.AtHoursBeforeStartTime:
                                    if (control.StartTime.HasValue)
                                        excludeDriver = (currentTime < control.StartTime.Value.AddHours(-control.UploadHour));
                                    else
                                        excludeDriver = true;
                                    break;
                            }

                            if (excludeDriver && !driversToExclude.ContainsKey(control.DriverRef))
                            {
                                Log.InfoFormat("Driver plan controls excluding driver ID {0}", control.DriverRef);
                                driversToExclude.Add(control.DriverRef, 0);
                            }
                        }
                    }
                }

                for (int i = 0; i < returnValue.Count;)
                {
                    if (driversToExclude.ContainsKey(returnValue[i].DriverNumber))
                        returnValue.RemoveAt(i);
                    else
                        i++;
                }
            }

            return returnValue;
        }

        public List<AgilisWorkOrder> GetDailyPlanWorkOrders(DateTime begin, DateTime end, bool dateTimesToUtc)
        {
            var workOrders = new List<AgilisWorkOrder>();

            using (var connection = new SqlConnection(DatabaseConnectionString))
            {
                connection.Open();

                using (var command = new SqlCommand("AgilisExportDailyPlan", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@BeginDate", SqlDbType.DateTime).Value = begin;
                    command.Parameters.Add("@EndDate", SqlDbType.DateTime).Value = end;

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                            workOrders.Add(GetWorkOrderFromReader(reader, dateTimesToUtc));

                        reader.Close();
                    }
                }

                connection.Close();
            }

            return workOrders;
        }

        List<int> GetAgilisWorkOrderIdsRemovedFromPlanner(DateTime beginDate, DateTime endDate)
        {
            // TODO: update this SQL if we need to cancel rejected orders someday and actually can cancel things.

            const string SqlFormat = "SELECT AWO.[Work Order Id] FROM [Agilis Imported Work Orders] AS AWO " +
                                     "LEFT OUTER JOIN [Planner Detail] AS PD ON AWO.[Planner Detail Ref] = PD.[Planner Detail ID] " +
                                     "WHERE PD.[Planner Detail ID] IS NULL AND AWO.[Current Status] != 'CAN' AND AWO.[Current Status] != 'REJ' " +
                                     "AND '{0}' <= AWO.[Slot Start Date] AND AWO.[Slot Start Date] < '{1}'";

            var returnValue = new List<int>();
            var sql = string.Format(SqlFormat, beginDate.ToString("d"), endDate.ToString("d"));

            using (var connection = new SqlConnection(DatabaseConnectionString))
            {
                connection.Open();

                using (var command = new SqlCommand(sql, connection))
                {
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                            returnValue.Add(Convert.ToInt32(reader["Work Order Id"]));

                        reader.Close();
                    }
                }

                connection.Close();
            }

            return returnValue;
        }

        private List<AgilisWorkOrder> GetWorkOrdersRemovedFromPlanner(DateTime utcBeginDate, DateTime utcEndDate)
        {
            var returnValue = new List<AgilisWorkOrder>();
            var localBeginDate = AgilisUtilities.AgilisTimeToLocalTime(utcBeginDate);
            var localEndDate = AgilisUtilities.AgilisTimeToLocalTime(utcEndDate);
            var ordersToCancel = GetAgilisWorkOrderIdsRemovedFromPlanner(localBeginDate, localEndDate);

            if (ordersToCancel.Count > 0)
            {
                var doomedWorkOrders = _session.CreateCriteria(typeof(AgilisWorkOrder))
                    .Add(Expression.In("WorkOrderId", ordersToCancel))
                    .List();

                returnValue.AddRange(doomedWorkOrders.Cast<AgilisWorkOrder>());
            }

            return returnValue;
        }

        private static List<AgilisIntegrationOperation> WrapResultInList(AgilisIntegrationOperation result)
        {
            var returnValue = new List<AgilisIntegrationOperation>();
            returnValue.Add(result);
            return returnValue;
        }

        private List<AgilisIntegrationOperation> Import(AgilisDataTypes DataType, DateTime UtcBeginDate, DateTime UtcEndDate, string RawDataFileName, IAgilisStatusInterface StatusCallback)
        {
            AgilisSqlImporter Importer = new AgilisSqlImporter(AgilisRestUrl, AgilisRestCompany);
            Importer.ReadAgilisDataFromFile = ReadAgilisDataFromFile;
            Importer.Filters = GetFilterSubset(AgilisOperationTypes.Import);
            Importer.SignaturesFolder = _signaturesFolder;
            Importer.EventHandler = _eventHandler;
            Importer.Session = _session;

            switch (DataType)
            {
                case AgilisDataTypes.Drivers:
                    return WrapResultInList(Importer.ImportDrivers(UserId, Password, RawDataFileName, StatusCallback));
                case AgilisDataTypes.DriverEvents:
                    return WrapResultInList(Importer.ImportDriverEvents(UserId, Password, UtcBeginDate, UtcEndDate, RawDataFileName, StatusCallback));
                case AgilisDataTypes.DriverPositions:
                    return WrapResultInList(Importer.ImportDriverPositions(UserId, Password, UtcBeginDate, UtcEndDate, RawDataFileName, StatusCallback));
                case AgilisDataTypes.WorkOrders:
                    return WrapResultInList(Importer.ImportWorkOrders(UserId, Password, UtcBeginDate, UtcEndDate, RawDataFileName, StatusCallback));
                case AgilisDataTypes.WorkOrderSignatures:
                    return WrapResultInList(Importer.ImportWorkOrderSignatures(UserId, Password, UtcBeginDate, UtcEndDate, RawDataFileName, StatusCallback));
                default:
                    throw new ArgumentException(string.Format("Unsupported data type: {0}", DataType));
            }
        }

        private List<AgilisIntegrationOperation> ImportFull(AgilisDataTypes DataType, DateTime UtcPlanDate, string RawDataFileName, IAgilisStatusInterface StatusCallback)
        {
            AgilisSqlImporter Importer = new AgilisSqlImporter(AgilisRestUrl, AgilisRestCompany);
            Importer.ReadAgilisDataFromFile = ReadAgilisDataFromFile;
            Importer.Filters = GetFilterSubset(AgilisOperationTypes.Import);
            Importer.SignaturesFolder = _signaturesFolder;
            Importer.EventHandler = _eventHandler;
            Importer.Session = _session;

            switch (DataType)
            {
                case AgilisDataTypes.WorkOrders:
                    return WrapResultInList(Importer.ImportDailyPlan(UserId, Password, UtcPlanDate, RawDataFileName, StatusCallback));
                default:
                    throw new ArgumentException(string.Format("Unsupported data type: {0}", DataType));
            }
        }

        private List<AgilisIntegrationOperation> ExportFullWorkOrders(DateTime UtcBeginDate, DateTime UtcEndDate, IAgilisStatusInterface StatusCallback)
        {
            AgilisExporter Exporter = new AgilisExporter(AgilisRestUrl, AgilisRestCompany, AgilisExportMode.Add, false, SimulationOnly);
            DateTime LocalBeginDate = AgilisUtilities.AgilisTimeToLocalTime(UtcBeginDate);
            DateTime LocalEndDate = AgilisUtilities.AgilisTimeToLocalTime(UtcEndDate);
            List<AgilisWorkOrder> WorkOrders = GetDailyPlanWorkOrdersToProcess(LocalBeginDate, LocalEndDate, true, LocalBeginDate.Date);
            return WrapResultInList(Exporter.ExportWorkOrders(WorkOrders, UserId, Password, StatusCallback));
        }

        private bool FilterWorkOrder(IEnumerable<AgilisOperationFilter> OperationFilters, AgilisWorkOrder WorkOrder)
        {
            foreach (AgilisOperationFilter Filter in OperationFilters)
            {
                if (Filter.MatchFilter(typeof(AgilisWorkOrder), WorkOrder))
                {
                    Log.InfoFormat("Synchronizer filter triggered: {0}", Filter);
                    return true;
                }
            }

            return false;
        }

        private static bool NotesHaveChanged(AgilisWorkOrder OldWorkOrder, AgilisWorkOrder NewWorkOrder)
        {
            string OldNotes = OldWorkOrder.Notes ?? string.Empty;
            string NewNotes = NewWorkOrder.Notes ?? string.Empty;
            return string.Compare(OldNotes, NewNotes) != 0;
        }

        private List<AgilisIntegrationOperation> ExportUpdateWorkOrders(DateTime UtcBeginDate, DateTime UtcEndDate, IAgilisStatusInterface StatusCallback)
        {
            List<AgilisIntegrationOperation> ReturnList = new List<AgilisIntegrationOperation>();
            AgilisIntegrationOperation ReturnValue = new AgilisIntegrationOperation(AgilisDataTypes.WorkOrders, AgilisOperationTypes.ExportUpdate);
            List<AgilisWorkOrder> WorkOrdersToReactivate = new List<AgilisWorkOrder>();
            List<AgilisWorkOrder> WorkOrdersToCancel = GetWorkOrdersRemovedFromPlanner(UtcBeginDate, UtcEndDate);
            List<AgilisWorkOrder> WorkOrdersToUpdate = new List<AgilisWorkOrder>();
            List<AgilisWorkOrder> WorkOrdersToAdd = new List<AgilisWorkOrder>();
            DateTime LocalBeginDate = AgilisUtilities.AgilisTimeToLocalTime(UtcBeginDate);
            DateTime LocalEndDate = AgilisUtilities.AgilisTimeToLocalTime(UtcEndDate);
            List<AgilisWorkOrder> WorkOrders = GetDailyPlanWorkOrdersToProcess(LocalBeginDate, LocalEndDate, false, LocalBeginDate.Date);
            List<AgilisOperationFilter> SynchronizeFilters = GetFilterSubset(AgilisOperationTypes.ExportUpdate);

            StringCollection StatusCodesToIgnore = new StringCollection();
            StatusCodesToIgnore.Add("CAN");
            StatusCodesToIgnore.Add("REJ");

            foreach (AgilisWorkOrder WorkOrder in WorkOrders)
            {
                if (FilterWorkOrder(SynchronizeFilters, WorkOrder))
                    continue;

                IList<AgilisWorkOrder> AgilisWorkOrderList = _session.CreateCriteria(typeof(AgilisWorkOrder))
                    .Add(Expression.Eq("PlannerDetailId", WorkOrder.PlannerDetailId))
                    .Add(Expression.Eq("SlotStartDate", WorkOrder.SlotStartDate))
                    .List<AgilisWorkOrder>();

                AgilisWorkOrder CompareTarget = null;
                if (AgilisWorkOrderList.Count == 0)
                {
                    Log.InfoFormat("Planner detail ID {0} for driver {1}, work order number {2}, not found in Agilis; queueing upload.",
                                    WorkOrder.PlannerDetailId, WorkOrder.DriverNumber, WorkOrder.WorkOrderNumber);
                    WorkOrdersToAdd.Add(WorkOrder);
                    ReturnValue.RecordsSuccessful++;
                    continue;
                }
                else if (AgilisWorkOrderList.Count == 1)
                {
                    CompareTarget = AgilisWorkOrderList[0];
                }
                else
                {
                    /*
                     * NB: It's possible for there to be more than one record in the Agilis work order
                     *     table with the given parameters. This can happen if the sequence number or
                     *     load was changed on a planner detail line, because that will result in the
                     *     prior work order number being cancelled. We need to find the compare target.
                     */

                    Log.DebugFormat("{0} possible matches found in Agilis tables for planner detail ID {1}, driver {2}, work order num {3}.",
                                     AgilisWorkOrderList.Count, WorkOrder.PlannerDetailId, WorkOrder.DriverNumber, WorkOrder.WorkOrderNumber);

                    foreach (AgilisWorkOrder awo in AgilisWorkOrderList)
                    {
                        if (StatusCodesToIgnore.Contains(awo.CurrentStatus))
                            continue;

                        if (CompareTarget != null)
                        {
                            Log.WarnFormat("More than one work order comparison target for planner detail ID {0}. Was using Agilis work order ID {1}, choosing {2} instead.",
                                            WorkOrder.PlannerDetailId, CompareTarget.WorkOrderId, awo.WorkOrderId);
                            ReturnValue.WarningCount++;
                        }

                        CompareTarget = awo;
                    }

                    if (CompareTarget == null)
                    {
                        Log.ErrorFormat("Could not determine Agilis compare target for planner detail ID {0}, driver {1}, work order num {2}. Skipping it.",
                                         WorkOrder.PlannerDetailId, WorkOrder.DriverNumber, WorkOrder.WorkOrderNumber);
                        ReturnValue.ErrorCount++;
                        continue;
                    }
                }

                if (CompareTarget.CurrentStatus == "CMP")
                {
                    Log.DebugFormat("Planner detail ID {0} processing halted; work order number {1} already complete.",
                        WorkOrder.PlannerDetailId, WorkOrder.WorkOrderNumber);
                    ReturnValue.WarningCount++;
                    continue;
                }

                Log.DebugFormat("Comparing planner detail ID {0}, driver {1}, work order num {2} to Agilis work order ID {3}.",
                                 WorkOrder.PlannerDetailId, WorkOrder.DriverNumber, WorkOrder.WorkOrderNumber, CompareTarget.WorkOrderId);

                // I do not believe the first case can occur anymore, but I'm leaving the code in place until I'm more confident.

                if (string.Compare(WorkOrder.WorkOrderNumber, CompareTarget.WorkOrderNumber, false) != 0)
                {
                    Log.InfoFormat("Planner detail ID {0} for driver {1}: work order changed from {2} to {3}; queueing cancel and add.",
                                    CompareTarget.PlannerDetailId, CompareTarget.DriverNumber, CompareTarget.WorkOrderNumber, WorkOrder.WorkOrderNumber);

                    // In order for a cancel to succeed, the work order must have its job data. Thus,
                    // we load it from the database before adding it to the cancel list.

                    CompareTarget.Jobs = GetWorkOrderJobs(CompareTarget.WorkOrderId);
                    WorkOrdersToCancel.Add(CompareTarget);
                    WorkOrdersToAdd.Add(WorkOrder);
                }
                else if (WorkOrder.OriginId != CompareTarget.OriginId || WorkOrder.DestinationId != CompareTarget.DestinationId)
                {
                    Log.InfoFormat("Planner detail ID {0} for driver {1}: O/D pair have changed from {2}/{3} to {4}/{5}; queueing update.",
                                    CompareTarget.PlannerDetailId, CompareTarget.DriverNumber, CompareTarget.OriginId, CompareTarget.DestinationId,
                                    WorkOrder.OriginId, WorkOrder.DestinationId);
                    WorkOrdersToUpdate.Add(WorkOrder);
                }

                // Whereas previously we caught changes in the load or sequence by the changes in the work order number,
                // we must now catch them explicitly and update instead of cancel and add.

                else if (WorkOrder.LoadRef != CompareTarget.LoadRef || WorkOrder.Sequence != CompareTarget.Sequence)
                {
                    Log.InfoFormat("Planner detail ID {0} for driver {1}: load ({2}/{3}) or sequence changed ({4}/{5}); queueing update.",
                        CompareTarget.PlannerDetailId, CompareTarget.DriverNumber, CompareTarget.LoadRef, WorkOrder.LoadRef,
                        CompareTarget.Sequence, WorkOrder.Sequence);
                    WorkOrdersToUpdate.Add(WorkOrder);
                }

                // Lastly, we update the work order if the notes have changed. Because the notes field is concatenated from
                // the planner notes field and the client notes, this will respond to changes in either.

                else if (NotesHaveChanged(CompareTarget, WorkOrder))
                {
                    Log.InfoFormat("Planner detail ID {0} for driver {1}: notes changed from {2} to {3}; queueing update.",
                        CompareTarget.PlannerDetailId, CompareTarget.DriverNumber, CompareTarget.Notes, WorkOrder.Notes);
                    WorkOrdersToUpdate.Add(WorkOrder);
                }

                // If we've made it this far, then we don't need to do anything.
                
                else
                {
                    Log.Debug("No differences found that require further processing.");
                }

                ReturnValue.RecordsSuccessful++;
            }

            /*
             * In order to avoid creating duplicate work orders, we need to check any work order
             * on the add list to see if it is either in the cancel list or already cancelled (or
             * rejected for that matter). If we find the work order in either of those places,
             * then we need to take the appropriate steps to turn it into an update instead.
             */

            for (int i = 0; i < WorkOrdersToAdd.Count; /* COUNTER UPDATED IN LOOP */ )
            {
                bool ChangedToUpdate = false;

                for (int j = 0; (j < WorkOrdersToCancel.Count) && !ChangedToUpdate; j++)
                {
                    if (WorkOrdersToAdd[i].WorkOrderNumber == WorkOrdersToCancel[j].WorkOrderNumber)
                    {
                        Log.InfoFormat("Work order {0} was found in the cancel list; removing from cancel list and moving from add to update.", WorkOrdersToAdd[i].WorkOrderNumber);
                        WorkOrdersToUpdate.Add(WorkOrdersToAdd[i]);
                        WorkOrdersToCancel.RemoveAt(j);
                        WorkOrdersToAdd.RemoveAt(i);
                        ChangedToUpdate = true;
                    }
                }

                if (!ChangedToUpdate)
                {
                    IList<AgilisWorkOrder> AgilisWorkOrderList = _session.CreateCriteria(typeof(AgilisWorkOrder))
                        .Add(Expression.Eq("WorkOrderNumber", WorkOrdersToAdd[i].WorkOrderNumber))
                        .List<AgilisWorkOrder>();

                    if (AgilisWorkOrderList.Count > 0)
                    {
                        Log.InfoFormat("Work order {0} was found in the Agilis import tables; reactivating (if needed) and moving from add to update.", WorkOrdersToAdd[i].WorkOrderNumber);
                        WorkOrdersToReactivate.Add(WorkOrdersToAdd[i]);
                        WorkOrdersToUpdate.Add(WorkOrdersToAdd[i]);
                        WorkOrdersToAdd.RemoveAt(i);
                        ChangedToUpdate = true;
                    }
                }

                if (!ChangedToUpdate)
                    i++;
            }

            // The synchronization work is essentially done. Make a log entry and mark it finished.

            ReturnValue.Notes = string.Format("Synchronizer has decided to cancel {0}, update {1}, and add {2} work orders.",
                                              WorkOrdersToCancel.Count, WorkOrdersToUpdate.Count, WorkOrdersToAdd.Count);
            ReturnValue.Successful = true;
            ReturnValue.EndDate = DateTime.Now;
            ReturnList.Add(ReturnValue);
            Log.Info(ReturnValue.Notes);

            // Now, we can finally take the actual steps to synchronize Agilis.

            AgilisExporter Exporter = new AgilisExporter(AgilisRestUrl, AgilisRestCompany, AgilisExportMode.Update, true, SimulationOnly);

            if (WorkOrdersToReactivate.Count > 0)
            {
                Log.InfoFormat("Synchronizer will now reactivate {0} work orders.", WorkOrdersToReactivate.Count);
                ReturnList.Add(Exporter.ReactivateWorkOrders(WorkOrdersToReactivate, UserId, Password, StatusCallback));
            }
            if (WorkOrdersToCancel.Count > 0)
            {
                Log.InfoFormat("Synchronizer will now cancel {0} work orders.", WorkOrdersToCancel.Count);
                ReturnList.Add(Exporter.CancelWorkOrders(WorkOrdersToCancel, UserId, Password, StatusCallback));
            }
            if (WorkOrdersToUpdate.Count > 0)
            {
                Log.InfoFormat("Synchronizer will now update {0} work orders.", WorkOrdersToUpdate.Count);
                ReturnList.Add(Exporter.ExportWorkOrders(WorkOrdersToUpdate, UserId, Password, StatusCallback));
            }
            if (WorkOrdersToAdd.Count > 0)
            {
                Log.InfoFormat("Synchronizer will now add {0} work orders.", WorkOrdersToAdd.Count);
                Exporter.ExportMode = AgilisExportMode.Add;
                ReturnList.Add(Exporter.ExportWorkOrders(WorkOrdersToAdd, UserId, Password, StatusCallback));
            }

            return ReturnList;
        }

        private List<AgilisWorkOrderJob> GetWorkOrderJobs(int WorkOrderId)
        {
            IList<AgilisWorkOrderJob> JobList = _session.CreateCriteria(typeof(AgilisWorkOrderJob))
                .Add(Expression.Eq("WorkOrderRef", WorkOrderId))
                .List<AgilisWorkOrderJob>();

            List<AgilisWorkOrderJob> ReturnValue = new List<AgilisWorkOrderJob>();
            foreach (AgilisWorkOrderJob Job in JobList)
            {
                ReturnValue.Add(Job);
            }

            if (ReturnValue.Count == 0)
                Log.WarnFormat("Could not load work order jobs for work order ID {0}.", WorkOrderId);

            return ReturnValue;
        }

        List<AgilisOperationFilter> GetFilterSubset(AgilisOperationTypes Operation)
        {
            List<AgilisOperationFilter> ReturnValue = new List<AgilisOperationFilter>();

            if (_filters.Count > 0)
            {
                foreach (AgilisOperationFilter Filter in _filters)
                {
                    if (Filter.FilterScope == Operation)
                        ReturnValue.Add(Filter);
                }
            }

            return ReturnValue;
        }
        #endregion

        #region Routing Methods
        private List<AgilisIntegrationOperation> ExportFull(AgilisDataTypes DataType, DateTime UtcBeginDate, DateTime UtcEndDate, IAgilisStatusInterface StatusCallback)
        {
            switch (DataType)
            {
                case AgilisDataTypes.WorkOrders:
                    return ExportFullWorkOrders(UtcBeginDate, UtcEndDate, StatusCallback);

                default:
                    throw new ArgumentException(string.Format("Unsupported data type: {0}", DataType));
            }
        }

        private List<AgilisIntegrationOperation> ExportUpdate(AgilisDataTypes DataType, DateTime UtcBeginDate, DateTime UtcEndDate, IAgilisStatusInterface StatusCallback)
        {
            switch (DataType)
            {
                case AgilisDataTypes.WorkOrders:
                    return ExportUpdateWorkOrders(UtcBeginDate, UtcEndDate, StatusCallback);
                case AgilisDataTypes.Drivers:
                    return ExportUpdateDrivers(StatusCallback);

                default:
                    throw new ArgumentException(string.Format("Unsupported data type: {0}", DataType));
            }
        }

        private List<AgilisIntegrationOperation> ExportUpdateDrivers(IAgilisStatusInterface StatusCallback)
        {
            List<AgilisIntegrationOperation> ReturnValue = new List<AgilisIntegrationOperation>();
            List<AgilisDriver> DriversToAdd = new List<AgilisDriver>();
            IList<BopsDriver> AgilisDrivers = _session.CreateCriteria(typeof(BopsDriver))
                .Add(Expression.Eq("Agilis", true))
                .List<BopsDriver>();

            foreach (BopsDriver BopsRecord in AgilisDrivers)
            {
                AgilisDriver AgilisRecord = _session.Get<AgilisDriver>(BopsRecord.DriverId);
                if (AgilisRecord != null)
                    Log.DebugFormat("Matched driver ID {0} from BOPS to Agilis.", AgilisRecord.DriverId);
                else
                    DriversToAdd.Add(new AgilisDriver(BopsRecord));
            }

            if (DriversToAdd.Count > 0)
            {
                Log.InfoFormat("Synchronizer has decided to add {0} drivers.", DriversToAdd.Count);
                AgilisExporter Exporter = new AgilisExporter(AgilisRestUrl, AgilisRestCompany, AgilisExportMode.Add, true, SimulationOnly);
                ReturnValue.Add(Exporter.ExportDrivers(DriversToAdd, UserId, Password, StatusCallback));
            }
            
            return ReturnValue;
        }

        #endregion

        public List<AgilisIntegrationOperation> Synchronize(AgilisDataTypes DataType, AgilisOperationTypes Operation,
            DateTime LocalBeginDate, DateTime LocalEndDate, string RawDataFileName, IAgilisStatusInterface StatusCallback)
        {
            DateTime UtcBeginDate = AgilisUtilities.LocalTimeToAgilisTime(LocalBeginDate);
            DateTime UtcEndDate = AgilisUtilities.LocalTimeToAgilisTime(LocalEndDate);

            switch (Operation)
            {
                case AgilisOperationTypes.Import:
                    return Import(DataType, UtcBeginDate, UtcEndDate, RawDataFileName, StatusCallback);
                case AgilisOperationTypes.ImportFull:
                    return ImportFull(DataType, UtcBeginDate, RawDataFileName, StatusCallback);
                case AgilisOperationTypes.ExportFull:
                    return ExportFull(DataType, UtcBeginDate, UtcEndDate, StatusCallback);
                case AgilisOperationTypes.ExportUpdate:
                    return ExportUpdate(DataType, UtcBeginDate, UtcEndDate, StatusCallback);

                default:
                    throw new ArgumentException(string.Format("Unsupported operation: {0}", Operation));
            }
        }

        public List<AgilisIntegrationOperation> FinalizePlan(DateTime PlanDate, string RawDataFileName, IAgilisStatusInterface StatusCallback)
        {
            DateTime SafePlanDate = PlanDate.Date;
            AgilisIntegrationOperation FinalizeOperation = new AgilisIntegrationOperation(AgilisDataTypes.WorkOrders, AgilisOperationTypes.CancelFull);
            FinalizeOperation.PlanDate = SafePlanDate;

            Dictionary<int,int> DriversWithCustomPlanHandling = new Dictionary<int, int>();
            foreach (AgilisDriverPlanControl control in _driverPlanControls)
            {
                DriversWithCustomPlanHandling.Add(control.DriverRef, 0);
            }

            AgilisQuery Query = new AgilisQuery(AgilisRestUrl, AgilisRestCompany);
            List<AgilisWorkOrder> WorkOrders = Query.GetWorkOrdersByPlanDate(UserId, Password, SafePlanDate, RawDataFileName, StatusCallback);
            List<AgilisWorkOrder> DoomedList = new List<AgilisWorkOrder>();

            if (WorkOrders.Count > 0)
            {
                StringCollection StatusCodesToIgnore = new StringCollection();
                StatusCodesToIgnore.Add("CAN");
                StatusCodesToIgnore.Add("REJ");
                StatusCodesToIgnore.Add("CMP");

                foreach (AgilisWorkOrder WorkOrder in WorkOrders)
                {
                    if ((WorkOrder.SlotStartDate == SafePlanDate) && 
                        !StatusCodesToIgnore.Contains(WorkOrder.CurrentStatus) &&
                        !DriversWithCustomPlanHandling.ContainsKey(WorkOrder.DriverNumber))
                    {
                        DoomedList.Add(WorkOrder);
                    }
                }
            }

            FinalizeOperation.Notes = string.Format("Finalizer has found {0} orders out of {1} need cancellation.", DoomedList.Count, WorkOrders.Count);

            if (DoomedList.Count > 0)
            {
                AgilisExporter Exporter = new AgilisExporter(AgilisRestUrl, AgilisRestCompany, AgilisExportMode.Update, true, SimulationOnly);
                AgilisIntegrationOperation CancelOperation = Exporter.CancelWorkOrders(DoomedList, UserId, Password, StatusCallback);

                /*
                 * Don't log the cancel operation. The reasons are that (1) we don't want to
                 * clutter up the table, and (2) we want only one full cancel operation on file
                 * for each day in order to decide intelligently when next to perform one. I
                 * was originally double-logging, and because the second cancel operation would
                 * have the wrong plan date, it was preventing finalization from working properly.
                 * So, rather than logging the cancel operation, we merely copy the more salient
                 * fields from its result into the overall finalize result object.
                 */

                FinalizeOperation.ErrorCount = CancelOperation.ErrorCount;
                FinalizeOperation.WarningCount = CancelOperation.WarningCount;
                FinalizeOperation.RecordsSuccessful = CancelOperation.RecordsSuccessful;
                FinalizeOperation.RecordsFailed = CancelOperation.RecordsFailed;
            }

            List<AgilisIntegrationOperation> ReturnValue = new List<AgilisIntegrationOperation>();
            ReturnValue.Add(FinalizeOperation);
            FinalizeOperation.Successful = (FinalizeOperation.ErrorCount == 0);
            FinalizeOperation.EndDate = DateTime.Now;

            return ReturnValue;
        }
    }
}
