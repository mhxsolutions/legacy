using System;

namespace BopsDataAccess
{
    public class BopsPickupRequest
    {
        private int _PickupRequestId;
        private DateTime? _PickupDate;
        private DateTime? _PickUpAptTime;
        private string _ReleaseNumber;
        private int? _ShipperRef;
        private int? _LocationRef;
        private string _PickupAddress;
        private int? _CommodityRef;
        private int? _ReceiverRef;
        private int? _DeliveryRef;
        private string _DeliveryAddress;
        private int? _PurShipperRef;
        private int? _PurReceiverRef;
        private int? _PurBillToRef;
        private string _Comments;
        private DateTime? _CreateDate;
        private DateTime? _ModificationDate;
        private string _Editor;
        private bool _Printed;
        private string _CreatedBy;
        private string _ModifiedBy;
        private int? _LogRef;
        private bool _BillThisLoad;
        private bool _ShipBlind;
        private int? _RfsRef;
        private int? _FleetRef;
        private string _ClientInvoiceData;

        public int PickupRequestId
        {
            get { return _PickupRequestId; }
            set { _PickupRequestId = value; }
        }

        public DateTime? PickupDate
        {
            get { return _PickupDate; }
            set { _PickupDate = value; }
        }

        public DateTime? PickUpAptTime
        {
            get { return _PickUpAptTime; }
            set { _PickUpAptTime = value; }
        }

        public string ReleaseNumber
        {
            get { return _ReleaseNumber; }
            set { _ReleaseNumber = value; }
        }

        public int? ShipperRef
        {
            get { return _ShipperRef; }
            set { _ShipperRef = value; }
        }

        public int? LocationRef
        {
            get { return _LocationRef; }
            set { _LocationRef = value; }
        }

        public string PickupAddress
        {
            get { return _PickupAddress; }
            set { _PickupAddress = value; }
        }

        public int? CommodityRef
        {
            get { return _CommodityRef; }
            set { _CommodityRef = value; }
        }

        public int? ReceiverRef
        {
            get { return _ReceiverRef; }
            set { _ReceiverRef = value; }
        }

        public int? DeliveryRef
        {
            get { return _DeliveryRef; }
            set { _DeliveryRef = value; }
        }

        public string DeliveryAddress
        {
            get { return _DeliveryAddress; }
            set { _DeliveryAddress = value; }
        }

        public int? PurShipperRef
        {
            get { return _PurShipperRef; }
            set { _PurShipperRef = value; }
        }

        public int? PurReceiverRef
        {
            get { return _PurReceiverRef; }
            set { _PurReceiverRef = value; }
        }

        public int? PurBillToRef
        {
            get { return _PurBillToRef; }
            set { _PurBillToRef = value; }
        }

        public string Comments
        {
            get { return _Comments; }
            set { _Comments = value; }
        }

        public DateTime? CreateDate
        {
            get { return _CreateDate; }
            set { _CreateDate = value; }
        }

        public DateTime? ModificationDate
        {
            get { return _ModificationDate; }
            set { _ModificationDate = value; }
        }

        public string Editor
        {
            get { return _Editor; }
            set { _Editor = value; }
        }

        public bool Printed
        {
            get { return _Printed; }
            set { _Printed = value; }
        }

        public string CreatedBy
        {
            get { return _CreatedBy; }
            set { _CreatedBy = value; }
        }

        public string ModifiedBy
        {
            get { return _ModifiedBy; }
            set { _ModifiedBy = value; }
        }

        public int? LogRef
        {
            get { return _LogRef; }
            set { _LogRef = value; }
        }

        public bool BillThisLoad
        {
            get { return _BillThisLoad; }
            set { _BillThisLoad = value; }
        }

        public bool ShipBlind
        {
            get { return _ShipBlind; }
            set { _ShipBlind = value; }
        }

        public int? RfsRef
        {
            get { return _RfsRef; }
            set { _RfsRef = value; }
        }

        public int? FleetRef
        {
            get { return _FleetRef; }
            set { _FleetRef = value; }
        }

        public string ClientInvoiceData
        {
            get { return _ClientInvoiceData; }
            set { _ClientInvoiceData = value; }
        }
    }
}
