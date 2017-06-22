namespace BopsDataAccess
{
    public class BopsRfsCostMatrix
    {
        private int _MatrixId;
        private string _Name;
        private int _UnitRef;
        private bool _Active;
        private double _DefaultCost;

        public int MatrixId
        {
            get { return _MatrixId; }
            set { _MatrixId = value; }
        }

        public string Name
        {
            get { return _Name; }
            set { _Name = value; }
        }

        public int UnitRef
        {
            get { return _UnitRef; }
            set { _UnitRef = value; }
        }

        public bool Active
        {
            get { return _Active; }
            set { _Active = value; }
        }

        public double DefaultCost
        {
            get { return _DefaultCost; }
            set { _DefaultCost = value; }
        }
    }
}
