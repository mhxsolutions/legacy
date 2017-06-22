using System;
using BopsAuthentication;

namespace BopsDataAccess
{
    public enum RfsStorageBillingEventType
    {
        None,
        InventoryMarkedNsb,
        ProfileMarkedNsb,
        StorageBillingSaved,
        StorageBillingRolledBack,
        StorageBillingInvoicesGenerated,
        StorageBillingDetailRolledBack
    }

    public class BopsRfsStorageBillingEvent
    {
        private int _EventId;
        private RfsStorageBillingEventType _EventType;
        private DateTime _Timestamp;
        private string _UserId;
        private int _ItemRef;

        public int EventId
        {
            get { return _EventId; }
            set { _EventId = value; }
        }

        public RfsStorageBillingEventType EventType
        {
            get { return _EventType; }
            set { _EventType = value; }
        }

        public DateTime Timestamp
        {
            get { return _Timestamp; }
            set { _Timestamp = value; }
        }

        public string UserId
        {
            get { return _UserId; }
            set { _UserId = value; }
        }

        public int ItemRef
        {
            get { return _ItemRef; }
            set { _ItemRef = value; }
        }

        public BopsRfsStorageBillingEvent()
        {
            _Timestamp = DateTime.Now;
        }

        public BopsRfsStorageBillingEvent(RfsStorageBillingEventType EventType, int ItemRef)
        {
            _EventType = EventType;
            _Timestamp = DateTime.Now;
            _UserId = ActiveDirectoryUtility.GetCurrentUserName();
            _ItemRef = ItemRef;
        }
    }
}
