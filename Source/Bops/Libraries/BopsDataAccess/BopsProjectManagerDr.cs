using System;

namespace BopsDataAccess
{
    public class BopsProjectManagerDr
    {
        private int _DrId;
        private int? _BillOfLadingRef;
        private string _ItemNumber;
        private bool _Printed;
        private int? _Count;
        private double? _Weight;
        private int? _LoadKeyRef;
        private string _GatePass;
        private int? _Status;
        private string _UserWhoCreated;
        private DateTime? _DateCreated;
        private string _UserWhoModified;
        private DateTime? _DateModified;

        public int DrId
        {
            get { return _DrId; }
            set { _DrId = value; }
        }

        public int? BillOfLadingRef
        {
            get { return _BillOfLadingRef; }
            set { _BillOfLadingRef = value; }
        }

        public string ItemNumber
        {
            get { return _ItemNumber; }
            set { _ItemNumber = value; }
        }

        public bool Printed
        {
            get { return _Printed; }
            set { _Printed = value; }
        }

        public int? Count
        {
            get { return _Count; }
            set { _Count = value; }
        }

        public double? Weight
        {
            get { return _Weight; }
            set { _Weight = value; }
        }

        public int? LoadKeyRef
        {
            get { return _LoadKeyRef; }
            set { _LoadKeyRef = value; }
        }

        public string GatePass
        {
            get { return _GatePass; }
            set { _GatePass = value; }
        }

        public int? Status
        {
            get { return _Status; }
            set { _Status = value; }
        }

        public string UserWhoCreated
        {
            get { return _UserWhoCreated; }
            set { _UserWhoCreated = value; }
        }

        public DateTime? DateCreated
        {
            get { return _DateCreated; }
            set { _DateCreated = value; }
        }

        public string UserWhoModified
        {
            get { return _UserWhoModified; }
            set { _UserWhoModified = value; }
        }

        public DateTime? DateModified
        {
            get { return _DateModified; }
            set { _DateModified = value; }
        }
    }
}
