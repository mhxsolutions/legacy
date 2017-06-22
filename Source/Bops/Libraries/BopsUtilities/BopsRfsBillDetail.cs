using BopsDataAccess;

namespace BopsUtilities
{
    public class BopsRfsBillDetail
    {
        private readonly BopsRfsServiceCalculationResult _ServiceResult;
        private readonly BopsDestination _ShipperClient;
        private readonly BopsDestination _BillToClient;
        private BopsLoad _Load;
        private BopsReceivingRecord _Receiver;
        private BopsShippingRecord _Shipper;

        public BopsRfsServiceCalculationResult ServiceResult
        {
            get { return _ServiceResult; }
        }

        public BopsDestination ShipperClient
        {
            get { return _ShipperClient; }
        }

        public BopsDestination BillToClient
        {
            get { return _BillToClient; }
        }

        public BopsLoad Load
        {
            get { return _Load; }
            set { _Load = value; }
        }

        public BopsReceivingRecord Receiver
        {
            get { return _Receiver; }
            set { _Receiver = value; }
        }

        public BopsShippingRecord Shipper
        {
            get { return _Shipper; }
            set { _Shipper = value; }
        }

        public BopsRfsBillDetail(BopsRfsServiceCalculationResult ServiceResult, BopsDestination ShipperClient, BopsDestination BillToClient)
        {
            _ServiceResult = ServiceResult;
            _ShipperClient = ShipperClient;
            _BillToClient = BillToClient;
        }

        public int RfsRef
        {
            get
            {
                int ReturnValue = -1;

                if (_Receiver != null && _Receiver.RfsRef.HasValue)
                    ReturnValue = _Receiver.RfsRef.Value;
                else if (_Shipper != null && _Shipper.RfsRef.HasValue)
                    ReturnValue = Shipper.RfsRef.Value;
                else if (_Load != null && _Load.RfsRef.HasValue)
                    ReturnValue = _Load.RfsRef.Value;

                return ReturnValue;
            }
        }
    }

}
