namespace BopsDataAccess
{
    public class BopsFleet
    {
        private int _FleetId;
        private string _Description;
        private int? _TimeZoneRef;
        private int? _OriginRef;

        public int FleetId
        {
            get { return _FleetId; }
            set { _FleetId = value; }
        }

        public string Description
        {
            get { return _Description; }
            set { _Description = value; }
        }

        public int? TimeZoneRef
        {
            get { return _TimeZoneRef; }
            set { _TimeZoneRef = value; }
        }

        public int? OriginRef
        {
            get { return _OriginRef; }
            set { _OriginRef = value; }
        }
    }
}
