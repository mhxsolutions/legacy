namespace BopsDataAccess
{
    public class BopsCurrentMonthDetails
    {
        private int _Year;
        private int _Month;
        private int _LoadCount;
        private float _Revenue;
        private int _TransitMinutes;
        private int _DetentionMinutes;

        public int Year
        {
            get { return _Year; }
            set { _Year = value; }
        }

        public int Month
        {
            get { return _Month; }
            set { _Month = value; }
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

        public int TransitMinutes
        {
            get { return _TransitMinutes; }
            set { _TransitMinutes = value; }
        }

        public int DetentionMinutes
        {
            get { return _DetentionMinutes; }
            set { _DetentionMinutes = value; }
        }
    }
}
