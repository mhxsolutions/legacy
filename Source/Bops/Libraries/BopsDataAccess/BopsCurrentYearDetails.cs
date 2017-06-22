namespace BopsDataAccess
{
    public class BopsCurrentYearDetails
    {
        private int _Year;
        private int _LoadCount;
        private float _Revenue;
        private int _TotalHours;

        public int Year
        {
            get { return _Year; }
            set { _Year = value; }
        }

        public int LoadCount
        {
            get { return _LoadCount; }
            set { _LoadCount = value; }
        }

        public float Revenue
        {
            get { return _Revenue; }
            set { _Revenue = value; }
        }

        public int TotalHours
        {
            get { return _TotalHours; }
            set { _TotalHours = value; }
        }
    }
}
