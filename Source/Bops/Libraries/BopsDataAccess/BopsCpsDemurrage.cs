using System;

namespace BopsDataAccess
{
    public class BopsCpsDemurrage
    {
        private int _ProjectRef;
        private string _ContainerRef;
        private DateTime _ClockBegin;
        private DateTime? _ClockEnd;
        private int _ClockBeginMovementRef;
        private int? _ClockEndMovementRef;
        private bool _BisExclude;

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

        public DateTime ClockBegin
        {
            get { return _ClockBegin; }
            set { _ClockBegin = value; }
        }

        public DateTime? ClockEnd
        {
            get { return _ClockEnd; }
            set { _ClockEnd = value; }
        }

        public int ClockBeginMovementRef
        {
            get { return _ClockBeginMovementRef; }
            set { _ClockBeginMovementRef = value; }
        }

        public int? ClockEndMovementRef
        {
            get { return _ClockEndMovementRef; }
            set { _ClockEndMovementRef = value; }
        }

        public bool BisExclude
        {
            get { return _BisExclude; }
            set { _BisExclude = value; }
        }

        public BopsCpsDemurrage()
        {
        }

        public BopsCpsDemurrage(int ProjectRef, string ContainerRef)
        {
            _ProjectRef = ProjectRef;
            _ContainerRef = ContainerRef;
        }

        public override string ToString()
        {
            if (_ClockEnd.HasValue)
                return string.Format("Demurrage for project {0}, container {1}, from {2} to {3}, total of {4}",
                                     _ProjectRef, _ContainerRef, _ClockBegin, _ClockEnd, _ClockEnd - _ClockBegin);

            return string.Format("Demurrage for project {0}, container {1}, clock running since {2}", 
                _ProjectRef, _ContainerRef, _ClockBegin);
        }

        public bool Equals(BopsCpsDemurrage Other)
        {
            if (ReferenceEquals(null, Other)) return false;
            if (ReferenceEquals(this, Other)) return true;
            return Other._ProjectRef == _ProjectRef && Equals(Other._ContainerRef, _ContainerRef) && Other._ClockBegin.Equals(_ClockBegin) && Other._ClockEnd.Equals(_ClockEnd) && Other._ClockBeginMovementRef == _ClockBeginMovementRef && Other._ClockEndMovementRef.Equals(_ClockEndMovementRef) && Other._BisExclude.Equals(_BisExclude);
        }

        public override bool Equals(object Obj)
        {
            if (ReferenceEquals(null, Obj)) return false;
            if (ReferenceEquals(this, Obj)) return true;
            if (Obj.GetType() != typeof (BopsCpsDemurrage)) return false;
            return Equals((BopsCpsDemurrage) Obj);
        }

        public override int GetHashCode()
        {
            unchecked
            {
                int Result = _ProjectRef;
                Result = (Result*397) ^ (_ContainerRef != null ? _ContainerRef.GetHashCode() : 0);
                Result = (Result*397) ^ _ClockBegin.GetHashCode();
                Result = (Result*397) ^ (_ClockEnd.HasValue ? _ClockEnd.Value.GetHashCode() : 0);
                Result = (Result*397) ^ _ClockBeginMovementRef;
                Result = (Result*397) ^ (_ClockEndMovementRef.HasValue ? _ClockEndMovementRef.Value : 0);
                Result = (Result*397) ^ _BisExclude.GetHashCode();
                return Result;
            }
        }
    }
}
