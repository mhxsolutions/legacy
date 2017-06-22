namespace BopsDataAccess
{
    public enum EmployeeRoleTypes
    {
        None,
        Sales,
        Driver,
        Warehouse
    }

    public class BopsEmployeeRoleType
    {
        private int _RoleTypeId;
        private string _RoleType;

        public int RoleTypeId
        {
            get { return _RoleTypeId; }
            set { _RoleTypeId = value; }
        }

        public string RoleType
        {
            get { return _RoleType; }
            set { _RoleType = value; }
        }
    }
}
