using System;
using System.Text;

namespace AgilisCore
{
    public class AgilisDriverEvent
    {
        private int _DriverEventId;
        private int _DriverId;
        private string _DriverEventCode;
        private DateTime _Timestamp;

        public int DriverEventId
        {
            get { return _DriverEventId; }
            set { _DriverEventId = value; }
        }

        public int DriverId
        {
            get { return _DriverId; }
            set { _DriverId = value; }
        }

        public string DriverEventCode
        {
            get { return _DriverEventCode; }
            set { _DriverEventCode = value; }
        }

        public DateTime Timestamp
        {
            get { return _Timestamp; }
            set { _Timestamp = value; }
        }

        public override string ToString()
        {
            StringBuilder ReturnValue = new StringBuilder();
            ReturnValue.AppendFormat("DriverEventId = {0}, ", DriverEventId);
            ReturnValue.AppendFormat("DriverId = {0}, ", DriverId);
            ReturnValue.AppendFormat("DriverEventCode = {0}, ", DriverEventCode);
            ReturnValue.AppendFormat("Timestamp = {0}", Timestamp);

            return ReturnValue.ToString();
        }

        public bool IsValid()
        {
            return DriverId != 0 && Timestamp != DateTime.MinValue && DriverEventCode != string.Empty;
        }
    }
}
