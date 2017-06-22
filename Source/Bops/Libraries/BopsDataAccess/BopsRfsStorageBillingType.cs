namespace BopsDataAccess
{
    public class BopsRfsStorageBillingType
    {
        private int _BillingTypeId;
        private string _Description;

        public int BillingTypeId
        {
            get { return _BillingTypeId; }
            set { _BillingTypeId = value; }
        }

        public string Description
        {
            get { return _Description; }
            set { _Description = value; }
        }

        public RfsStorageBillingType BillingTypeEnum
        {
            get { return (RfsStorageBillingType)_BillingTypeId; }
        }

    }
}
