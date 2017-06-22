namespace BopsDataAccess
{
    public class BopsAtsfProduct
    {
        private int _AtsfProductId;
        private string _Name;
        private bool _BisEnable;

        public int AtsfProductId
        {
            get { return _AtsfProductId; }
            set { _AtsfProductId = value; }
        }

        public string Name
        {
            get { return _Name; }
            set { _Name = value; }
        }

        public bool BisEnable
        {
            get { return _BisEnable; }
            set { _BisEnable = value; }
        }

        public override string ToString()
        {
            return _Name;
        }
    }
}
