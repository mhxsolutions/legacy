using System;

namespace BopsDataAccess
{
    public class BopsRfsInvoiceDetail : IEquatable<BopsRfsInvoiceDetail>
    {
        public enum InvoiceDetailType
        {
            ManualBill,
            ServiceBill,
            StorageBill
        }

        private const string _DefaultLocationCode = "201";

        private int _InvoiceRef;
        private int _LineNumber;
        private int? _ServiceCalculationResultRef;
        private DateTime _ItemDate;
        private string _ItemDescription;
        private double _ItemTotal;
        private string _GroupName;
        private int _LineNumberDisplayed;
        private int _ServiceOfferedRef;
        private string _LocationCode;
        private int? _StorageBillingDetailRef;
        private int? _ARTrnRecId;

        public int InvoiceRef
        {
            get { return _InvoiceRef; }
            set { _InvoiceRef = value; }
        }

        public int LineNumber
        {
            get { return _LineNumber; }
            set { _LineNumber = value; }
        }

        public int? ServiceCalculationResultRef
        {
            get { return _ServiceCalculationResultRef; }
            set { _ServiceCalculationResultRef = value; }
        }

        public DateTime ItemDate
        {
            get { return _ItemDate; }
            set { _ItemDate = value; }
        }

        public string ItemDescription
        {
            get { return _ItemDescription; }
            set { _ItemDescription = value; }
        }

        public double ItemTotal
        {
            get { return _ItemTotal; }
            set { _ItemTotal = Math.Round(value, 2); }
        }

        public string GroupName
        {
            get { return _GroupName; }
            set { _GroupName = value; }
        }

        public int LineNumberDisplayed
        {
            get { return _LineNumberDisplayed; }
            set { _LineNumberDisplayed = value; }
        }

        public int ServiceOfferedRef
        {
            get { return _ServiceOfferedRef; }
            set { _ServiceOfferedRef = value; }
        }

        public string LocationCode
        {
            get { return _LocationCode; }
            set { _LocationCode = value; }
        }

        public int? StorageBillingDetailRef
        {
            get { return _StorageBillingDetailRef; }
            set { _StorageBillingDetailRef = value; }
        }

        public bool IsServiceBill
        {
            get { return _ServiceCalculationResultRef.HasValue; }
        }

        public bool IsStorageBill
        {
            get { return _StorageBillingDetailRef.HasValue; }
        }

        public bool IsManualBill
        {
            get { return !_ServiceCalculationResultRef.HasValue && !_StorageBillingDetailRef.HasValue; }
        }

        public InvoiceDetailType DetailType
        {
            get
            {
                if (IsServiceBill)
                    return InvoiceDetailType.ServiceBill;

                return IsStorageBill ? InvoiceDetailType.StorageBill : InvoiceDetailType.ManualBill;
            }
        }

        public string DetailTypeString
        {
            get
            {
                if (IsServiceBill)
                    return "Service";

                return IsStorageBill ? "Storage" : "Manual";
            }
        }

        public int? ArTrnRecId
        {
            get { return _ARTrnRecId; }
            set { _ARTrnRecId = value; }
        }

        public BopsRfsInvoiceDetail()
        {
            _ItemDate = DateTime.Now.Date;
            _LocationCode = _DefaultLocationCode;
        }

        public BopsRfsInvoiceDetail(BopsRfsInvoiceDetail Rhs)
        {
            _InvoiceRef = Rhs._InvoiceRef;
            _LineNumber = Rhs._LineNumber;
            _ServiceCalculationResultRef = Rhs._ServiceCalculationResultRef;
            _ItemDate = Rhs._ItemDate;
            _ItemDescription = Rhs._ItemDescription;
            _ItemTotal = Rhs._ItemTotal;
            _GroupName = Rhs._GroupName;
            _LineNumberDisplayed = Rhs._LineNumberDisplayed;
            _ServiceOfferedRef = Rhs._ServiceOfferedRef;
            _LocationCode = Rhs._LocationCode;
            _StorageBillingDetailRef = Rhs._StorageBillingDetailRef;
            _ARTrnRecId = Rhs._ARTrnRecId;
        }

        public bool Equals(BopsRfsInvoiceDetail Obj)
        {
            if (ReferenceEquals(null, Obj)) return false;
            if (ReferenceEquals(this, Obj)) return true;
            return Obj._InvoiceRef == _InvoiceRef &&
                   Obj._LineNumber == _LineNumber &&
                   Obj._ServiceCalculationResultRef.Equals(_ServiceCalculationResultRef) &&
                   Obj._ItemDate.Equals(_ItemDate) &&
                   Equals(Obj._ItemDescription, _ItemDescription) &&
                   Obj._ItemTotal == _ItemTotal &&
                   Equals(Obj._GroupName, _GroupName) &&
                   Obj._LineNumberDisplayed == _LineNumberDisplayed &&
                   Obj._ServiceOfferedRef == _ServiceOfferedRef &&
                   Obj._LocationCode == _LocationCode &&
                   Obj._StorageBillingDetailRef == _StorageBillingDetailRef &&
                   Obj._ARTrnRecId == _ARTrnRecId;
        }

        public override bool Equals(object Obj)
        {
            if (ReferenceEquals(null, Obj)) return false;
            if (ReferenceEquals(this, Obj)) return true;
            if (Obj.GetType() != typeof (BopsRfsInvoiceDetail)) return false;
            return Equals((BopsRfsInvoiceDetail) Obj);
        }

        public override int GetHashCode()
        {
            unchecked
            {
                int Result = _InvoiceRef;
                Result = (Result*397) ^ _LineNumber;
                Result = (Result*397) ^ (_ServiceCalculationResultRef.HasValue ? _ServiceCalculationResultRef.Value : 0);
                Result = (Result*397) ^ _ItemDate.GetHashCode();
                Result = (Result*397) ^ (_ItemDescription != null ? _ItemDescription.GetHashCode() : 0);
                Result = (Result*397) ^ _ItemTotal.GetHashCode();
                Result = (Result*397) ^ (_GroupName != null ? _GroupName.GetHashCode() : 0);
                Result = (Result*397) ^ _LineNumberDisplayed;
                Result = (Result*397) ^ _ServiceOfferedRef;
                Result = (Result*397) ^ (_LocationCode != null ? _LocationCode.GetHashCode() : 0);
                Result = (Result*397) ^ (_StorageBillingDetailRef.HasValue ? _StorageBillingDetailRef.Value : 0);
                Result = (Result * 397) ^ (_ARTrnRecId.HasValue ? _ARTrnRecId.Value : 0);
                return Result;
            }
        }
    }
}
