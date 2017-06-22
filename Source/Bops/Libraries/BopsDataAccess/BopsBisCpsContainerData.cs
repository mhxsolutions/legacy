namespace BopsDataAccess
{
    public class BopsBisCpsContainerData
    {
        private int _ProjectRef;
        private string _ContainerRef;
        private int _BisFinalTransactionRef;
        private string _SealId;
        private string _TestId;
        private string _BillOfLading;

        public int ProjectRef
        {
            get { return _ProjectRef; }
            set { _ProjectRef = value; }
        }

        public string ContainerRef
        {
            get { return _ContainerRef; }
            set { _ContainerRef = value; }
        }

        public int BisFinalTransactionRef
        {
            get { return _BisFinalTransactionRef; }
            set { _BisFinalTransactionRef = value; }
        }

        public string SealId
        {
            get { return _SealId; }
            set { _SealId = value; }
        }

        public string TestId
        {
            get { return _TestId; }
            set { _TestId = value; }
        }

        public string BillOfLading
        {
            get { return _BillOfLading; }
            set { _BillOfLading = value; }
        }

        public BopsBisCpsContainerData()
        {
        }

        public BopsBisCpsContainerData(int ProjectRef, string ContainerRef, int BisFinalTransactionRef)
        {
            _ProjectRef = ProjectRef;
            _ContainerRef = ContainerRef;
            _BisFinalTransactionRef = BisFinalTransactionRef;
        }

        public bool Equals(BopsBisCpsContainerData Other)
        {
            if (ReferenceEquals(null, Other)) return false;
            if (ReferenceEquals(this, Other)) return true;
            return Other._ProjectRef == _ProjectRef && Equals(Other._ContainerRef, _ContainerRef) && Other._BisFinalTransactionRef == _BisFinalTransactionRef && Equals(Other._SealId, _SealId) && Equals(Other._TestId, _TestId) && Equals(Other._BillOfLading, _BillOfLading);
        }

        public override bool Equals(object Obj)
        {
            if (ReferenceEquals(null, Obj)) return false;
            if (ReferenceEquals(this, Obj)) return true;
            if (Obj.GetType() != typeof (BopsBisCpsContainerData)) return false;
            return Equals((BopsBisCpsContainerData) Obj);
        }

        public override int GetHashCode()
        {
            unchecked
            {
                int Result = _ProjectRef;
                Result = (Result*397) ^ (_ContainerRef != null ? _ContainerRef.GetHashCode() : 0);
                Result = (Result*397) ^ _BisFinalTransactionRef;
                Result = (Result*397) ^ (_SealId != null ? _SealId.GetHashCode() : 0);
                Result = (Result*397) ^ (_TestId != null ? _TestId.GetHashCode() : 0);
                Result = (Result*397) ^ (_BillOfLading != null ? _BillOfLading.GetHashCode() : 0);
                return Result;
            }
        }
    }
}
