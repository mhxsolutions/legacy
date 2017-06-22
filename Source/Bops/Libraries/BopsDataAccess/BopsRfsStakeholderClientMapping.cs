namespace BopsDataAccess
{
    public class BopsRfsStakeholderClientMapping
    {
        private int _MappingId;
        private int _RfsRef;
        private int _TargetClientRef;

        public int MappingId
        {
            get { return _MappingId; }
            set { _MappingId = value; }
        }

        public int RfsRef
        {
            get { return _RfsRef; }
            set { _RfsRef = value; }
        }

        public int TargetClientRef
        {
            get { return _TargetClientRef; }
            set { _TargetClientRef = value; }
        }
    }
}
