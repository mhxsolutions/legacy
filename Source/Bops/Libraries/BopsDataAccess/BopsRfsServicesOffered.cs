namespace BopsDataAccess
{
    public class BopsRfsServicesOffered
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public RfsServiceCategories CategoryRef { get; set; }
        public int CostMethodRef { get; set; }
        public double Cost { get; set; }
        public int? UnitRef { get; set; }
        public int? CostMatrixRef { get; set; }
        public string GeneralLedgerCode { get; set; }
        public string SolomonAccountNumber { get; set; }
        public string SolomonCostCenterType { get; set; }
        public string SLCOA { get; set; }
        public string SLSUB { get; set; }
        public int CompanyRef { get; set; }

        public BopsRfsServicesOffered()
        {
        }

        public BopsRfsServicesOffered(BopsRfsServicesOffered rhs)
        {
            Id = rhs.Id;
            Name = rhs.Name;
            CategoryRef = rhs.CategoryRef;
            CostMethodRef = rhs.CostMethodRef;
            Cost = rhs.Cost;
            UnitRef = rhs.UnitRef;
            CostMatrixRef = rhs.CostMatrixRef;
            GeneralLedgerCode = rhs.GeneralLedgerCode;
            SLCOA = rhs.SLCOA;
            SLSUB = rhs.SLSUB;
            CompanyRef = rhs.CompanyRef;
        }
    }
}
