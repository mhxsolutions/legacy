namespace BopsDataAccess
{
    public class HopsDrEntryItem
    {
        private int _DrItemId;
        private int _HopsDrRef;
        private string _ItemId;
        private int _BopsBolDetailRef;

        public int DrItemId
        {
            get { return _DrItemId; }
            set { _DrItemId = value; }
        }

        public int HopsDrRef
        {
            get { return _HopsDrRef; }
            set { _HopsDrRef = value; }
        }

        public string ItemId
        {
            get { return _ItemId; }
            set { _ItemId = value; }
        }

        public int BopsBolDetailRef
        {
            get { return _BopsBolDetailRef; }
            set { _BopsBolDetailRef = value; }
        }
    }
}
