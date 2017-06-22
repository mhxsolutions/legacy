using System;

namespace Driver_Break_Detector
{
    public class DriverDetails
    {
        private int _Id;
        private string _LastName;
        private string _FirstName;

        public int Id
        {
            get { return _Id; }
            set { _Id = value; }
        }

        public string LastName
        {
            get { return _LastName; }
            set { _LastName = value; }
        }

        public string FirstName
        {
            get { return _FirstName; }
            set { _FirstName = value; }
        }

        public string FullName
        {
            get
            {
                return String.Format("{0} {1}", _FirstName, _LastName);
            }
        }

        public DriverDetails(int Id, string FirstName, string LastName)
        {
            _Id = Id;
            _LastName = LastName;
            _FirstName = FirstName;
        }

        public override string ToString()
        {
            return FullName;
        }
    }
}
