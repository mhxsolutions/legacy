using System;

namespace AgilisCore
{
    public enum AgilisDataTypes
    {
        None,
        DeviceEvents,
        Drivers,
        DriverEvents,
        DriverPositions,
        Vehicles,
        WorkOrders,
        WorkOrderSignatures
    }

    public enum AgilisOperationTypes
    {
        None,
        Import,         // Importing data from Agilis
		ImportFull,		// Importing a full day's plan from Agilis
        ExportFull,     // Exporting a complete daily plan to Agilis
        ExportUpdate,   // Exporting updates (synchronizing) to Agilis
        Cancel,         // Cancelling individual work orders
        CancelFull,     // Cancelling (finalizing) the plan for an entire day
        Reactivate      // Reactivating work orders (as a prelude to updating)
    }

    public class AgilisIntegrationOperation
    {
        #region Fields
        private int _OperationId;
        private DateTime _PlanDate;
        private DateTime _BeginDate;
        private DateTime _EndDate;
        private AgilisDataTypes _DataType;
        private AgilisOperationTypes _Operation;
        private int _RecordsSuccessful;
        private int _RecordsFailed;
        private int _WarningCount;
        private int _ErrorCount;
        private bool _Successful;
        private string _Notes;
        #endregion

        #region Properties
        public int OperationId
        {
            get { return _OperationId; }
            set { _OperationId = value; }
        }

        public DateTime PlanDate
        {
            get { return _PlanDate; }
            set { _PlanDate = value; }
        }

        public DateTime BeginDate
        {
            get { return _BeginDate; }
            set { _BeginDate = value; }
        }

        public DateTime EndDate
        {
            get { return _EndDate; }
            set { _EndDate = value; }
        }

        public AgilisDataTypes DataType
        {
            get { return _DataType; }
            set { _DataType = value; }
        }

        public string DataTypeString
        {
            get { return _DataType.ToString(); }
            set { _DataType = (AgilisDataTypes)Enum.Parse(typeof(AgilisDataTypes), value); }
        }

        public AgilisOperationTypes Operation
        {
            get { return _Operation; }
            set { _Operation = value; }
        }

        public string OperationString
        {
            get { return _Operation.ToString(); }
            set { _Operation = (AgilisOperationTypes)Enum.Parse(typeof(AgilisOperationTypes), value); }
        }

        public int RecordsSuccessful
        {
            get { return _RecordsSuccessful; }
            set { _RecordsSuccessful = value; }
        }

        public int RecordsFailed
        {
            get { return _RecordsFailed; }
            set { _RecordsFailed = value; }
        }

        public int WarningCount
        {
            get { return _WarningCount; }
            set { _WarningCount = value; }
        }

        public int ErrorCount
        {
            get { return _ErrorCount; }
            set { _ErrorCount = value; }
        }

        public bool Successful
        {
            get { return _Successful; }
            set { _Successful = value; }
        }

        public string Notes
        {
            get { return _Notes; }
            set { _Notes = value; }
        }

        #endregion

        public AgilisIntegrationOperation()
        {
        }

        public AgilisIntegrationOperation(AgilisDataTypes _DataType, AgilisOperationTypes _Operation)
        {
            this._DataType = _DataType;
            this._Operation = _Operation;

            _BeginDate = DateTime.Now;
            _PlanDate = _BeginDate.Date;
        }

        public override string ToString()
        {
            string DurationDetails;
            if (EndDate > BeginDate)
            {
                TimeSpan TotalTime = EndDate - BeginDate;
                DurationDetails = string.Format("ran from {0} to {1} for a total of {2}", BeginDate, EndDate, TotalTime);
            }
            else
            {
                TimeSpan TotalTime = DateTime.Now - BeginDate;
                DurationDetails = string.Format("began at {0}, still running after {1}", BeginDate, TotalTime);
            }

            return string.Format(
                "{0} on {1} is {2} with {3} warnings, {4} errors, {5} successful records, {6} failed records, {7}",
                Operation, DataType, Successful ? "Successful" : "Unsuccessful", WarningCount, ErrorCount,
                RecordsSuccessful, RecordsFailed, DurationDetails);
        }
    }
}
