using System;

namespace AgilisCore
{
    public class AgilisWorkOrderJobStatusHistory
    {
        private static DateTime _DefaultDate = new DateTime(2006, 1, 1);

        private int _WorkOrderJobStatusHistoryId;
        private int _WorkOrderJobRef;
        private string _AgilisJobStatus;
        private string _Description;
        private DateTime _Timestamp;
        private DateTime _CorrectTimestamp;
        private bool _Current;
        private DateTime _PositionTimestamp;
        private float _Latitude;
        private float _Longitude;
        private float _Accuracy;

        public AgilisWorkOrderJobStatusHistory()
        {
            _PositionTimestamp = _DefaultDate;
        }

        public int WorkOrderJobStatusHistoryId
        {
            get { return _WorkOrderJobStatusHistoryId; }
            set { _WorkOrderJobStatusHistoryId = value; }
        }

        public int WorkOrderJobRef
        {
            get { return _WorkOrderJobRef; }
            set { _WorkOrderJobRef = value; }
        }

        public string AgilisJobStatus
        {
            get { return _AgilisJobStatus; }
            set { _AgilisJobStatus = value; }
        }

        public string Description
        {
            get { return _Description; }
            set { _Description = value; }
        }

        public DateTime Timestamp
        {
            get { return _Timestamp; }
            set { _Timestamp = value; }
        }

        public DateTime CorrectTimestamp
        {
            get { return _CorrectTimestamp; }
            set { _CorrectTimestamp = value; }
        }

        public bool Current
        {
            get { return _Current; }
            set { _Current = value; }
        }

        public DateTime PositionTimestamp
        {
            get { return _PositionTimestamp; }
            set { _PositionTimestamp = value; }
        }

        public float Latitude
        {
            get { return _Latitude; }
            set { _Latitude = value; }
        }

        public float Longitude
        {
            get { return _Longitude; }
            set { _Longitude = value; }
        }

        public float Accuracy
        {
            get { return _Accuracy; }
            set { _Accuracy = value; }
        }
    }
}
