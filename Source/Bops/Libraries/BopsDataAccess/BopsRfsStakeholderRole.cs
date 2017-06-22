namespace BopsDataAccess
{
    public enum BopsRfsStakeholderRoleType
    {
        None,
        Shipper,
        Receiver,
        Origin,
        Destination,
        BillTo
    }

    public class BopsRfsStakeholderRole
    {
        private int _Id;
        private string _Name;

        public int Id
        {
            get { return _Id; }
            set { _Id = value; }
        }

        public string Name
        {
            get { return _Name; }
            set { _Name = value; }
        }

        public BopsRfsStakeholderRoleType RoleEnum
        {
            get { return (BopsRfsStakeholderRoleType)_Id; }
        }
    }
}
