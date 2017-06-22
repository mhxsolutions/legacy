namespace BopsDataAccess
{
    public class BopsRfsStakeholder
    {
        public int StakeholderId { get; set; }
        public int RfsRef { get; set; }
        public BopsRfsStakeholderRoleType RoleRef { get; set; }
        public int ClientRef { get; set; }
        public string Instructions { get; set; }
        public int CompanyRef { get; set; }

        public BopsRfsStakeholder()
        {
        }

        public BopsRfsStakeholder(BopsRfsStakeholder rhs)
        {
            StakeholderId = rhs.StakeholderId;
            RfsRef = rhs.RfsRef;
            RoleRef = rhs.RoleRef;
            ClientRef = rhs.ClientRef;
            Instructions = rhs.Instructions;
            CompanyRef = rhs.CompanyRef;
        }
    }
}
