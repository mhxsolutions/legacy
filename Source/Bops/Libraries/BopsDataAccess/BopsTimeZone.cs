namespace BopsDataAccess
{
    public class BopsTimeZone
    {
        private int _TimeZoneId;
        private string _Description;

        public int TimeZoneId
        {
            get { return _TimeZoneId; }
            set { _TimeZoneId = value; }
        }

        public string Description
        {
            get { return _Description; }
            set { _Description = value; }
        }
    }
}
