using System;

namespace BopsDataAccess
{
    public class BopsInventoryDetail
    {
        private int _DetailId;
        private int? _ReceiverRef;
        private string _ProductGroup1;
        private string _ProductGroup2;
        private string _ProductGroup3;
        private string _ItemId;
        private int? _Weight;
        private int? _CountInPackage;
        private string _DamageComments;
        private DateTime? _MfgControlDate;
        private DateTime? _MfgReleaseDate;
        private DateTime? _ScheduleReleaseDate;
        private int? _StatusRef;
        private string _Location;
        private string _ItemEditor;
        private int? _RecDetailRef;
        private string _Grade;
        private double? _GaugeEnglish;
        private double? _WidthEnglish;
        private double? _GaugeMetric;
        private double? _WidthMetric;
        private string _MillNumber;
        private string _HeatNumber;
        private string _Type;
        private string _CoatingWt;
        private double? _LinearFeet;
        private string _ExtendedDescription;
        private string _AltCoilRef;
        private double? _NetWeight;
        private bool _NoStorageBilling;

        public int DetailId
        {
            get { return _DetailId; }
            set { _DetailId = value; }
        }

        public int? ReceiverRef
        {
            get { return _ReceiverRef; }
            set { _ReceiverRef = value; }
        }

        public string ProductGroup1
        {
            get { return _ProductGroup1; }
            set { _ProductGroup1 = value; }
        }

        public string ProductGroup2
        {
            get { return _ProductGroup2; }
            set { _ProductGroup2 = value; }
        }

        public string ProductGroup3
        {
            get { return _ProductGroup3; }
            set { _ProductGroup3 = value; }
        }

        public string ItemId
        {
            get { return _ItemId; }
            set { _ItemId = value; }
        }

        public int? Weight
        {
            get { return _Weight; }
            set { _Weight = value; }
        }

        public int? CountInPackage
        {
            get { return _CountInPackage; }
            set { _CountInPackage = value; }
        }

        public string DamageComments
        {
            get { return _DamageComments; }
            set { _DamageComments = value; }
        }

        public DateTime? MfgControlDate
        {
            get { return _MfgControlDate; }
            set { _MfgControlDate = value; }
        }

        public DateTime? MfgReleaseDate
        {
            get { return _MfgReleaseDate; }
            set { _MfgReleaseDate = value; }
        }

        public DateTime? ScheduleReleaseDate
        {
            get { return _ScheduleReleaseDate; }
            set { _ScheduleReleaseDate = value; }
        }

        public int? StatusRef
        {
            get { return _StatusRef; }
            set { _StatusRef = value; }
        }

        public string Location
        {
            get { return _Location; }
            set { _Location = value; }
        }

        public string ItemEditor
        {
            get { return _ItemEditor; }
            set { _ItemEditor = value; }
        }

        public int? RecDetailRef
        {
            get { return _RecDetailRef; }
            set { _RecDetailRef = value; }
        }

        public string Grade
        {
            get { return _Grade; }
            set { _Grade = value; }
        }

        public double? GaugeEnglish
        {
            get { return _GaugeEnglish; }
            set { _GaugeEnglish = value; }
        }

        public double? WidthEnglish
        {
            get { return _WidthEnglish; }
            set { _WidthEnglish = value; }
        }

        public double? GaugeMetric
        {
            get { return _GaugeMetric; }
            set { _GaugeMetric = value; }
        }

        public double? WidthMetric
        {
            get { return _WidthMetric; }
            set { _WidthMetric = value; }
        }

        public string MillNumber
        {
            get { return _MillNumber; }
            set { _MillNumber = value; }
        }

        public string HeatNumber
        {
            get { return _HeatNumber; }
            set { _HeatNumber = value; }
        }

        public string Type
        {
            get { return _Type; }
            set { _Type = value; }
        }

        public string CoatingWt
        {
            get { return _CoatingWt; }
            set { _CoatingWt = value; }
        }

        public double? LinearFeet
        {
            get { return _LinearFeet; }
            set { _LinearFeet = value; }
        }

        public string ExtendedDescription
        {
            get { return _ExtendedDescription; }
            set { _ExtendedDescription = value; }
        }

        public string AltCoilRef
        {
            get { return _AltCoilRef; }
            set { _AltCoilRef = value; }
        }

        public double? NetWeight
        {
            get { return _NetWeight; }
            set { _NetWeight = value; }
        }

        public bool NoStorageBilling
        {
            get { return _NoStorageBilling; }
            set { _NoStorageBilling = value; }
        }
    }
}
