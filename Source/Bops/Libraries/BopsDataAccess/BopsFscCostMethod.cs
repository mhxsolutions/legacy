namespace BopsDataAccess
{
    public class BopsFscCostMethod
    {
        private int _CostMethodId;
        private string _Name;
        private string _Description;

        public int CostMethodId
        {
            get { return _CostMethodId; }
            set { _CostMethodId = value; }
        }

        public string Name
        {
            get { return _Name; }
            set { _Name = value; }
        }

        public string Description
        {
            get { return _Description; }
            set { _Description = value; }
        }
    }
}
