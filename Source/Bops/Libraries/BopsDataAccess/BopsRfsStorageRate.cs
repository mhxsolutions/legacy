namespace BopsDataAccess
{
    public enum RfsStorageBillingType
    {
        None,
        PerWeightUnit,
        PerCount,
        PerThousandBoardFeet,
        PerUnit
    }

    public class BopsRfsStorageRate
    {
        private int _RateId;
        private int _BillToClientRef;
        private RfsStorageBillingType _BillingType;
        private int _DaysInCycle;
        private double _UnitCostPerCycle;
        private int _UnitRef;
        private string _Description;

        public int RateId
        {
            get { return _RateId; }
            set { _RateId = value; }
        }

        public int BillToClientRef
        {
            get { return _BillToClientRef; }
            set { _BillToClientRef = value; }
        }

        public RfsStorageBillingType BillingType
        {
            get { return _BillingType; }
            set { _BillingType = value; }
        }

        public int DaysInCycle
        {
            get { return _DaysInCycle; }
            set { _DaysInCycle = value; }
        }

        public double UnitCostPerCycle
        {
            get { return _UnitCostPerCycle; }
            set { _UnitCostPerCycle = value; }
        }

        public int UnitRef
        {
            get { return _UnitRef; }
            set { _UnitRef = value; }
        }

        public string Description
        {
            get { return _Description; }
            set { _Description = value; }
        }
    }
}
