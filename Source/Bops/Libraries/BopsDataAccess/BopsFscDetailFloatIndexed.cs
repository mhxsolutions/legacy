namespace BopsDataAccess
{
    public class BopsFscDetailFloatIndexed
    {
        private int _FscDetailId;
        private int _FscRef;
        private double _IndexMinimum;
        private double _IndexMaximum;
        private double _FscValue;

        public int FscDetailId
        {
            get { return _FscDetailId; }
            set { _FscDetailId = value; }
        }

        public int FscRef
        {
            get { return _FscRef; }
            set { _FscRef = value; }
        }

        public double IndexMinimum
        {
            get { return _IndexMinimum; }
            set { _IndexMinimum = value; }
        }

        public double IndexMaximum
        {
            get { return _IndexMaximum; }
            set { _IndexMaximum = value; }
        }

        public double FscValue
        {
            get { return _FscValue; }
            set { _FscValue = value; }
        }
    }
}
