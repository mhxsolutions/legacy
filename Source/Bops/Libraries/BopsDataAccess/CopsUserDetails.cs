namespace BopsDataAccess
{
    public class CopsUserDetails
    {
        private string _UserId;
        private int _ClientFilterDestinationRef;

        public string UserId
        {
            get { return _UserId; }
            set { _UserId = value; }
        }

        public int ClientFilterDestinationRef
        {
            get { return _ClientFilterDestinationRef; }
            set { _ClientFilterDestinationRef = value; }
        }
    }
}
