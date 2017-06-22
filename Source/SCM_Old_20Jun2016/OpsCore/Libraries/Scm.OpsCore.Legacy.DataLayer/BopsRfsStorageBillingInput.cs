using System;
using BopsDataAccess;

namespace Scm.OpsCore.Legacy.DataLayer
{
    public class BopsRfsStorageBillingInput
    {
        private int _InventoryId;
        private string _WeightLabel;
        private int _Weight;
        private int _ProfileId;
        private string _CountLabel;
        private int _Count;
        private DateTime? _DateBilledThrough;
        private int _ReceiverId;
        private DateTime _DateReceived;
        private int _ReceivingClientRef;
        private DateTime? _DateShipped;
        private int _RateId;
        private int _BillToClientRef;
        private RfsStorageBillingType _BillingType;
        private int _DaysInCycle;
        private double _UnitCostPerCycle;
        private int _UnitRef;
        private int _AssignmentId;
        private DateTime _BeginDate;
        private DateTime _EndDate;
        private int _RfsId;
        private int _StorageFreeDays;

        public int InventoryId
        {
            get { return _InventoryId; }
            set { _InventoryId = value; }
        }

        public string WeightLabel
        {
            get { return _WeightLabel; }
            set { _WeightLabel = value; }
        }

        public int Weight
        {
            get { return _Weight; }
            set { _Weight = value; }
        }

        public int ProfileId
        {
            get { return _ProfileId; }
            set { _ProfileId = value; }
        }

        public string CountLabel
        {
            get { return _CountLabel; }
            set { _CountLabel = value; }
        }

        public int Count
        {
            get { return _Count; }
            set { _Count = value; }
        }

        public DateTime? DateBilledThrough
        {
            get { return _DateBilledThrough; }
            set { _DateBilledThrough = value; }
        }

        public int ReceiverId
        {
            get { return _ReceiverId; }
            set { _ReceiverId = value; }
        }

        public DateTime DateReceived
        {
            get { return _DateReceived; }
            set { _DateReceived = value; }
        }

        public int ReceivingClientRef
        {
            get { return _ReceivingClientRef; }
            set { _ReceivingClientRef = value; }
        }

        public DateTime? DateShipped
        {
            get { return _DateShipped; }
            set { _DateShipped = value; }
        }

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

        public int AssignmentId
        {
            get { return _AssignmentId; }
            set { _AssignmentId = value; }
        }

        public DateTime BeginDate
        {
            get { return _BeginDate; }
            set { _BeginDate = value; }
        }

        public DateTime EndDate
        {
            get { return _EndDate; }
            set { _EndDate = value; }
        }

        public int RfsId
        {
            get { return _RfsId; }
            set { _RfsId = value; }
        }

        public int StorageFreeDays
        {
            get { return _StorageFreeDays; }
            set { _StorageFreeDays = value; }
        }
    }
}
