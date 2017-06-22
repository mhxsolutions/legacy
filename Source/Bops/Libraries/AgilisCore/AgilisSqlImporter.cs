using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Xml;
using NHibernate.Criterion;
using log4net;
using NHibernate;

namespace AgilisCore
{
    public class AgilisSqlImporter
    {
        private static readonly ILog _Log = LogManager.GetLogger(typeof(AgilisSqlImporter));

        #region Fields
        private string _AgilisRestUrl;                  // Base URL of Agilis REST API
        private string _AgilisRestCompany;              // Company ID to use for Agilis REST API
        private bool _ReadAgilisDataFromFile;           // Read from file, rather than downloading from Agilis?
        private bool _TransactionEachRecord;            // Use one transaction per record, not global commit/rollback?
        private List<AgilisOperationFilter> _Filters;   // Filters for importing data
        private string _SignaturesFolder;               // Folder in which work order signatures should be placed
        private bool _ImportSignaturesIndividually;     // Query signatures individually with each work order?
        private AgilisEventHandler _EventHandler;       // Notification callbacks (if set)
        private ISession _Session;                      // Database session to use for import
        #endregion

        #region Construction
        public AgilisSqlImporter()
        {
            _Filters = new List<AgilisOperationFilter>();
            _SignaturesFolder = string.Empty;
        }
        #endregion

        #region Properties
        public string AgilisRestUrl
        {
            get { return _AgilisRestUrl; }
            set { _AgilisRestUrl = value; }
        }

        public string AgilisRestCompany
        {
            get { return _AgilisRestCompany; }
            set { _AgilisRestCompany = value; }
        }

        public bool ReadAgilisDataFromFile
        {
            get { return _ReadAgilisDataFromFile; }
            set { _ReadAgilisDataFromFile = value; }
        }

        public bool TransactionEachRecord
        {
            get { return _TransactionEachRecord; }
            set { _TransactionEachRecord = value; }
        }

        public List<AgilisOperationFilter> Filters
        {
            get { return _Filters; }
            set { _Filters = value; }
        }

        public string SignaturesFolder
        {
            get { return _SignaturesFolder; }
            set { _SignaturesFolder = value; }
        }

        public bool ImportSignaturesIndividually
        {
            get { return _ImportSignaturesIndividually; }
            set { _ImportSignaturesIndividually = value; }
        }

        public AgilisEventHandler EventHandler
        {
            get { return _EventHandler; }
            set { _EventHandler = value; }
        }

        public ISession Session
        {
            get { return _Session; }
            set { _Session = value; }
        }

        #endregion

        #region Construction
        public AgilisSqlImporter(string _AgilisRestUrl, string _AgilisRestCompany)
        {
            this._AgilisRestUrl = _AgilisRestUrl;
            this._AgilisRestCompany = _AgilisRestCompany;
            _ReadAgilisDataFromFile = false;
            _TransactionEachRecord = true;
        }
        #endregion

        #region Helper Methods

        private void ImportWorkOrderJobs(AgilisWorkOrder WorkOrder, AgilisIntegrationOperation Operation)
        {
            foreach (AgilisWorkOrderJob Job in WorkOrder.Jobs)
            {
                Job.WorkOrderRef = WorkOrder.WorkOrderId;

                IList JobList = _Session.CreateCriteria(typeof (AgilisWorkOrderJob))
                    .Add(Expression.Eq("AgilisJobId", Job.AgilisJobId))
                    .List();

                if (JobList.Count > 0)
                {
                    if (JobList.Count > 1)
                    {
                        Debug.Assert(false);
                        Operation.WarningCount++;
                        _Log.WarnFormat("More than one work order job on file with Agilis job ID {0}, using number {1}.",
                            Job.AgilisJobId, JobList.Count);
                    }

                    Job.WorkOrderJobId = ((AgilisWorkOrderJob) (JobList[JobList.Count - 1])).WorkOrderJobId;

                    _Log.DebugFormat("Updating work order job Agilis ID {0}, work order job ID {1}.", Job.AgilisJobId,
                                     Job.WorkOrderJobId);
                    _Session.Merge(Job);
                }
                else
                {
                    _Log.DebugFormat("Importing work order job Agilis ID {0}...", Job.AgilisJobId);
                    _Session.Save(Job);
                    _Log.DebugFormat("New work order job ID {0}.", Job.WorkOrderJobId);
                }

                ImportWorkOrderJobHistory(Job, Operation);
            }
        }

        private void ImportWorkOrderJobHistory(AgilisWorkOrderJob Job, AgilisIntegrationOperation Operation)
        {
            foreach (AgilisWorkOrderJobStatusHistory Entry in Job.History)
            {
                Entry.WorkOrderJobRef = Job.WorkOrderJobId;

                IList EntryList = _Session.CreateCriteria(typeof(AgilisWorkOrderJobStatusHistory))
                    .Add(Expression.Eq("WorkOrderJobRef", Entry.WorkOrderJobRef))
                    .Add(Expression.Eq("AgilisJobStatus", Entry.AgilisJobStatus))
                    .Add(Expression.Eq("Timestamp", Entry.Timestamp))
                    .List();
               
                if (EntryList.Count > 0)
                {
                    if (EntryList.Count > 1)
                    {
                        Debug.Assert(false);
                        Operation.WarningCount++;
                        _Log.WarnFormat("More than one work order job history entry on file for work order job ID {0} with status {1} at {2}, using number {3}.",
                            Entry.WorkOrderJobRef, Entry.AgilisJobStatus, Entry.Timestamp.ToString("G"), EntryList.Count);
                    }

                    Entry.WorkOrderJobStatusHistoryId =
                        ((AgilisWorkOrderJobStatusHistory) (EntryList[EntryList.Count - 1])).WorkOrderJobStatusHistoryId;
                    _Log.DebugFormat("Updating work order job history, status {0} at {1}, work order job history ID {2}.", Entry.AgilisJobStatus, Entry.Timestamp.ToString("G"), Entry.WorkOrderJobStatusHistoryId);
                    _Session.Merge(Entry);
                }
                else
                {
                    _Log.DebugFormat("Importing work order job history, status {0} at {1}...", Entry.AgilisJobStatus, Entry.Timestamp.ToString("G"));
                    _Session.Save(Entry);
                    _Log.DebugFormat("New work order job history ID {0}.", Entry.WorkOrderJobStatusHistoryId);
                }
            }
        }

        // The return value is as follows:
        //
        //  0   The operation failed
        //  <0  The work order was imported as new data
        //  >0  The work order was updated

        private int ImportWorkOrder(AgilisWorkOrder WorkOrder, AgilisIntegrationOperation Operation)
        {
            if (EventHandler != null && EventHandler.WorkOrderImportNotifier != null)
            {
                if (!EventHandler.WorkOrderImportNotifier.BeforeImport(WorkOrder))
                    return 0;
            }

            int ReturnValue;
            ValidateWorkOrder(WorkOrder);
            IList<AgilisWorkOrder> WorkOrderList = _Session.CreateCriteria(typeof(AgilisWorkOrder))
                .Add(Expression.Eq("WorkOrderNumber", WorkOrder.WorkOrderNumber))
                .Add(Expression.Eq("SlotStartDate", WorkOrder.SlotStartDate))
                .List<AgilisWorkOrder>();

            ImportMode Mode;
            if (WorkOrderList.Count > 0)
            {
                if (WorkOrderList.Count > 1)
                {
                    Debug.Assert(false);
                    Operation.WarningCount++;
                    _Log.WarnFormat("More than one work order number {0} found for slot start date {1}, using number {2}.",
                        WorkOrder.WorkOrderNumber, WorkOrder.SlotStartDate, WorkOrderList.Count);
                }

                WorkOrder.WorkOrderId = WorkOrderList[WorkOrderList.Count - 1].WorkOrderId;
                _Log.DebugFormat("Updating work order number {0}, work order ID {1}.", WorkOrder.WorkOrderNumber, WorkOrder.WorkOrderId);

                // Once the trailer number has been recorded, we don't want to change it. This allows it to be corrected
                // manually after the fact if needed without being overwritten.

                if (WorkOrderList[WorkOrderList.Count - 1].Trailer != null && WorkOrderList[WorkOrderList.Count - 1].Trailer != string.Empty)
                    WorkOrder.Trailer = WorkOrderList[WorkOrderList.Count - 1].Trailer;

                _Session.Merge(WorkOrder);
                ReturnValue = WorkOrder.WorkOrderId;
                Mode = ImportMode.Update;
            }
            else
            {
                _Log.DebugFormat("Importing work order number {0}...", WorkOrder.WorkOrderNumber);
                _Session.Save(WorkOrder);
                _Log.DebugFormat("New work order ID {0}.", WorkOrder.WorkOrderId);
                ReturnValue = -WorkOrder.WorkOrderId;
                Mode = ImportMode.Add;
            }

            ImportWorkOrderJobs(WorkOrder, Operation);

            if (EventHandler != null && EventHandler.WorkOrderImportNotifier != null)
            {
                EventHandler.WorkOrderImportNotifier.AfterImport(WorkOrder, Mode);
            }

            return ReturnValue;
        }

        // This method is a quick hack to make sure we're not putting bad data in the database.
        private void ValidateWorkOrder(AgilisWorkOrder WorkOrder)
        {
            if ((WorkOrder.Sequence == 0) || 
                (WorkOrder.PlannerDetailId == 0) || 
                (WorkOrder.OriginId == 0) ||
                (WorkOrder.DestinationId == 0) ||
                (WorkOrder.LoadRef == null || WorkOrder.LoadRef == ""))
            {
                string Details = string.Format(
                        "sequence = {0}, planner detail ID = {1}, origin ID = {2}, destination ID = {3}, load reference = {4}",
                        WorkOrder.Sequence, WorkOrder.PlannerDetailId, WorkOrder.OriginId, WorkOrder.DestinationId,
                        WorkOrder.LoadRef);
                _Log.WarnFormat("Work order number {0} has invalid data, throwing exception.", WorkOrder.WorkOrderNumber);

                throw new ArgumentException("Work order has unacceptable null values", Details);
            }
        }       

        List<AgilisOperationFilter> GetImportFiltersSubset(AgilisDataTypes DataType)
        {
            List<AgilisOperationFilter> ReturnValue = new List<AgilisOperationFilter>();

            if (_Filters.Count > 0)
            {
                foreach (AgilisOperationFilter Filter in _Filters)
                {
                    if (Filter.FilterScope == AgilisOperationTypes.Import && Filter.DataType == DataType)
                        ReturnValue.Add(Filter);
                }
            }

            return ReturnValue;
        }
        #endregion

        public AgilisIntegrationOperation WorkOrderImportCore(string RestApiMethod, AgilisOperationTypes OperationType,
            string UserId, string Password, DateTime StartTime, DateTime EndTime, string AgilisRawDataFileName,
            IAgilisStatusInterface StatusCallback)
        {
            Debug.Assert(_AgilisRestUrl != null && _AgilisRestUrl != string.Empty);
            Debug.Assert(_AgilisRestCompany != null && _AgilisRestCompany != string.Empty);

            AgilisIntegrationOperation ReturnValue = new AgilisIntegrationOperation(AgilisDataTypes.WorkOrders, OperationType);

            Dictionary<string, string> Parameters = new Dictionary<string, string>();
            IAgilisStatusInterface Status = StatusCallback ?? new AgilisStatusSink();
            List<AgilisOperationFilter> WorkOrderFilters = GetImportFiltersSubset(AgilisDataTypes.WorkOrders);

            try
            {
                ITransaction NHibernateTransaction = null;
                if (!TransactionEachRecord)
                    NHibernateTransaction = _Session.BeginTransaction();

                if (!ReadAgilisDataFromFile)
                {
                    string StartTimeParam = StartTime.ToString("s");
                    string EndTimeParam = EndTime.ToString("s");
                    Parameters.Add("start_time", StartTimeParam);
                    Parameters.Add("end_time", EndTimeParam);

                    Status.ProgressUpdate("Querying data from Agilis system...", "", 0, 0);
                    AgilisDataReader WorkOrderReader = new AgilisDataReader(_AgilisRestUrl, _AgilisRestCompany, UserId, Password, false);
                    WorkOrderReader.CallAgilisRestApiMethod(RestApiMethod, Parameters, AgilisRawDataFileName);
                }

                Status.ProgressUpdate("Parsing Agilis data...", "", 0, 0);
                AgilisWorkOrderParser WorkOrderParser = new AgilisWorkOrderParser();
                List<AgilisWorkOrder> WorkOrders = WorkOrderParser.ParseWorkOrders(AgilisRawDataFileName, WorkOrderFilters, Status, ReturnValue);

                if (WorkOrders.Count > 0)
                {
                    foreach (AgilisWorkOrder WorkOrder in WorkOrders)
                    {
                        bool Success = false;
                        Status.ProgressUpdate(String.Format("Processing work order {0}", WorkOrder.WorkOrderNumber), "", 0, 0);

                        if (TransactionEachRecord)
                            NHibernateTransaction = _Session.BeginTransaction();

                        try
                        {
                            int ImportResult = ImportWorkOrder(WorkOrder, ReturnValue);
                            _Log.DebugFormat("Work order {0} import result is {1}.", WorkOrder.WorkOrderId, ImportResult);

                            // Only try to import the signature if individual importing is enabled and the
                            // relevant data conditions are met for so doing.

                            if (ImportSignaturesIndividually &&
                                (!ReadAgilisDataFromFile && (SignaturesFolder != null && SignaturesFolder.Length > 0)))
                            {
                                ImportWorkOrderSignature(WorkOrder, UserId, Password, ReturnValue, Status);
                            }

                            ReturnValue.RecordsSuccessful++;
                            Success = true;
                        }
                        catch (Exception e)
                        {
                            ReturnValue.ErrorCount++;
                            ReturnValue.RecordsFailed++;
                            _Log.Error("An exception occurred while importing work order; details follow.", e);
                        }

                        if (TransactionEachRecord)
                        {
                            if (Success)
                                NHibernateTransaction.Commit();
                            else
                                NHibernateTransaction.Rollback();
                        }
                    }

                    if (TransactionEachRecord)
                    {
                        if (ReturnValue.RecordsFailed == 0)
                            ReturnValue.Successful = true;
                    }
                    else
                    {
                        if (ReturnValue.ErrorCount == 0)
                        {
                            ReturnValue.Successful = true;
                            NHibernateTransaction.Commit();
                        }
                        else
                        {
                            NHibernateTransaction.Rollback();
                        }
                    }
                }
                else
                {
                    _Log.Info("No work orders were returned from parsing Agilis data.");
                    ReturnValue.Successful = true;
                }
            }
            catch (Exception e)
            {
                ReturnValue.ErrorCount++;
                _Log.Error("An exception occurred while importing work orders; details follow.", e);
            }

            if (ReturnValue.ErrorCount > 0)
            {
                Status.ProgressUpdate("An error occurred; check the log for details.", "", 0, 0);
            }
            else
            {
                Status.ProgressUpdate("Done", "", 0, 0);
                ReturnValue.Successful = true;
            }

            ReturnValue.EndDate = DateTime.Now;
            return ReturnValue;
        }

        public AgilisIntegrationOperation ImportDailyPlan(string UserId, string Password, DateTime PlanDate, 
            string AgilisRawDataFileName, IAgilisStatusInterface StatusCallback)
        {
            /*
             * Because the REST API method to retrieve work orders by plan date does not properly compare
             * start and end times (i.e., begin <= plan date < end), we have to add a minute to the end 
             * time in order to get the correct results.
             */

            return WorkOrderImportCore("workOrders/listBySlotStartDate", AgilisOperationTypes.ImportFull, UserId, Password, 
                PlanDate, PlanDate.AddMinutes(1), AgilisRawDataFileName, StatusCallback);
        }

        public AgilisIntegrationOperation ImportWorkOrders(string UserId, string Password, DateTime StartTime, DateTime EndTime, 
            string AgilisRawDataFileName, IAgilisStatusInterface StatusCallback)
        {
            return WorkOrderImportCore("workOrders/listByEditDate", AgilisOperationTypes.Import, UserId, Password, 
                StartTime, EndTime, AgilisRawDataFileName, StatusCallback);

            // The following is the "old" way of doing things, prior to Agilis' deploying its new 
            // service to query by edit date, which seems to be getting updtaed whenever we change
            // a work order.

            //return WorkOrderImportCore("workOrders/list", AgilisOperationTypes.Import, UserId, Password, 
            //    StartTime, EndTime, AgilisRawDataFileName, StatusCallback);
        }

        private void ImportWorkOrderSignature(AgilisWorkOrder WorkOrder, string UserId, string Password, 
            AgilisIntegrationOperation Operation, IAgilisStatusInterface Status)
        {
            const string RestApiMethod = "smartForms/listByWorkOrder";
            Dictionary<string, string> Parameters = new Dictionary<string, string>();
            Parameters.Add("wo_number", WorkOrder.WorkOrderNumber);
            Parameters.Add("image_format", "png");  // TODO: put this in the app.config or somewhere else more mutable

            string Response;
            Status.ProgressUpdate(string.Format("Querying signature for work order {0} from Agilis system...", WorkOrder.WorkOrderNumber), "", 0, 0);
            AgilisDataReader AgilisReader = new AgilisDataReader(_AgilisRestUrl, _AgilisRestCompany, UserId, Password, false);
            AgilisReader.CallAgilisRestApiMethod(RestApiMethod, Parameters, out Response);

            List<AgilisSignature> Signatures = ProcessSignatureResponse(Response, Status, Operation);
            foreach (AgilisSignature Signature in Signatures)
            {
                Signature.Folder = Path.Combine(SignaturesFolder, Signature.Timestamp.ToString("yyyy-MM-dd"));
                if (!Directory.Exists(Signature.Folder))
                    Directory.CreateDirectory(Signature.Folder);
                Signature.SetWorkOrderDetails(WorkOrder);
                Signature.WriteSignatureFile();

                IList SignatureList = _Session.CreateCriteria(typeof(AgilisSignature))
                    .Add(Expression.Eq("WorkOrderRef", WorkOrder.WorkOrderId))
                    .Add(Expression.Eq("Timestamp", Signature.Timestamp))
                    .Add(Expression.Eq("Number", Signature.Number))
                    .List();

                if (SignatureList.Count > 0)
                {
                    if (SignatureList.Count > 1)
                    {
                        Debug.Assert(false);
                        _Log.WarnFormat("More than one signature found for work order {0} at {1}.", WorkOrder.WorkOrderNumber, Signature.Timestamp);
                    }

                    Signature.SignatureId = ((AgilisSignature)SignatureList[SignatureList.Count - 1]).SignatureId;
                    _Session.Merge(Signature);
                }
                else
                {
                    _Session.Save(Signature);    
                }
            }
        }

        private List<AgilisSignature> ProcessSignatureResponse(string Response, IAgilisStatusInterface Status, AgilisIntegrationOperation Operation)
        {
            try
            {
                XmlDocument Document = new XmlDocument();
                Document.InnerXml = Response;
                //Old Parser based on old REST URI
                //AgilisSignatureParser Parser = new AgilisSignatureParser();
                //List<AgilisSignature> ReturnValue = Parser.ParseSignatures(Document, Status, Operation);
                //130129
                AgilisWorkOrderSignatureParser AgilisParser = new AgilisWorkOrderSignatureParser();
                List<AgilisSignature> ReturnValue = AgilisParser.ParseSignatures(Document, Status, null);
                return ReturnValue;
            }
            catch (Exception e)
            {
                Operation.WarningCount++;
                _Log.Error("An exception occurred while processing a signature; details follow.", e);
            }

            return null;
        }

        public AgilisIntegrationOperation ImportDriverPositions(string UserId, string Password, DateTime StartTime, DateTime EndTime, 
            string AgilisRawDataFileName, IAgilisStatusInterface StatusCallback)
        {
            AgilisIntegrationOperation ReturnValue = new AgilisIntegrationOperation(AgilisDataTypes.DriverPositions, AgilisOperationTypes.Import);
            const string RestApiMethod = "drivers/positions";
            Dictionary<string, string> Parameters = new Dictionary<string, string>();

            IAgilisStatusInterface Status = StatusCallback ?? new AgilisStatusSink();

            try
            {
                ITransaction NHibernateTransaction = _Session.BeginTransaction();
            
                if (!ReadAgilisDataFromFile)
                {
                    string StartTimeParam = StartTime.ToString("s");
                    string EndTimeParam = EndTime.ToString("s");
                    Parameters.Add("start_time", StartTimeParam);
                    Parameters.Add("end_time", EndTimeParam);

                    Status.ProgressUpdate("Querying data from Agilis system...", "", 0, 0);
                    AgilisDataReader AgilisReader = new AgilisDataReader(_AgilisRestUrl, _AgilisRestCompany, UserId, Password, false);
                    AgilisReader.CallAgilisRestApiMethod(RestApiMethod, Parameters, AgilisRawDataFileName);
                }

                Status.ProgressUpdate("Parsing Agilis data...", "", 0, 0);
                AgilisDriverPositionParser AgilisParser = new AgilisDriverPositionParser();
                List<AgilisDriverPosition> Positions = AgilisParser.ParseDriverPositions(AgilisRawDataFileName, Status, ReturnValue);

                foreach (AgilisDriverPosition DriverPosition in Positions)
                {
                    Status.ProgressUpdate(String.Format("Processing driver position for driver {0} at {1}...", DriverPosition.DriverId, DriverPosition.Timestamp), "", 0, 0);

                    IList DriverPositionList = _Session.CreateCriteria(typeof(AgilisDriverPosition))
                        .Add(Expression.Eq("DriverId", DriverPosition.DriverId))
                        .Add(Expression.Eq("Timestamp", DriverPosition.Timestamp))
                        .List();

                    if (DriverPositionList.Count > 0)
                    {
                        if (DriverPositionList.Count > 1)
                        {
                            Debug.Assert(false);
                            ReturnValue.WarningCount++;
                            _Log.WarnFormat("More than one driver position found for driver {0} at {1}.", DriverPosition.DriverId, DriverPosition.Timestamp);
                        }

                        DriverPosition.DriverPositionId = ((AgilisDriverPosition)DriverPositionList[DriverPositionList.Count - 1]).DriverPositionId;
                        _Session.Merge(DriverPosition);
                    }
                    else
                    {
                        _Session.Save(DriverPosition);
                    }

                    ReturnValue.RecordsSuccessful++;
                }
            
                NHibernateTransaction.Commit();
                ReturnValue.Successful = true;
            }
            catch (Exception e)
            {
                ReturnValue.ErrorCount++;
                _Log.Error("An exception occurred while importing driver positions; details follow.", e);
            }

            if (ReturnValue.ErrorCount > 0)
            {
                Status.ProgressUpdate("An error occurred; check the log for details.", "", 0, 0);
            }
            else
            {
                Status.ProgressUpdate("Done", "", 0, 0);
                ReturnValue.Successful = true;
            }

            ReturnValue.EndDate = DateTime.Now;
            return ReturnValue;
        }

        public AgilisIntegrationOperation ImportDriverEvents(string UserId, string Password, DateTime StartTime, DateTime EndTime, 
            string AgilisRawDataFileName, IAgilisStatusInterface StatusCallback)
        {
            AgilisIntegrationOperation ReturnValue = new AgilisIntegrationOperation(AgilisDataTypes.DriverEvents, AgilisOperationTypes.Import);
            const string RestApiMethod = "drivers/events";
            Dictionary<string, string> Parameters = new Dictionary<string, string>();
            IAgilisStatusInterface Status = StatusCallback ?? new AgilisStatusSink();

            try
            {
                ITransaction NHibernateTransaction = _Session.BeginTransaction();

                if (!ReadAgilisDataFromFile)
                {
                    string StartTimeParam = StartTime.ToString("s");
                    string EndTimeParam = EndTime.ToString("s");
                    Parameters.Add("start_time", StartTimeParam);
                    Parameters.Add("end_time", EndTimeParam);

                    Status.ProgressUpdate("Querying data from Agilis system...", "", 0, 0);
                    AgilisDataReader AgilisReader = new AgilisDataReader(_AgilisRestUrl, _AgilisRestCompany, UserId, Password, false);
                    AgilisReader.CallAgilisRestApiMethod(RestApiMethod, Parameters, AgilisRawDataFileName);
                }

                Status.ProgressUpdate("Parsing Agilis data...", "", 0, 0);
                AgilisDriverEventParser AgilisParser = new AgilisDriverEventParser();
                List<AgilisDriverEvent> DriverEvents = AgilisParser.ParseDriverEvents(AgilisRawDataFileName, Status, ReturnValue);

                foreach (AgilisDriverEvent DriverEvent in DriverEvents)
                {
                    Status.ProgressUpdate(String.Format("Processing driver event {0} for driver {1} at {2}...", DriverEvent.DriverEventCode, DriverEvent.DriverId, DriverEvent.Timestamp), "", 0, 0);

                    IList DriverEventList = _Session.CreateCriteria(typeof(AgilisDriverEvent))
                        .Add(Expression.Eq("DriverId", DriverEvent.DriverId))
                        .Add(Expression.Eq("DriverEventCode", DriverEvent.DriverEventCode))
                        .Add(Expression.Eq("Timestamp", DriverEvent.Timestamp))
                        .List();

                    if (DriverEventList.Count > 0)
                    {
                        if (DriverEventList.Count > 1)
                        {
                            Debug.Assert(false);
                            ReturnValue.WarningCount++;
                            _Log.WarnFormat("More than one driver event found for driver {0} at {1}.", DriverEvent.DriverId, DriverEvent.Timestamp);
                        }

                        DriverEvent.DriverEventId =((AgilisDriverEvent) DriverEventList[DriverEventList.Count - 1]).DriverEventId;
                        _Session.Merge(DriverEvent);
                    }
                    else
                    {
                        _Session.Save(DriverEvent);
                    }

                    ReturnValue.RecordsSuccessful++;
                }

                NHibernateTransaction.Commit();
                ReturnValue.Successful = true;
            }
            catch (Exception e)
            {
                ReturnValue.ErrorCount++;
                _Log.Error("An exception occurred while importing driver events; details follow.", e);
            }

            if (ReturnValue.ErrorCount > 0)
            {
                Status.ProgressUpdate("An error occurred; check the log for details.", "", 0, 0);
            }
            else
            {
                Status.ProgressUpdate("Done", "", 0, 0);
                ReturnValue.Successful = true;
            }

            ReturnValue.EndDate = DateTime.Now;
            return ReturnValue;
        }

        public AgilisIntegrationOperation ImportDrivers(string UserId, string Password, string AgilisRawDataFileName, 
            IAgilisStatusInterface StatusCallback)
        {
            AgilisIntegrationOperation ReturnValue = new AgilisIntegrationOperation(AgilisDataTypes.Drivers, AgilisOperationTypes.Import);
            const string RestApiMethod = "drivers/list";
            Dictionary<string, string> Parameters = new Dictionary<string, string>();

            IAgilisStatusInterface Status = StatusCallback ?? new AgilisStatusSink();

            try
            {
                ITransaction NHibernateTransaction = _Session.BeginTransaction();

                if (!ReadAgilisDataFromFile)
                {
                    Status.ProgressUpdate("Querying data from Agilis system...", "", 0, 0);
                    AgilisDataReader AgilisReader = new AgilisDataReader(_AgilisRestUrl, _AgilisRestCompany, UserId, Password, false);
                    AgilisReader.CallAgilisRestApiMethod(RestApiMethod, Parameters, AgilisRawDataFileName);
                }

                Status.ProgressUpdate("Parsing Agilis data...", "", 0, 0);
                AgilisDriverParser AgilisParser = new AgilisDriverParser();
                List<AgilisDriver> Drivers = AgilisParser.ParseDrivers(AgilisRawDataFileName, Status, ReturnValue);

                foreach (AgilisDriver Driver in Drivers)
                {
                    Status.ProgressUpdate(String.Format("Processing driver {0}...", Driver.DriverId), "", 0, 0);

                    AgilisDriver RecordToUpdate = _Session.Get<AgilisDriver>(Driver.DriverId);
                    if (RecordToUpdate != null)
                    {
                        Driver.DriverId = RecordToUpdate.DriverId;
                        _Log.InfoFormat("Updating driver {0} ({1} {2}).", Driver.DriverId, Driver.FirstName, Driver.LastName);
                        _Session.Merge(Driver);
                    }
                    else
                    {
                        _Log.InfoFormat("Importing driver {0} ({1} {2}).", Driver.DriverId, Driver.FirstName, Driver.LastName);
                        _Session.Save(Driver);
                    }

                    ReturnValue.RecordsSuccessful++;
                }

                NHibernateTransaction.Commit();
            }
            catch (Exception e)
            {
                ReturnValue.ErrorCount++;
                _Log.Error("An exception occurred while importing drivers; details follow.", e);
            }

            if (ReturnValue.ErrorCount > 0)
            {
                Status.ProgressUpdate("An error occurred; check the log for details.", "", 0, 0);
            }
            else
            {
                Status.ProgressUpdate("Done", "", 0, 0);
                ReturnValue.Successful = true;
            }

            ReturnValue.EndDate = DateTime.Now;
            return ReturnValue;
        }

        public AgilisIntegrationOperation ImportWorkOrderSignatures(string UserId, string Password, DateTime StartTime, 
            DateTime EndTime, string AgilisRawDataFileName, IAgilisStatusInterface StatusCallback)
        {
            Debug.Assert(_AgilisRestUrl != null && _AgilisRestUrl != string.Empty);
            Debug.Assert(_AgilisRestCompany != null && _AgilisRestCompany != string.Empty);
            Debug.Assert((_SignaturesFolder != null && _SignaturesFolder != string.Empty));

            AgilisIntegrationOperation ReturnValue = new AgilisIntegrationOperation(AgilisDataTypes.WorkOrderSignatures, AgilisOperationTypes.Import);

            const string RestApiMethod = "smartForms/listByDateRange";
            Dictionary<string, string> Parameters = new Dictionary<string, string>();
            IAgilisStatusInterface Status = StatusCallback ?? new AgilisStatusSink();

            try
            {
                if (!ReadAgilisDataFromFile)
                {
                    string StartTimeParam = StartTime.ToString("s");
                    string EndTimeParam = EndTime.ToString("s");
                    Parameters.Add("start_time", StartTimeParam);
                    Parameters.Add("end_time", EndTimeParam);
                    Parameters.Add("image_format", "png");  // TODO: put this in the app.config or somewhere else more mutable

                    Status.ProgressUpdate("Querying data from Agilis system...", "", 0, 0);
                    AgilisDataReader AgilisReader = new AgilisDataReader(_AgilisRestUrl, _AgilisRestCompany, UserId, Password, false);
                    AgilisReader.CallAgilisRestApiMethod(RestApiMethod, Parameters, AgilisRawDataFileName);
                }

                Status.ProgressUpdate("Parsing Agilis data...", "", 0, 0);
                AgilisWorkOrderSignatureParser AgilisParser = new AgilisWorkOrderSignatureParser();
                List<AgilisSignature> Signatures = AgilisParser.ParseSignatures(AgilisRawDataFileName, Status, ReturnValue);

                foreach (AgilisSignature Signature in Signatures)
                {
                    Status.ProgressUpdate(String.Format("Processing signature {0} for work order {1}...", Signature.Number, Signature.WorkOrderNumber), "", 0, 0);

                    IList<AgilisWorkOrder> WorkOrderList = _Session.CreateCriteria(typeof(AgilisWorkOrder))
                        .Add(Expression.Eq("WorkOrderNumber", Signature.WorkOrderNumber))
                        .List<AgilisWorkOrder>();

                    if (WorkOrderList.Count > 0)
                    {
                        if (WorkOrderList.Count > 1)
                        {
                            Debug.Assert(false);
                            ReturnValue.WarningCount++;
                            _Log.WarnFormat("More than one work order number {0} found; using last on file.",
                                            Signature.WorkOrderNumber);
                        }

                        AgilisWorkOrder WorkOrder = WorkOrderList[WorkOrderList.Count - 1];

                        Signature.Folder =
                            Path.Combine(SignaturesFolder, Signature.Timestamp.ToString("yyyy-MM-dd"));
                        if (!Directory.Exists(Signature.Folder))
                            Directory.CreateDirectory(Signature.Folder);
                        Signature.SetWorkOrderDetails(WorkOrder);
                        Signature.WriteSignatureFile();

                        IList<AgilisSignature> SignatureList = _Session.CreateCriteria(typeof(AgilisSignature))
                            .Add(Expression.Eq("WorkOrderRef", WorkOrder.WorkOrderId))
                            .Add(Expression.Eq("Timestamp", Signature.Timestamp))
                            .Add(Expression.Eq("Number", Signature.Number))
                            .List<AgilisSignature>();

                        if (SignatureList.Count > 0)
                        {
                            if (SignatureList.Count > 1)
                            {
                                Debug.Assert(false);
                                _Log.WarnFormat("More than one signature found for work order {0} at {1}.",
                                                WorkOrder.WorkOrderNumber, Signature.Timestamp);
                            }

                            Signature.SignatureId = SignatureList[SignatureList.Count - 1].SignatureId;
                            _Session.Merge(Signature);
                        }
                        else
                        {
                            _Session.Save(Signature);
                        }

                        ReturnValue.RecordsSuccessful++;
                    }
                }

                ReturnValue.Successful = true;
            }
            catch (Exception e)
            {
                ReturnValue.ErrorCount++;
                _Log.Error("An exception occurred while importing work order signatures; details follow.", e);
            }

            if (ReturnValue.ErrorCount > 0)
            {
                Status.ProgressUpdate("An error occurred; check the log for details.", "", 0, 0);
            }
            else
            {
                Status.ProgressUpdate("Done", "", 0, 0);
                ReturnValue.Successful = true;
            }

            ReturnValue.EndDate = DateTime.Now;
            return ReturnValue;
        }
    }
}
