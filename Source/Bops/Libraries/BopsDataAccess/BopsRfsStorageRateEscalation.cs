namespace BopsDataAccess
{
    public class BopsRfsStorageRateEscalation
    {
        private int _EscalationId;
        private int _StorageRateRef;
        private int _CycleCount;
        private double _NewUnitCostPerCycle;
        private int _NewUnitRef;

        public int EscalationId
        {
            get { return _EscalationId; }
            set { _EscalationId = value; }
        }

        public int StorageRateRef
        {
            get { return _StorageRateRef; }
            set { _StorageRateRef = value; }
        }

        public int CycleCount
        {
            get { return _CycleCount; }
            set { _CycleCount = value; }
        }

        public double NewUnitCostPerCycle
        {
            get { return _NewUnitCostPerCycle; }
            set { _NewUnitCostPerCycle = value; }
        }

        public int NewUnitRef
        {
            get { return _NewUnitRef; }
            set { _NewUnitRef = value; }
        }
    }
}
