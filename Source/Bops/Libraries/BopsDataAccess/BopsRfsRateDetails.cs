namespace BopsDataAccess
{
    // Taken from the [DWS No Rep Data].dbo.[sys Units of Measure] table.
    public enum RfsCostMethodUnits
    {
        None,
        Load,
        Truck,
        Railcar,
        Pound,
        CWT,
        Ton,
        Mile,
        PercentOfTransportation,
        Each,
        Pallet,
        Unit,
        Kilo,
        MetricTon,
        PoundGross,
        PoundEst,
        PoundNet
    }

    public enum RfsServiceCategories
    {
        None,
        Transportation,
        Warehouse,
        Assessorial,
    }

    public enum RfsCostMethods
    {
        None,
        FlatFee,
        PerUnit,
        Matrix,
        SpecialUnit,
        PerItem,
    }

    public class BopsRfsRateDetails
    {
        private int? _CostMethodRef;
        private double? _Cost;
        private int? _UnitRef;
        private int? _CostMatrixRef;
        private double? _FscFixedRate;
        private int? _FscMatrixRef;
        private double? _EstimatedThroughput;
        private double? _EstimatedRevenue;
        private double? _EstimatedMinutes;
        private double? _Mileage;
        private int _MinimumChargedWeight;

        public int? CostMethodRef
        {
            get { return _CostMethodRef; }
            set { _CostMethodRef = value; }
        }

        public double? Cost
        {
            get { return _Cost; }
            set { _Cost = value; }
        }

        public int? UnitRef
        {
            get { return _UnitRef; }
            set { _UnitRef = value; }
        }

        public int? CostMatrixRef
        {
            get { return _CostMatrixRef; }
            set { _CostMatrixRef = value; }
        }

        public double? FscFixedRate
        {
            get { return _FscFixedRate; }
            set { _FscFixedRate = value; }
        }

        public int? FscMatrixRef
        {
            get { return _FscMatrixRef; }
            set { _FscMatrixRef = value; }
        }

        public double? EstimatedThroughput
        {
            get { return _EstimatedThroughput; }
            set { _EstimatedThroughput = value; }
        }

        public double? EstimatedRevenue
        {
            get { return _EstimatedRevenue; }
            set { _EstimatedRevenue = value; }
        }

        public double? EstimatedMinutes
        {
            get { return _EstimatedMinutes; }
            set { _EstimatedMinutes = value; }
        }

        public double? Mileage
        {
            get { return _Mileage; }
            set { _Mileage = value; }
        }

        public int MinimumChargedWeight
        {
            get { return _MinimumChargedWeight; }
            set { _MinimumChargedWeight = value; }
        }

        public bool FuelSurchargeApplies
        {
            get { return _FscFixedRate.HasValue || _FscMatrixRef.HasValue; }
        }

        public string SpecialUnitText { get; set; }

        public BopsRfsRateDetails()
        {
        }

        public BopsRfsRateDetails(BopsRfsRateDetails Rhs)
        {
            _CostMethodRef = Rhs._CostMethodRef;
            _Cost = Rhs._Cost;
            _UnitRef = Rhs._UnitRef;
            _CostMatrixRef = Rhs._CostMatrixRef;
            _FscFixedRate = Rhs._FscFixedRate;
            _FscMatrixRef = Rhs._FscMatrixRef;
            _EstimatedThroughput = Rhs._EstimatedThroughput;
            _EstimatedRevenue = Rhs._EstimatedRevenue;
            _EstimatedMinutes = Rhs._EstimatedMinutes;
            _Mileage = Rhs._Mileage;
            _MinimumChargedWeight = Rhs._MinimumChargedWeight;
            SpecialUnitText = Rhs.SpecialUnitText;
        }
    }
}
