using System;

namespace BopsDataAccess
{
    public enum RfsCalculationResultType
    {
        Success,
        ManualCalculation,
        NullRfs,
        ZeroRfs,
        WillCall,
        NoServiceMatch,
        InvalidCostMethod,
        SoftwareException,
        InvalidRfs,
        ServiceCalculationErrors,
        AlreadyInvoiced
    }

    public enum FscCalculationResultType
    {
        Success,

        // General error codes
        NotCalculated,
        InvalidManualRevenue,
        InvalidMileage,
        InvalidFscId,
        InvalidFscCostMethod,
        InvalidLogoutDate,

        // Errors specific to float-indexed lookup
        FloatLookupFuelPriceUnavailable,
        FloatLookupSurchargeUnavailable,

        // Errors specific to O/D-indexed lookup
        OdLookupFailureInvalidMatchMode,
        OdLookupFailureNoMatch,

        // Catch-all error code for things that shouldn't be possible
        UnknownError
    }

    public class BopsRfsCalculationResult
    {
        private int _ResultId;
        private string _LoadReference;
        private RfsCalculationResultType _ResultType;
        private DateTime _LastCalculation;
        private bool _Resolved;
        private bool _DoNotUpdate;
        private int? _WarehouseDocumentId;
        private WarehouseDocumentType? _WarehouseDocumentType;

        public int ResultId
        {
            get { return _ResultId; }
            set { _ResultId = value; }
        }

        public string LoadReference
        {
            get { return _LoadReference; }
            set { _LoadReference = value; }
        }

        public RfsCalculationResultType ResultType
        {
            get { return _ResultType; }
            set { _ResultType = value; }
        }

        public DateTime LastCalculation
        {
            get { return _LastCalculation; }
            set { _LastCalculation = value; }
        }

        public bool Resolved
        {
            get { return _Resolved; }
            set { _Resolved = value; }
        }

        public bool DoNotUpdate
        {
            get { return _DoNotUpdate; }
            set { _DoNotUpdate = value; }
        }

        public int? WarehouseDocumentId
        {
            get { return _WarehouseDocumentId; }
            set { _WarehouseDocumentId = value; }
        }

        public WarehouseDocumentType? WarehouseDocumentType
        {
            get { return _WarehouseDocumentType; }
            set { _WarehouseDocumentType = value; }
        }

        public BopsRfsCalculationResult()
        {
        }

        public BopsRfsCalculationResult(string _LoadReference)
        {
            this._LoadReference = _LoadReference;
        }

        public BopsRfsCalculationResult(int _WarehouseDocumentId, WarehouseDocumentType _WarehouseDocumentType)
        {
            this._WarehouseDocumentId = _WarehouseDocumentId;
            this._WarehouseDocumentType = _WarehouseDocumentType;
        }
    }
}
