using System;
using System.Text;

namespace AgilisCore
{
    public class AgilisDriverPosition
    {
        private int _DriverPositionId;
        private int _DriverId;
        private DateTime _Timestamp;
        private float _Latitude;
        private float _Longitude;
        private float _Accuracy;

        public int DriverPositionId
        {
            get { return _DriverPositionId; }
            set { _DriverPositionId = value; }
        }

        public int DriverId
        {
            get { return _DriverId; }
            set { _DriverId = value; }
        }

        public DateTime Timestamp
        {
            get { return _Timestamp; }
            set { _Timestamp = value; }
        }

        public float Latitude
        {
            get { return _Latitude; }
            set { _Latitude = value; }
        }

        public float Longitude
        {
            get { return _Longitude; }
            set { _Longitude = value; }
        }

        public float Accuracy
        {
            get { return _Accuracy; }
            set { _Accuracy = value; }
        }

        public bool IsValid()
        {
            return DriverId != 0 && Timestamp != DateTime.MinValue;
        }

        public override string ToString()
        {
            StringBuilder ReturnValue = new StringBuilder();
            ReturnValue.AppendFormat("DriverPositionId = {0}, ", DriverPositionId);
            ReturnValue.AppendFormat("DriverId = {0}, ", DriverId);
            ReturnValue.AppendFormat("Timestamp = {0}, ", Timestamp);
            ReturnValue.AppendFormat("Latitude = {0}, ", Latitude);
            ReturnValue.AppendFormat("Longitude = {0}, ", Longitude);
            ReturnValue.AppendFormat("Accuracy = {0}", Accuracy);

            return ReturnValue.ToString();
        }
    }
}
