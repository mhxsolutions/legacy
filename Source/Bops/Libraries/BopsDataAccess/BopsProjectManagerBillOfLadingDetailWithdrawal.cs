namespace BopsDataAccess
{
    public class BopsProjectManagerBillOfLadingDetailWithdrawal
    {
        private int _WithdrawalId;
        private int? _DetailRef;
        private int? _DrRef;

        public int WithdrawalId
        {
            get { return _WithdrawalId; }
            set { _WithdrawalId = value; }
        }

        public int? DetailRef
        {
            get { return _DetailRef; }
            set { _DetailRef = value; }
        }

        public int? DrRef
        {
            get { return _DrRef; }
            set { _DrRef = value; }
        }
    }
}
