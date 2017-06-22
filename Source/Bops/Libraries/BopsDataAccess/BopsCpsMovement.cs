using System;

namespace BopsDataAccess
{
    public class BopsCpsMovement
    {
        private int _MovementId;
        private int _ProjectRef;
        private string _ContainerRef;
        private int _OriginRef;
        private DateTime _OriginTimestamp;
        private int _DestinationRef;
        private DateTime _DestinationTimestamp;
        private int _PickupRequestRef;

        public int MovementId
        {
            get { return _MovementId; }
            set { _MovementId = value; }
        }

        public int ProjectRef
        {
            get { return _ProjectRef; }
            set { _ProjectRef = value; }
        }

        public string ContainerRef
        {
            get { return _ContainerRef; }
            set { _ContainerRef = value; }
        }

        public int OriginRef
        {
            get { return _OriginRef; }
            set { _OriginRef = value; }
        }

        public DateTime OriginTimestamp
        {
            get { return _OriginTimestamp; }
            set { _OriginTimestamp = value; }
        }

        public int DestinationRef
        {
            get { return _DestinationRef; }
            set { _DestinationRef = value; }
        }

        public DateTime DestinationTimestamp
        {
            get { return _DestinationTimestamp; }
            set { _DestinationTimestamp = value; }
        }

        public int PickupRequestRef
        {
            get { return _PickupRequestRef; }
            set { _PickupRequestRef = value; }
        }

        public bool ContainsTime(DateTime Time)
        {
            return _OriginTimestamp <= Time && Time < _DestinationTimestamp;
        }

        public bool OverlapsInterval(DateTime BeginTime, DateTime EndTime)
        {
            return !((BeginTime < _OriginTimestamp && EndTime < _OriginTimestamp) ||
                   (_DestinationTimestamp < BeginTime && _DestinationTimestamp < EndTime));
        }

        public override string ToString()
        {
            return string.Format("Move {0}, project {1}, container {2} from {3} to {4}",
                                 _MovementId, _ProjectRef, _ContainerRef, _OriginRef, _DestinationRef);
        }
    }
}
