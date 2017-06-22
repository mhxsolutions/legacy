namespace BopsDataAccess
{
    public class BopsRfsWorkType
    {
        private int _WorkTypeId;
        private string _WorkType;

        public int WorkTypeId
        {
            get { return _WorkTypeId; }
            set { _WorkTypeId = value; }
        }

        public string WorkType
        {
            get { return _WorkType; }
            set { _WorkType = value; }
        }

        public override string ToString()
        {
            return _WorkType;
        }
    }
}
