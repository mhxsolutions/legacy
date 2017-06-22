namespace BopsDataAccess
{
    public class BopsFuelCardDriverAssignment
    {
        private string _CardId;
        private int _DriverRef;

        public string CardId
        {
            get { return _CardId; }
            set { _CardId = value; }
        }

        public int DriverRef
        {
            get { return _DriverRef; }
            set { _DriverRef = value; }
        }
    }
}
