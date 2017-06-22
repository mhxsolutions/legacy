namespace BopsDataAccess
{
    public class BopsEmployeeRole
    {
        private int _EmployeeRef;
        private int _EmployeeRoleTypeRef;

        public int EmployeeRef
        {
            get { return _EmployeeRef; }
            set { _EmployeeRef = value; }
        }

        public int EmployeeRoleTypeRef
        {
            get { return _EmployeeRoleTypeRef; }
            set { _EmployeeRoleTypeRef = value; }
        }

        public bool Equals(BopsEmployeeRole Other)
        {
            if (ReferenceEquals(null, Other)) return false;
            if (ReferenceEquals(this, Other)) return true;
            return Other._EmployeeRef == _EmployeeRef && Other._EmployeeRoleTypeRef == _EmployeeRoleTypeRef;
        }

        public override bool Equals(object Obj)
        {
            if (ReferenceEquals(null, Obj)) return false;
            if (ReferenceEquals(this, Obj)) return true;
            if (Obj.GetType() != typeof (BopsEmployeeRole)) return false;
            return Equals((BopsEmployeeRole) Obj);
        }

        public override int GetHashCode()
        {
            unchecked
            {
                return (_EmployeeRef*397) ^ _EmployeeRoleTypeRef;
            }
        }

        public override string ToString()
        {
            return string.Format("Employee {0}, role {1}", _EmployeeRef, (EmployeeRoleTypes)_EmployeeRoleTypeRef);
        }
    }
}
