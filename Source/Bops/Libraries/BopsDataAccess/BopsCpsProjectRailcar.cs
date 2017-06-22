namespace BopsDataAccess
{
    public class BopsCpsProjectRailcar
    {
        private int _ProjectRef;
        private string _RailcarRef;

        public int ProjectRef
        {
            get { return _ProjectRef; }
            set { _ProjectRef = value; }
        }

        public string RailcarRef
        {
            get { return _RailcarRef; }
            set { _RailcarRef = value; }
        }

        public BopsCpsProjectRailcar()
        {
        }

        public BopsCpsProjectRailcar(int ProjectRef, string RailcarRef)
        {
            _ProjectRef = ProjectRef;
            _RailcarRef = RailcarRef;
        }

        public bool Equals(BopsCpsProjectRailcar Other)
        {
            if (ReferenceEquals(null, Other)) return false;
            if (ReferenceEquals(this, Other)) return true;
            return Other._ProjectRef == _ProjectRef && Equals(Other._RailcarRef, _RailcarRef);
        }

        public override bool Equals(object Obj)
        {
            if (ReferenceEquals(null, Obj)) return false;
            if (ReferenceEquals(this, Obj)) return true;
            if (Obj.GetType() != typeof (BopsCpsProjectRailcar)) return false;
            return Equals((BopsCpsProjectRailcar) Obj);
        }

        public override int GetHashCode()
        {
            unchecked
            {
                return (_ProjectRef*397) ^ (_RailcarRef != null ? _RailcarRef.GetHashCode() : 0);
            }
        }
    }
}
