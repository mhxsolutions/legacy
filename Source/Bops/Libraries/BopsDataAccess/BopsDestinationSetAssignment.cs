namespace BopsDataAccess
{
    public class BopsDestinationSetAssignment
    {
        private int _SetRef;
        private int _DestinationRef;

        public int SetRef
        {
            get { return _SetRef; }
            set { _SetRef = value; }
        }

        public int DestinationRef
        {
            get { return _DestinationRef; }
            set { _DestinationRef = value; }
        }

        public override string ToString()
        {
            return string.Format("Destination Set Assignment, set {0} -> destination {1}", _SetRef, _DestinationRef);
        }

        public bool Equals(BopsDestinationSetAssignment Other)
        {
            if (ReferenceEquals(null, Other)) return false;
            if (ReferenceEquals(this, Other)) return true;
            return Other._SetRef == _SetRef && Other._DestinationRef == _DestinationRef;
        }

        public override bool Equals(object Obj)
        {
            if (ReferenceEquals(null, Obj)) return false;
            if (ReferenceEquals(this, Obj)) return true;
            if (Obj.GetType() != typeof (BopsDestinationSetAssignment)) return false;
            return Equals((BopsDestinationSetAssignment) Obj);
        }

        public override int GetHashCode()
        {
            unchecked
            {
                return (_SetRef*397) ^ _DestinationRef;
            }
        }
    }
}
