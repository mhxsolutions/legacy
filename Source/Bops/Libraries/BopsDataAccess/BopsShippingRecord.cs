using System;

namespace BopsDataAccess
{
    public class BopsShippingRecord
    {
        private int _LoadId;
        private DateTime? _ShipmentDate;
        private string _LoadType;
        private int? _ShippingClientRef;
        private string _ShipperAddress;
        private int? _DeliveryClientRef;
        private string _DeliveryAddress;
        private string _ShipperNumber;
        private string _Terminal;
        private string _WithdrawalComment;
        private int? _ShippingRef;
        private string _WithdrawalEditor;
        private int? _ShipRecLock;
        private string _ClientInvoiceData;
        private string _RailcarRef;
        private string _ShipperInvoice;
        private string _ReceiverPurchaseOrder;
        private DateTime? _CreationDate;
        private DateTime? _ConfirmShipment;
        private int? _RfsRef;
        private int? _PostedWeight;
        private int? _PostedCount;
        private RfsBillingStatus _BillingStatus;
        private int? _FleetRef;

        public int LoadId
        {
            get { return _LoadId; }
            set { _LoadId = value; }
        }

        public DateTime? ShipmentDate
        {
            get { return _ShipmentDate; }
            set { _ShipmentDate = value; }
        }

        public string LoadType
        {
            get { return _LoadType; }
            set { _LoadType = value; }
        }

        public int? ShippingClientRef
        {
            get { return _ShippingClientRef; }
            set { _ShippingClientRef = value; }
        }

        public string ShipperAddress
        {
            get { return _ShipperAddress; }
            set { _ShipperAddress = value; }
        }

        public int? DeliveryClientRef
        {
            get { return _DeliveryClientRef; }
            set { _DeliveryClientRef = value; }
        }

        public string DeliveryAddress
        {
            get { return _DeliveryAddress; }
            set { _DeliveryAddress = value; }
        }

        public string ShipperNumber
        {
            get { return _ShipperNumber; }
            set { _ShipperNumber = value; }
        }

        public string Terminal
        {
            get { return _Terminal; }
            set { _Terminal = value; }
        }

        public string WithdrawalComment
        {
            get { return _WithdrawalComment; }
            set { _WithdrawalComment = value; }
        }

        public int? ShippingRef
        {
            get { return _ShippingRef; }
            set { _ShippingRef = value; }
        }

        public string WithdrawalEditor
        {
            get { return _WithdrawalEditor; }
            set { _WithdrawalEditor = value; }
        }

        public int? ShipRecLock
        {
            get { return _ShipRecLock; }
            set { _ShipRecLock = value; }
        }

        public string ClientInvoiceData
        {
            get { return _ClientInvoiceData; }
            set { _ClientInvoiceData = value; }
        }

        public string RailcarRef
        {
            get { return _RailcarRef; }
            set { _RailcarRef = value; }
        }

        public string ShipperInvoice
        {
            get { return _ShipperInvoice; }
            set { _ShipperInvoice = value; }
        }

        public string ReceiverPurchaseOrder
        {
            get { return _ReceiverPurchaseOrder; }
            set { _ReceiverPurchaseOrder = value; }
        }

        public DateTime? CreationDate
        {
            get { return _CreationDate; }
            set { _CreationDate = value; }
        }

        public DateTime? ConfirmShipment
        {
            get { return _ConfirmShipment; }
            set { _ConfirmShipment = value; }
        }

        public int? RfsRef
        {
            get { return _RfsRef; }
            set { _RfsRef = value; }
        }

        public int? PostedWeight
        {
            get { return _PostedWeight; }
            set { _PostedWeight = value; }
        }

        public int? PostedCount
        {
            get { return _PostedCount; }
            set { _PostedCount = value; }
        }

        public RfsBillingStatus BillingStatus
        {
            get { return _BillingStatus; }
            set { _BillingStatus = value; }
        }

        public int? FleetRef
        {
            get { return _FleetRef; }
            set { _FleetRef = value; }
        }

        public double? SpecialInvoiceValue { get; set; }
    }
}
