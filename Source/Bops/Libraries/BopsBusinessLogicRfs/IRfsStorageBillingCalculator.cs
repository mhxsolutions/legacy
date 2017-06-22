using System;
using System.Collections.Generic;
using BopsAuthentication;
using BopsDataAccess;
using Scm.OpsCore.Legacy.DataLayer;

namespace BopsBusinessLogicRfs
{
    public class RfsStorageBillingResult
    {
        #region Helper Classes
        public class ItemDetails
        {
            private int _StorageFreeDays;
            private BopsInventoryDetail _InventoryDetail;
            private BopsReceivingRecord _Receiver;
            private BopsRfsStorageRate _Rate;
            private BopsRfsStorageBillingDetail _BillingDetail;
            private BopsRfsStorageBillingInventoryTracking _InventoryTracking;

            public int StorageFreeDays
            {
                get { return _StorageFreeDays; }
                set { _StorageFreeDays = value; }
            }

            public BopsInventoryDetail InventoryDetail
            {
                get { return _InventoryDetail; }
                set { _InventoryDetail = value; }
            }

            public BopsReceivingRecord Receiver
            {
                get { return _Receiver; }
                set { _Receiver = value; }
            }

            public BopsRfsStorageRate Rate
            {
                get { return _Rate; }
                set { _Rate = value; }
            }

            public BopsRfsStorageBillingDetail BillingDetail
            {
                get { return _BillingDetail; }
                set { _BillingDetail = value; }
            }

            public BopsRfsStorageBillingInventoryTracking InventoryTracking
            {
                get { return _InventoryTracking; }
                set { _InventoryTracking = value; }
            }
        }

        #endregion

        private BopsRfsStorageBilling _Billing;
        private List<ItemDetails> _Items;

        public BopsRfsStorageBilling Billing
        {
            get { return _Billing; }
            set { _Billing = value; }
        }

        public List<ItemDetails> Items
        {
            get { return _Items; }
            set { _Items = value; }
        }

        public RfsStorageBillingResult()
        {
            _Billing = new BopsRfsStorageBilling();
            _Billing.DateGenerated = DateTime.Now;
            _Billing.UserId = ActiveDirectoryUtility.GetCurrentUserName();
            _Items = new List<ItemDetails>();
        }
    }

    public interface IRfsStorageBillingCalculator
    {
        RfsStorageBillingResult CalculateStorageBilling(DateTime billThroughDate);
        BopsRfsStorageBilling GetLastStorageBilling(IRfsDataContext rfsDataContext);
        bool RollBackLastStorageBilling(IRfsDataContext rfsDataContext);
        bool RollbackStorageBillingDetails(IRfsDataContext rfsDataContext, IEnumerable<BopsRfsStorageBillingDetail> details);
    }
}
