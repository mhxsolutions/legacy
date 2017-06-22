namespace BopsDataAccess
{
    public class BopsProductProfile
    {
        private int _ProfileId;
        private int _ReceivingClientRef;
        private string _ProductClassDescription;
        private string _GroupLabel1;
        private string _GroupLabel2;
        private string _GroupLabel3;
        private string _WeightLabel;
        private string _PackageLabel;
        private string _ProductClassNotes;
        private int? _TransportationClientRef;
        private string _ReceiverDupeLockLabel;
        private bool? _BulkItems;
        private bool? _PreRelease;
        private int? _ProductRef;
        private bool _AutoBillForStorage;
        private double? _BaseTruckloadRate;
        private int? _RfsRef;
        private bool? _NoStorageBilling;

        public int ProfileId
        {
            get { return _ProfileId; }
            set { _ProfileId = value; }
        }

        public int ReceivingClientRef
        {
            get { return _ReceivingClientRef; }
            set { _ReceivingClientRef = value; }
        }

        public string ProductClassDescription
        {
            get { return _ProductClassDescription; }
            set { _ProductClassDescription = value; }
        }

        public string GroupLabel1
        {
            get { return _GroupLabel1; }
            set { _GroupLabel1 = value; }
        }

        public string GroupLabel2
        {
            get { return _GroupLabel2; }
            set { _GroupLabel2 = value; }
        }

        public string GroupLabel3
        {
            get { return _GroupLabel3; }
            set { _GroupLabel3 = value; }
        }

        public string WeightLabel
        {
            get { return _WeightLabel; }
            set { _WeightLabel = value; }
        }

        public string PackageLabel
        {
            get { return _PackageLabel; }
            set { _PackageLabel = value; }
        }

        public string ProductClassNotes
        {
            get { return _ProductClassNotes; }
            set { _ProductClassNotes = value; }
        }

        public int? TransportationClientRef
        {
            get { return _TransportationClientRef; }
            set { _TransportationClientRef = value; }
        }

        public string ReceiverDupeLockLabel
        {
            get { return _ReceiverDupeLockLabel; }
            set { _ReceiverDupeLockLabel = value; }
        }

        public bool? BulkItems
        {
            get { return _BulkItems; }
            set { _BulkItems = value; }
        }

        public bool? PreRelease
        {
            get { return _PreRelease; }
            set { _PreRelease = value; }
        }

        public int? ProductRef
        {
            get { return _ProductRef; }
            set { _ProductRef = value; }
        }

        public bool AutoBillForStorage
        {
            get { return _AutoBillForStorage; }
            set { _AutoBillForStorage = value; }
        }

        public double? BaseTruckloadRate
        {
            get { return _BaseTruckloadRate; }
            set { _BaseTruckloadRate = value; }
        }

        public int? RfsRef
        {
            get { return _RfsRef; }
            set { _RfsRef = value; }
        }

        public bool? NoStorageBilling
        {
            get { return _NoStorageBilling; }
            set { _NoStorageBilling = value; }
        }
    }
}
