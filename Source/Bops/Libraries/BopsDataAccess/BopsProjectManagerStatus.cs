namespace BopsDataAccess
{
    public class BopsProjectManagerStatus
    {
        public enum Codes
        {
            None,
            Active,
            Recoup,
            Closed,
            Ready,
            Billing,
            ClosedShort,
            ClosedOver,
            Reconcile,
            Pending,
            UTL
        }

        private int _Id;
        private string _Status;

        public int Id
        {
            get { return _Id; }
            set { _Id = value; }
        }

        public string Status
        {
            get { return _Status; }
            set { _Status = value; }
        }
    }
}
