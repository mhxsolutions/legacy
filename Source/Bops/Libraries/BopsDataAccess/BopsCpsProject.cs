using System;

namespace BopsDataAccess
{
    public class BopsCpsProject
    {
        private int _ProjectId;
        private DateTime _CreateTimestamp;
        private string _CreateUser;
        private int _BillToClientRef;
        private string _BookingId;
        private string _Description;
        private string _Berth;
        private string _ShippingLine;
        private int _DefaultOriginRef;
        private int _DefaultDestinationRef;
        private DateTime _BeginDate;
        private int _DemurrageDays;
        private int _TotalContainers;
        private string _Notes;
        private bool _Complete;

        public int ProjectId
        {
            get { return _ProjectId; }
            set { _ProjectId = value; }
        }

        public DateTime CreateTimestamp
        {
            get { return _CreateTimestamp; }
            set { _CreateTimestamp = value; }
        }

        public string CreateUser
        {
            get { return _CreateUser; }
            set { _CreateUser = value; }
        }

        public int BillToClientRef
        {
            get { return _BillToClientRef; }
            set { _BillToClientRef = value; }
        }

        public string BookingId
        {
            get { return _BookingId; }
            set { _BookingId = value; }
        }

        public string Description
        {
            get { return _Description; }
            set { _Description = value; }
        }

        public string Berth
        {
            get { return _Berth; }
            set { _Berth = value; }
        }

        public string ShippingLine
        {
            get { return _ShippingLine; }
            set { _ShippingLine = value; }
        }

        public int DefaultOriginRef
        {
            get { return _DefaultOriginRef; }
            set { _DefaultOriginRef = value; }
        }

        public int DefaultDestinationRef
        {
            get { return _DefaultDestinationRef; }
            set { _DefaultDestinationRef = value; }
        }

        public DateTime BeginDate
        {
            get { return _BeginDate; }
            set { _BeginDate = value; }
        }

        public int DemurrageDays
        {
            get { return _DemurrageDays; }
            set { _DemurrageDays = value; }
        }

        public int TotalContainers
        {
            get { return _TotalContainers; }
            set { _TotalContainers = value; }
        }

        public string Notes
        {
            get { return _Notes; }
            set { _Notes = value; }
        }

        public bool Complete
        {
            get { return _Complete; }
            set { _Complete = value; }
        }

        public override string ToString()
        {
            return string.Format("Project {0}, booking ID {1}", _ProjectId, _BookingId);
        }
    }
}
