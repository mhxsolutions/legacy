namespace BopsDataAccess
{
    public class BopsRfsStatus
    {
        private int _StatusId;
        private string _Status;

        public int StatusId
        {
            get { return _StatusId; }
            set { _StatusId = value; }
        }

        public string Status
        {
            get { return _Status; }
            set { _Status = value; }
        }

        public override string ToString()
        {
            return _Status;
        }
    }
}
