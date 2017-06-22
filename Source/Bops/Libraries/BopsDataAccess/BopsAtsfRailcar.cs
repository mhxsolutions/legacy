using System;

namespace BopsDataAccess
{
    public class BopsAtsfRailcar
    {
        private string _Ukey;
        private string _CarNumber;
        private string _LoadedStatus;  // 'L' for loaded or 'E' for empty.
        private string _Content;
        private string _Shipper;
        private string _Origin;
        private string _Currently;
        private string _BlDate;
        private string _Terminal;
        private DateTime? _Eta;
        private DateTime? _Time;
        private string _GoalTime;
        private string _CarComments;
        private DateTime? _CpDate;
        private bool? _Flagspot;
        private DateTime? _SpotReqDate;
        private string _Spotcom;
        private DateTime? _PlDate;
        private DateTime? _ReloadDate;
        private bool? _Flagrel;
        private DateTime? _ReleaseReqDate;
        private string _Yardcomm;
        private DateTime? _DateRel;
        private int? _StatusRef;
        private string _BnsfUprr;
        private string _Init;
        private string _Number;
        private string _CarType;
        private string _OriginCity;
        private string _OriginSt;
        private double? _BillWeight;
        private string _TsaNumber;
        private string _QbcNumber;
        private int? _ChgBnsf;
        private string _AtsfBill;
        private DateTime? _AtsfBillDate;
        private double? _BoxCarSize;
        private int? _BnsfStorageRef;
        private int? _BnsfCrossdockRef;
        private int? _ClientRef;
        private int? _ProductTypeRef;
        private string _ClientBol;
        private string _SttcNumber;
        private int? _BillTo;
        private string _WayBillNumber;
        //private DateTime? _Timestamp;   // Commented out because I can't get NHibernate to map and read it properly.
        private bool? _Asn;
        private bool? _TmpFlag;
        private string _TmpStatus;
        private bool? _WhseComplete;
        private int _RailcarId;
        private int? _AbSalesOrderRef;
        private int? _RfsRef;
        private DateTime? _ClientPreferredDate;

        public string Ukey
        {
            get { return _Ukey; }
            set { _Ukey = value; }
        }

        public string CarNumber
        {
            get { return _CarNumber; }
            set { _CarNumber = value; }
        }

        public string LoadedStatus
        {
            get { return _LoadedStatus; }
            set { _LoadedStatus = value; }
        }

        public string Content
        {
            get { return _Content; }
            set { _Content = value; }
        }

        public string Shipper
        {
            get { return _Shipper; }
            set { _Shipper = value; }
        }

        public string Origin
        {
            get { return _Origin; }
            set { _Origin = value; }
        }

        public string Currently
        {
            get { return _Currently; }
            set { _Currently = value; }
        }

        public string BlDate
        {
            get { return _BlDate; }
            set { _BlDate = value; }
        }

        public string Terminal
        {
            get { return _Terminal; }
            set { _Terminal = value; }
        }

        public DateTime? Eta
        {
            get { return _Eta; }
            set { _Eta = value; }
        }

        public DateTime? Time
        {
            get { return _Time; }
            set { _Time = value; }
        }

        public string GoalTime
        {
            get { return _GoalTime; }
            set { _GoalTime = value; }
        }

        public string CarComments
        {
            get { return _CarComments; }
            set { _CarComments = value; }
        }

        public DateTime? CpDate
        {
            get { return _CpDate; }
            set { _CpDate = value; }
        }

        public bool? Flagspot
        {
            get { return _Flagspot; }
            set { _Flagspot = value; }
        }

        public DateTime? SpotReqDate
        {
            get { return _SpotReqDate; }
            set { _SpotReqDate = value; }
        }

        public string Spotcom
        {
            get { return _Spotcom; }
            set { _Spotcom = value; }
        }

        public DateTime? PlDate
        {
            get { return _PlDate; }
            set { _PlDate = value; }
        }

        public DateTime? ReloadDate
        {
            get { return _ReloadDate; }
            set { _ReloadDate = value; }
        }

        public bool? Flagrel
        {
            get { return _Flagrel; }
            set { _Flagrel = value; }
        }

        public DateTime? ReleaseReqDate
        {
            get { return _ReleaseReqDate; }
            set { _ReleaseReqDate = value; }
        }

        public string Yardcomm
        {
            get { return _Yardcomm; }
            set { _Yardcomm = value; }
        }

        public DateTime? DateRel
        {
            get { return _DateRel; }
            set { _DateRel = value; }
        }

        public int? StatusRef
        {
            get { return _StatusRef; }
            set { _StatusRef = value; }
        }

        public string BnsfUprr
        {
            get { return _BnsfUprr; }
            set { _BnsfUprr = value; }
        }

        public string Init
        {
            get { return _Init; }
            set { _Init = value; }
        }

        public string Number
        {
            get { return _Number; }
            set { _Number = value; }
        }

        public string CarType
        {
            get { return _CarType; }
            set { _CarType = value; }
        }

        public string OriginCity
        {
            get { return _OriginCity; }
            set { _OriginCity = value; }
        }

        public string OriginSt
        {
            get { return _OriginSt; }
            set { _OriginSt = value; }
        }

        public double? BillWeight
        {
            get { return _BillWeight; }
            set { _BillWeight = value; }
        }

        public string TsaNumber
        {
            get { return _TsaNumber; }
            set { _TsaNumber = value; }
        }

        public string QbcNumber
        {
            get { return _QbcNumber; }
            set { _QbcNumber = value; }
        }

        public int? ChgBnsf
        {
            get { return _ChgBnsf; }
            set { _ChgBnsf = value; }
        }

        public string AtsfBill
        {
            get { return _AtsfBill; }
            set { _AtsfBill = value; }
        }

        public DateTime? AtsfBillDate
        {
            get { return _AtsfBillDate; }
            set { _AtsfBillDate = value; }
        }

        public double? BoxCarSize
        {
            get { return _BoxCarSize; }
            set { _BoxCarSize = value; }
        }

        public int? BnsfStorageRef
        {
            get { return _BnsfStorageRef; }
            set { _BnsfStorageRef = value; }
        }

        public int? BnsfCrossdockRef
        {
            get { return _BnsfCrossdockRef; }
            set { _BnsfCrossdockRef = value; }
        }

        public int? ClientRef
        {
            get { return _ClientRef; }
            set { _ClientRef = value; }
        }

        public int? ProductTypeRef
        {
            get { return _ProductTypeRef; }
            set { _ProductTypeRef = value; }
        }

        public string ClientBol
        {
            get { return _ClientBol; }
            set { _ClientBol = value; }
        }

        public string SttcNumber
        {
            get { return _SttcNumber; }
            set { _SttcNumber = value; }
        }

        public int? BillTo
        {
            get { return _BillTo; }
            set { _BillTo = value; }
        }

        public string WayBillNumber
        {
            get { return _WayBillNumber; }
            set { _WayBillNumber = value; }
        }

        //public DateTime? Timestamp
        //{
        //    get { return _Timestamp; }
        //    set { _Timestamp = value; }
        //}

        public bool? Asn
        {
            get { return _Asn; }
            set { _Asn = value; }
        }

        public bool? TmpFlag
        {
            get { return _TmpFlag; }
            set { _TmpFlag = value; }
        }

        public string TmpStatus
        {
            get { return _TmpStatus; }
            set { _TmpStatus = value; }
        }

        public bool? WhseComplete
        {
            get { return _WhseComplete; }
            set { _WhseComplete = value; }
        }

        public int RailcarId
        {
            get { return _RailcarId; }
            set { _RailcarId = value; }
        }

        public int? AbSalesOrderRef
        {
            get { return _AbSalesOrderRef; }
            set { _AbSalesOrderRef = value; }
        }

        public int? RfsRef
        {
            get { return _RfsRef; }
            set { _RfsRef = value; }
        }

        public DateTime? ClientPreferredDate
        {
            get { return _ClientPreferredDate; }
            set { _ClientPreferredDate = value; }
        }
    }
}
