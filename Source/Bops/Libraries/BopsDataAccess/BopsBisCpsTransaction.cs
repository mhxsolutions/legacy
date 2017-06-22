namespace BopsDataAccess
{
    public class BopsBisCpsTransaction
    {
        private int _ProjectRef;
        private string _ContainerRef;
        private int _BisTransactionRef;

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

        public int BisTransactionRef
        {
            get { return _BisTransactionRef; }
            set { _BisTransactionRef = value; }
        }

        public BopsBisCpsTransaction()
        {
        }

        public BopsBisCpsTransaction(int ProjectRef, string ContainerRef, int BisTransactionRef)
        {
            _ProjectRef = ProjectRef;
            _ContainerRef = ContainerRef;
            _BisTransactionRef = BisTransactionRef;
        }

        public bool Equals(BopsBisCpsTransaction Other)
        {
            if (ReferenceEquals(null, Other)) return false;
            if (ReferenceEquals(this, Other)) return true;
            return Other._ProjectRef == _ProjectRef && Equals(Other._ContainerRef, _ContainerRef) && Other._BisTransactionRef == _BisTransactionRef;
        }

        public override bool Equals(object Obj)
        {
            if (ReferenceEquals(null, Obj)) return false;
            if (ReferenceEquals(this, Obj)) return true;
            if (Obj.GetType() != typeof (BopsBisCpsTransaction)) return false;
            return Equals((BopsBisCpsTransaction) Obj);
        }

        public override int GetHashCode()
        {
            unchecked
            {
                int Result = _ProjectRef;
                Result = (Result*397) ^ (_ContainerRef != null ? _ContainerRef.GetHashCode() : 0);
                Result = (Result*397) ^ _BisTransactionRef;
                return Result;
            }
        }
    }
}
