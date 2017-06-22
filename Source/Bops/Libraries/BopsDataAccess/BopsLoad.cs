using System;

namespace BopsDataAccess
{
    public class BopsLoad
    {
        private int _LoadKey;
        private string _LoadReference;
        private string _BillOfLading;
        private double? _NetWeight;
        private double? _CoilCount;
        private int? _LoadDestination;
        private DateTime? _LoadDate;
        private double? _GrossWeight;
        private double? _ChargedWeight;
        private bool? _LoggedOut;
        private DateTime? _LogOutTime;
        private DateTime? _LogOutDate;
        private bool? _ProofOfDelivery;
        private DateTime? _ProofOfDeliveryTime;
        private DateTime? _ProofOfDeliveryDate;
        private int? _DriverRef;
        private string _Truck;
        private string _Notes;
        private int? _DeliveryLocationRef;
        private int? _LoadFamily;
        private DateTime? _AssignTimestamp;
        private bool? _Stage;
        private bool? _StageComplete;
        private string _LoadEditor;
        private string _AsnEditor;
        private string _SourceRef;
        private int? _ContractRef;
        private bool? _WillCall;
        private string _WillCallInvoice;
        private string _WillCallComment;
        private Decimal? _WillCallRate;
        private bool? _Subhaul;
        private DateTime? _ScheduleDate;
        private int? _BillOfLadingRef;
        private int? _PickUpRequestRef;
        private int? _LoadSource;
        private int? _Color;
        private int? _OriginRef;
        private bool _Hold;
        private bool _ChangeFlag;
        private int? _ProductRef;
        private DateTime? _StageRequestTimestamp;
        private DateTime? _ReadyTimestamp;
        private string _StageEditor;
        private string _ReadyEditor;
        private DateTime? _ConfirmedTimestamp;
        private string _ConfirmedBy;
        private int? _ScanErrorRef;
        private int? _ScanRejectCount;
        private DateTime? _PitTimestamp;
        private int _ConfirmWithoutProofOfDelivery;
        private int? _RfsRef;
        private string _Trailer;
        private RfsBillingStatus _BillingStatus;
        private int? _FleetRef;
        private string _ClientInvoiceData;
        private bool _PartialLoad;

        public int LoadKey
        {
            get { return _LoadKey; }
            set { _LoadKey = value; }
        }

        public string LoadReference
        {
            get { return _LoadReference; }
            set { _LoadReference = value; }
        }

        public string BillOfLading
        {
            get { return _BillOfLading; }
            set { _BillOfLading = value; }
        }

        public double? NetWeight
        {
            get { return _NetWeight; }
            set { _NetWeight = value; }
        }

        public double? CoilCount
        {
            get { return _CoilCount; }
            set { _CoilCount = value; }
        }

        public int? LoadDestination
        {
            get { return _LoadDestination; }
            set { _LoadDestination = value; }
        }

        public DateTime? LoadDate
        {
            get { return _LoadDate; }
            set { _LoadDate = value; }
        }

        public double? GrossWeight
        {
            get { return _GrossWeight; }
            set { _GrossWeight = value; }
        }

        public double? ChargedWeight
        {
            get { return _ChargedWeight; }
            set { _ChargedWeight = value; }
        }

        public bool? LoggedOut
        {
            get { return _LoggedOut; }
            set { _LoggedOut = value; }
        }

        public DateTime? LogOutTime
        {
            get { return _LogOutTime; }
            set { _LogOutTime = value; }
        }

        public DateTime? LogOutDate
        {
            get { return _LogOutDate; }
            set { _LogOutDate = value; }
        }

        public bool? ProofOfDelivery
        {
            get { return _ProofOfDelivery; }
            set { _ProofOfDelivery = value; }
        }

        public DateTime? ProofOfDeliveryTime
        {
            get { return _ProofOfDeliveryTime; }
            set { _ProofOfDeliveryTime = value; }
        }

        public DateTime? ProofOfDeliveryDate
        {
            get { return _ProofOfDeliveryDate; }
            set { _ProofOfDeliveryDate = value; }
        }

        public int? DriverRef
        {
            get { return _DriverRef; }
            set { _DriverRef = value; }
        }

        public string Truck
        {
            get { return _Truck; }
            set { _Truck = value; }
        }

        public string Notes
        {
            get { return _Notes; }
            set { _Notes = value; }
        }

        public int? DeliveryLocationRef
        {
            get { return _DeliveryLocationRef; }
            set { _DeliveryLocationRef = value; }
        }

        public int? LoadFamily
        {
            get { return _LoadFamily; }
            set { _LoadFamily = value; }
        }

        public DateTime? AssignTimestamp
        {
            get { return _AssignTimestamp; }
            set { _AssignTimestamp = value; }
        }

        public bool? Stage
        {
            get { return _Stage; }
            set { _Stage = value; }
        }

        public bool? StageComplete
        {
            get { return _StageComplete; }
            set { _StageComplete = value; }
        }

        public string LoadEditor
        {
            get { return _LoadEditor; }
            set { _LoadEditor = value; }
        }

        public string AsnEditor
        {
            get { return _AsnEditor; }
            set { _AsnEditor = value; }
        }

        public string SourceRef
        {
            get { return _SourceRef; }
            set { _SourceRef = value; }
        }

        public int? ContractRef
        {
            get { return _ContractRef; }
            set { _ContractRef = value; }
        }

        public bool? WillCall
        {
            get { return _WillCall; }
            set { _WillCall = value; }
        }

        public string WillCallInvoice
        {
            get { return _WillCallInvoice; }
            set { _WillCallInvoice = value; }
        }

        public string WillCallComment
        {
            get { return _WillCallComment; }
            set { _WillCallComment = value; }
        }

        public decimal? WillCallRate
        {
            get { return _WillCallRate; }
            set { _WillCallRate = value; }
        }

        public bool? Subhaul
        {
            get { return _Subhaul; }
            set { _Subhaul = value; }
        }

        public DateTime? ScheduleDate
        {
            get { return _ScheduleDate; }
            set { _ScheduleDate = value; }
        }

        public int? BillOfLadingRef
        {
            get { return _BillOfLadingRef; }
            set { _BillOfLadingRef = value; }
        }

        public int? PickUpRequestRef
        {
            get { return _PickUpRequestRef; }
            set { _PickUpRequestRef = value; }
        }

        public int? LoadSource
        {
            get { return _LoadSource; }
            set { _LoadSource = value; }
        }

        public int? Color
        {
            get { return _Color; }
            set { _Color = value; }
        }

        public int? OriginRef
        {
            get { return _OriginRef; }
            set { _OriginRef = value; }
        }

        public bool Hold
        {
            get { return _Hold; }
            set { _Hold = value; }
        }

        public bool ChangeFlag
        {
            get { return _ChangeFlag; }
            set { _ChangeFlag = value; }
        }

        public int? ProductRef
        {
            get { return _ProductRef; }
            set { _ProductRef = value; }
        }

        public DateTime? StageRequestTimestamp
        {
            get { return _StageRequestTimestamp; }
            set { _StageRequestTimestamp = value; }
        }

        public DateTime? ReadyTimestamp
        {
            get { return _ReadyTimestamp; }
            set { _ReadyTimestamp = value; }
        }

        public string StageEditor
        {
            get { return _StageEditor; }
            set { _StageEditor = value; }
        }

        public string ReadyEditor
        {
            get { return _ReadyEditor; }
            set { _ReadyEditor = value; }
        }

        public DateTime? ConfirmedTimestamp
        {
            get { return _ConfirmedTimestamp; }
            set { _ConfirmedTimestamp = value; }
        }

        public string ConfirmedBy
        {
            get { return _ConfirmedBy; }
            set { _ConfirmedBy = value; }
        }

        public int? ScanErrorRef
        {
            get { return _ScanErrorRef; }
            set { _ScanErrorRef = value; }
        }

        public int? ScanRejectCount
        {
            get { return _ScanRejectCount; }
            set { _ScanRejectCount = value; }
        }

        public DateTime? PitTimestamp
        {
            get { return _PitTimestamp; }
            set { _PitTimestamp = value; }
        }

        public int ConfirmWithoutProofOfDelivery
        {
            get { return _ConfirmWithoutProofOfDelivery; }
            set { _ConfirmWithoutProofOfDelivery = value; }
        }

        public int? RfsRef
        {
            get { return _RfsRef; }
            set { _RfsRef = value; }
        }

        public string Trailer
        {
            get { return _Trailer; }
            set { _Trailer = value; }
        }

        public RfsBillingStatus BillingStatus
        {
            get { return _BillingStatus; }
            set { _BillingStatus = value; }
        }

        public int? FleetRef
        {
            get { return _FleetRef; }
            set { _FleetRef = value; }
        }

        public string ClientInvoiceData
        {
            get { return _ClientInvoiceData; }
            set { _ClientInvoiceData = value; }
        }

        public bool PartialLoad
        {
            get { return _PartialLoad; }
            set { _PartialLoad = value; }
        }

        public double? SpecialInvoiceValue { get; set; }
    }
}
