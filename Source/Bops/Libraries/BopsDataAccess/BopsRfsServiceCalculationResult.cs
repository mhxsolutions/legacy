
using System;

namespace BopsDataAccess
{
    /// <summary>
    /// Billing status used for the invoice system. A billing document proceeds through several stages,
    /// first pending review, then approved, then on an invoice, and ultimate invoiced.
    /// </summary>
    public enum RfsBillingStatus
    {
        None,
        PendingReview,
        Approved,
        OnInvoice,
        Invoiced,
        Exported
    }

    /// <summary>
    /// Models calculation results for a particular RFS service requested against a given load or warehouse document.
    /// </summary>
    public class BopsRfsServiceCalculationResult
    {
        #region Rate Details Helper Class

        /// <summary>
        /// Models details of applying a particular rate, perhaps including FSC, against a given load or warehouse document.
        /// </summary>
        public class RateDetails
        {
            private RfsCalculationResultType _RfsResult;
            private FscCalculationResultType _FscResult;
            private double _RfsRevenue;
            private double _FscRevenue;
            private string _CalculationDetails;

            private double _Weight;     // Not persisted to the database

            /// <summary>
            /// Result code for the revenue portion of the calculation.
            /// </summary>
            public RfsCalculationResultType RfsResult
            {
                get { return _RfsResult; }
                set { _RfsResult = value; }
            }

            /// <summary>
            /// Result code for the fuel surcharge portion of the calculation.
            /// </summary>
            public FscCalculationResultType FscResult
            {
                get { return _FscResult; }
                set { _FscResult = value; }
            }

            /// <summary>
            /// Calculated revenue.
            /// </summary>
            public double RfsRevenue
            {
                get { return _RfsRevenue; }
                set { _RfsRevenue = Math.Round(value, 2); }
            }

            /// <summary>
            /// Calculated fuel surcharge revenue.
            /// </summary>
            public double FscRevenue
            {
                get { return _FscRevenue; }
                set { _FscRevenue = Math.Round(value, 2); }
            }

            /// <summary>
            /// User-readable details of the calculation (used for invoicing).
            /// </summary>
            public string CalculationDetails
            {
                get { return _CalculationDetails; }
                set { _CalculationDetails = value; }
            }

            /// <summary>
            /// Calculated weight (not persisted to the database).
            /// </summary>
            public double Weight
            {
                get { return _Weight; }
                set { _Weight = value; }
            }
        }

        #endregion

        private int _ResultId;
        private string _LoadRef;
        private int _ServiceId;
        private RfsCalculationScopeType _CalculationScope;
        private RateDetails _PrivateRate;
        private RateDetails _PublicRate;
        private int? _DocumentId;
        private WarehouseDocumentType? _DocumentType;
        private DateTime? _BillingDate;
        private RfsBillingStatus _BillingStatus;

        /// <summary>
        /// Unique ID for the service calculation result.
        /// </summary>
        public int ResultId
        {
            get { return _ResultId; }
            set { _ResultId = value; }
        }

        /// <summary>
        /// Load reference or null if the result is for a warehouse document.
        /// </summary>
        public string LoadRef
        {
            get { return _LoadRef; }
            set { _LoadRef = value; }
        }

        /// <summary>
        /// ID of the service requested used in the calculation.
        /// </summary>
        public int ServiceId
        {
            get { return _ServiceId; }
            set { _ServiceId = value; }
        }

        /// <summary>
        /// Bit-flags indicating the scope of the calculation (private, public, or both).
        /// </summary>
        public RfsCalculationScopeType CalculationScope
        {
            get { return _CalculationScope; }
            set { _CalculationScope = value; }
        }

        /// <summary>
        /// The details for the private side of the rate.
        /// </summary>
        public RateDetails PrivateRate
        {
            get { return _PrivateRate; }
            set { _PrivateRate = value; }
        }

        /// <summary>
        /// The details for the public side of the rate.
        /// </summary>
        public RateDetails PublicRate
        {
            get { return _PublicRate; }
            set { _PublicRate = value; }
        }

        /// <summary>
        /// The warehouse document ID or null if the result is for a load.
        /// </summary>
        public int? DocumentId
        {
            get { return _DocumentId; }
            set { _DocumentId = value; }
        }

        /// <summary>
        /// The warehouse document type or null if the result is for a load.
        /// </summary>
        public WarehouseDocumentType? DocumentType
        {
            get { return _DocumentType; }
            set { _DocumentType = value; }
        }

        /// <summary>
        /// Billing date for the load or warehouse document.
        /// </summary>
        public DateTime? BillingDate
        {
            get { return _BillingDate; }
            set { _BillingDate = value; }
        }

        /// <summary>
        /// Status of the calculation result used by the invoice process.
        /// </summary>
        public RfsBillingStatus BillingStatus
        {
            get { return _BillingStatus; }
            set { _BillingStatus = value; }
        }

        /// <summary>
        /// Company ID reference.
        /// </summary>
        /// <value>The company identifier reference.</value>
        public int CompanyRef { get; set; }

        public BopsRfsServiceCalculationResult()
        {
            _PrivateRate = new RateDetails();
            _PublicRate = new RateDetails();
        }

        /// <summary>
        /// True if the result is for a warehouse receiver.
        /// </summary>
        public bool IsReceiver
        {
            get { return _DocumentType.HasValue && _DocumentType == WarehouseDocumentType.Received; }
        }

        /// <summary>
        /// True if the result is for a warehouse bill of lading.
        /// </summary>
        public bool IsBillOfLading
        {
            get { return _DocumentType.HasValue && _DocumentType == WarehouseDocumentType.Shipped; }
        }

        /// <summary>
        /// True if the result is for a load.
        /// </summary>
        public bool IsLoad
        {
            get { return !string.IsNullOrEmpty(_LoadRef); }
        }

        /// <summary>
        /// Constructs a result for a load.
        /// </summary>
        /// <param name="_LoadRef">Load reference of the calculation.</param>
        /// <param name="_ServiceId">ID of the RFS service requested of the calculation.</param>
        public BopsRfsServiceCalculationResult(string _LoadRef, int _ServiceId) : this()
        {
            this._LoadRef = _LoadRef;
            this._ServiceId = _ServiceId;
        }

        /// <summary>
        /// Constructs a result for a warehouse document.
        /// </summary>
        /// <param name="_DocumentId">Warehouse document ID of the calculation.</param>
        /// <param name="_DocumentType">Warehouse document type of the calculation.</param>
        /// <param name="_ServiceId">ID of the RFS service requested of the calculation.</param>
        public BopsRfsServiceCalculationResult(int _DocumentId, WarehouseDocumentType _DocumentType, int _ServiceId)
        {
            this._DocumentId = _DocumentId;
            this._DocumentType = _DocumentType;
            this._ServiceId = _ServiceId;
        }

        /// <summary>
        /// Provides a user-readable description of the calculation result.
        /// </summary>
        /// <returns>A string value including the item type and item ID for the result.</returns>
        public override string ToString()
        {
            string ItemTypeString, ItemIdString;

            if (_DocumentType.HasValue && (_DocumentType.Value == WarehouseDocumentType.Received))
            {
                ItemTypeString = "receiver";
                ItemIdString = _DocumentId.ToString();
            }
            else if (_DocumentType.HasValue && (_DocumentType.Value == WarehouseDocumentType.Shipped))
            {
                ItemTypeString = "shipper";
                ItemIdString = _DocumentId.ToString();
            }
            else
            {
                ItemTypeString = "load";
                ItemIdString = _LoadRef;
            }

            return string.Format("RFS service calculation result {0} for {1} {2}", _ResultId, ItemTypeString, ItemIdString);
        }
    }
}
