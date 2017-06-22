
using System;

namespace BopsDataAccess
{
    public class BopsRfsStorageBilling
    {
        private int _BillingId;
        private DateTime _DateBilledThrough;
        private DateTime _DateGenerated;
        private string _UserId;
        private int _TotalItemsProcessed;
        private double _TotalRevenue;
        private DateTime? _DateInvoiced;

        public int BillingId
        {
            get { return _BillingId; }
            set { _BillingId = value; }
        }

        public DateTime DateBilledThrough
        {
            get { return _DateBilledThrough; }
            set { _DateBilledThrough = value; }
        }

        public DateTime DateGenerated
        {
            get { return _DateGenerated; }
            set { _DateGenerated = value; }
        }

        public string UserId
        {
            get { return _UserId; }
            set { _UserId = value; }
        }

        public int TotalItemsProcessed
        {
            get { return _TotalItemsProcessed; }
            set { _TotalItemsProcessed = value; }
        }

        public double TotalRevenue
        {
            get { return _TotalRevenue; }
            set { _TotalRevenue = value; }
        }

        public DateTime? DateInvoiced
        {
            get { return _DateInvoiced; }
            set { _DateInvoiced = value; }
        }
    }
}
