namespace BopsDataAccess
{
    public class BopsSysUnitOfMeasure
    {
        private int _UnitId;
        private string _Name;

        public int UnitId
        {
            get { return _UnitId; }
            set { _UnitId = value; }
        }

        public string Name
        {
            get { return _Name; }
            set { _Name = value; }
        }
    }
}
