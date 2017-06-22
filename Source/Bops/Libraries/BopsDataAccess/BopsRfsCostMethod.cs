namespace BopsDataAccess
{
    public class BopsRfsCostMethod
    {
        private int _CostMethodId;
        private string _Name;

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
    }
}
