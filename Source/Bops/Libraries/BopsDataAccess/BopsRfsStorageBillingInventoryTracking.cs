using System;

namespace BopsDataAccess
{
    public class BopsRfsStorageBillingInventoryTracking
    {
        private int _InventoryRef;
        private DateTime _DateBilledThrough;

        public int InventoryRef
        {
            get { return _InventoryRef; }
            set { _InventoryRef = value; }
        }

        public DateTime DateBilledThrough
        {
            get { return _DateBilledThrough; }
            set { _DateBilledThrough = value; }
        }
    }
}
