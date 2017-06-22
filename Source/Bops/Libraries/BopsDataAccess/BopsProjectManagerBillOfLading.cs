namespace BopsDataAccess
{
    public class BopsProjectManagerBillOfLading
    {
        private int _BolId;
        private int _PmdoRef;
        private string _Bol1;
        private string _Bol2;
        private string _Bol3;
        private string _Bol4;
        private string _Bol5;
        private int? _Count;
        private double? _Weight;
        private string _WeightUnit;
        private string _ClientNumber;
        private string _Description;
        private int? _LoadCount;
        private int? _DestinationRef;
        private string _Destination;
        private int? _ReceiverRef;
        private string _Receiver;

        public int BolId
        {
            get { return _BolId; }
            set { _BolId = value; }
        }

        public int PmdoRef
        {
            get { return _PmdoRef; }
            set { _PmdoRef = value; }
        }

        public string Bol1
        {
            get { return _Bol1; }
            set { _Bol1 = value; }
        }

        public string Bol2
        {
            get { return _Bol2; }
            set { _Bol2 = value; }
        }

        public string Bol3
        {
            get { return _Bol3; }
            set { _Bol3 = value; }
        }

        public string Bol4
        {
            get { return _Bol4; }
            set { _Bol4 = value; }
        }

        public string Bol5
        {
            get { return _Bol5; }
            set { _Bol5 = value; }
        }

        public int? Count
        {
            get { return _Count; }
            set { _Count = value; }
        }

        public double? Weight
        {
            get { return _Weight; }
            set { _Weight = value; }
        }

        public string WeightUnit
        {
            get { return _WeightUnit; }
            set { _WeightUnit = value; }
        }

        public string ClientNumber
        {
            get { return _ClientNumber; }
            set { _ClientNumber = value; }
        }

        public string Description
        {
            get { return _Description; }
            set { _Description = value; }
        }

        public int? LoadCount
        {
            get { return _LoadCount; }
            set { _LoadCount = value; }
        }

        public int? DestinationRef
        {
            get { return _DestinationRef; }
            set { _DestinationRef = value; }
        }

        public string Destination
        {
            get { return _Destination; }
            set { _Destination = value; }
        }

        public int? ReceiverRef
        {
            get { return _ReceiverRef; }
            set { _ReceiverRef = value; }
        }

        public string Receiver
        {
            get { return _Receiver; }
            set { _Receiver = value; }
        }
    }
}
