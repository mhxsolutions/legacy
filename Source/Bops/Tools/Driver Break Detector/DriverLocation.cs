using System;

namespace Driver_Break_Detector
{
    public class DriverLocation
    {
        private int _Id;
        private double _Latitude;
        private double _Longitude;
        private DateTime _Timestamp;

        public int Id
        {
            get { return _Id; }
            set { _Id = value; }
        }

        public double Latitude
        {
            get { return _Latitude; }
            set { _Latitude = value; }
        }

        public double Longitude
        {
            get { return _Longitude; }
            set { _Longitude = value; }
        }

        public DateTime Timestamp
        {
            get { return _Timestamp; }
            set { _Timestamp = value; }
        }

        public override string ToString()
        {
            return string.Format("Id {0}, Lat {1}, Lon {2}, Time {3}", _Id, _Latitude, _Longitude, _Timestamp);
        }
    }
}
