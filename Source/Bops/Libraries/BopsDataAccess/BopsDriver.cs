using System.Diagnostics;

namespace BopsDataAccess
{
    public class BopsDriver
    {
        private int _DriverId;
        private string _FirstName;
        private string _LastName;
        private bool _Agilis;
        private string _WorkPhone;
        private int? _Tractor;
        private int? _Trailer;
        private int? _FleetRef;

        public int DriverId
        {
            get { return _DriverId; }
            set { _DriverId = value; }
        }

        public string FirstName
        {
            get { return _FirstName; }
            set { _FirstName = value; }
        }

        public string LastName
        {
            get { return _LastName; }
            set { _LastName = value; }
        }

        public bool Agilis
        {
            get { return _Agilis; }
            set { _Agilis = value; }
        }

        public string WorkPhone
        {
            get { return _WorkPhone; }
            set { _WorkPhone = value; }
        }

        public int? Tractor
        {
            get { return _Tractor; }
            set { _Tractor = value; }
        }

        public int? Trailer
        {
            get { return _Trailer; }
            set { _Trailer = value; }
        }

        public int? FleetRef
        {
            get { return _FleetRef; }
            set { _FleetRef = value; }
        }

        /// <summary>
        /// Most driver records have a first and last name, though some have only a last name. The database presently
        /// (as of 05/21/2010) has a constraint to require the last name.
        /// </summary>
        /// <returns>A string representation of the driver's name.</returns>
        public override string ToString()
        {
            Debug.Assert(!string.IsNullOrEmpty(_LastName));
            return !string.IsNullOrEmpty(_FirstName) ? string.Format("{0} {1}", _FirstName, _LastName) : _LastName;
        }
    }
}
