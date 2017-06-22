using System;
using System.Collections.Generic;
using BopsDataAccess;

namespace BopsBusinessLogicRfs
{
    #region Helper Classes 

    /// <summary>
    /// Defines the details of a warehouse revenue calculation result.
    /// </summary>
    public class RfsWarehouseRevenueCalculationResult
    {
        private int _TotalReceivedDocuments;
        private int _TotalShippedDocuments;
        private int _TotalReceivedCalculated;
        private int _TotalShippedCalculated;
        private int _LoadsWithoutWarehouseService;
        private int _RevenueDeletedWithZeroRfs;
        private int _SkippedWithNullRfs;
        private int _ErrorCount;
        private int _AlreadyApproved;

        /// <summary>
        /// Total count of receivers.
        /// </summary>
        public int TotalReceivedDocuments
        {
            get { return _TotalReceivedDocuments; }
            set { _TotalReceivedDocuments = value; }
        }

        /// <summary>
        /// Total count of shippers (i.e., bills of lading)
        /// </summary>
        public int TotalShippedDocuments
        {
            get { return _TotalShippedDocuments; }
            set { _TotalShippedDocuments = value; }
        }

        /// <summary>
        /// Total count of receivers calculated.
        /// </summary>
        public int TotalReceivedCalculated
        {
            get { return _TotalReceivedCalculated; }
            set { _TotalReceivedCalculated = value; }
        }

        /// <summary>
        /// Total count of shippers (i.e., bills of lading) calculated.
        /// </summary>
        public int TotalShippedCalculated
        {
            get { return _TotalShippedCalculated; }
            set { _TotalShippedCalculated = value; }
        }

        /// <summary>
        /// Total count of loads that could not be calculated because they had no matching warehouse service.
        /// </summary>
        public int LoadsWithoutWarehouseService
        {
            get { return _LoadsWithoutWarehouseService; }
            set { _LoadsWithoutWarehouseService = value; }
        }

        /// <summary>
        /// Total count of documents that were skipped during calculation because their RFS value was set to zero.
        /// </summary>
        public int RevenueDeletedWithZeroRfs
        {
            get { return _RevenueDeletedWithZeroRfs; }
            set { _RevenueDeletedWithZeroRfs = value; }
        }

        /// <summary>
        /// Total count of documents that could not be calculated because their RFS value was not specified at all.
        /// </summary>
        public int SkippedWithNullRfs
        {
            get { return _SkippedWithNullRfs; }
            set { _SkippedWithNullRfs = value; }
        }

        /// <summary>
        /// Total count of calculation errors.
        /// </summary>
        public int ErrorCount
        {
            get { return _ErrorCount; }
            set { _ErrorCount = value; }
        }

        /// <summary>
        /// Total count of documents already approved in the invoicing process, which prevents them from being recalculated.
        /// </summary>
        public int AlreadyApproved
        {
            get { return _AlreadyApproved; }
            set { _AlreadyApproved = value; }
        }

        /// <summary>
        /// Renders the result as a text string.
        /// </summary>
        /// <returns>The generated string.</returns>
        public override string ToString()
        {
            return string.Format("{0} received calculated, {1} shipped calculated, {2} no service skipped, {3} null RFS, {4} zero RFS, {5} already approved",
                                 _TotalReceivedCalculated, _TotalShippedCalculated, _LoadsWithoutWarehouseService,
                                 _SkippedWithNullRfs, _RevenueDeletedWithZeroRfs, _AlreadyApproved);
        }
    }

    /// <summary>
    /// Defines the details of a load revenue calculation result.
    /// </summary>
    public class RfsLoadRevenueCalculationResult
    {
        private int _TotalLoads;
        private int _LoadsCalculated;
        private int _LoadsSkippedAsWillCall;
        private int _LoadsSkippedAsManualCalculation;
        private int _LoadsWithoutTransportationService;
        private int _RevenueDeletedWithZeroRfs;
        private int _SkippedWithNullRfs;
        private int _ErrorCount;
        private int _AlreadyApproved;

        /// <summary>
        /// Total count of loads.
        /// </summary>
        public int TotalLoads
        {
            get { return _TotalLoads; }
            set { _TotalLoads = value; }
        }

        /// <summary>
        /// Total count of loads calculated.
        /// </summary>
        public int LoadsCalculated
        {
            get { return _LoadsCalculated; }
            set { _LoadsCalculated = value; }
        }

        /// <summary>
        /// Total count of loads that were skipped during calculation because they were marked as will-call.
        /// </summary>
        public int LoadsSkippedAsWillCall
        {
            get { return _LoadsSkippedAsWillCall; }
            set { _LoadsSkippedAsWillCall = value; }
        }

        /// <summary>
        /// Total count of loads that were skipped during calculation because they already had a manual entry on file.
        /// </summary>
        public int LoadsSkippedAsManualCalculation
        {
            get { return _LoadsSkippedAsManualCalculation; }
            set { _LoadsSkippedAsManualCalculation = value; }
        }

        /// <summary>
        /// Total count of loads that could not be calculated because they had no matching transportation service.
        /// </summary>
        public int LoadsWithoutTransportationService
        {
            get { return _LoadsWithoutTransportationService; }
            set { _LoadsWithoutTransportationService = value; }
        }

        /// <summary>
        /// Total count of loads that were skipped during calculation because their RFS value was set to zero.
        /// </summary>
        public int RevenueDeletedWithZeroRfs
        {
            get { return _RevenueDeletedWithZeroRfs; }
            set { _RevenueDeletedWithZeroRfs = value; }
        }

        /// <summary>
        /// Total count of loads that could not be calculated because their RFS value was not specified at all.
        /// </summary>
        public int SkippedWithNullRfs
        {
            get { return _SkippedWithNullRfs; }
            set { _SkippedWithNullRfs = value; }
        }

        /// <summary>
        /// Total count of calculation errors.
        /// </summary>
        public int ErrorCount
        {
            get { return _ErrorCount; }
            set { _ErrorCount = value; }
        }

        /// <summary>
        /// Total count of loads already approved in the invoicing process, which prevents them from being recalculated.
        /// </summary>
        public int AlreadyApproved
        {
            get { return _AlreadyApproved; }
            set { _AlreadyApproved = value; }
        }

        /// <summary>
        /// Renders the result as a text string.
        /// </summary>
        /// <returns>The generated string.</returns>
        public override string ToString()
        {
            return string.Format("{0} calculated, {1} will call skipped, {2} manual skipped, {3} no service skipped, {4} null RFS, {5} zero RFS, {6} already approved",
                                 _LoadsCalculated, _LoadsSkippedAsWillCall, _LoadsSkippedAsManualCalculation, _LoadsWithoutTransportationService, 
                                 _SkippedWithNullRfs, _RevenueDeletedWithZeroRfs, _AlreadyApproved);
        }
    }

    /// <summary>
    /// Specifies the requisite input data for warehouse revenue calculations.
    /// </summary>
    public class WarehouseCalculationInputs
    {
        private int _DocumentId;
        private WarehouseDocumentType _DocumentType;
        private DateTime _DocumentDate;
        private int? _RfsRef;
        private BopsReceivingRecord _ReceiverDocument;
        private BopsShippingRecord _ShipperDocument;
        private BopsProductProfile _ProductProfile;

        /// <summary>
        /// Unique ID of the warehouse document.
        /// </summary>
        public int DocumentId
        {
            get { return _DocumentId; }
            set { _DocumentId = value; }
        }

        /// <summary>
        /// Specifies whether the warehouse document is a receiver or a shipper (i.e., bill of lading).
        /// </summary>
        public WarehouseDocumentType DocumentType
        {
            get { return _DocumentType; }
            set { _DocumentType = value; }
        }

        /// <summary>
        /// Date associated with the warehouse document.
        /// </summary>
        public DateTime DocumentDate
        {
            get { return _DocumentDate; }
            set { _DocumentDate = value; }
        }

        /// <summary>
        /// RFS number assigned to the warehouse document.
        /// </summary>
        public int? RfsRef
        {
            get { return _RfsRef; }
            set { _RfsRef = value; }
        }

        /// <summary>
        /// Receiver record, which is null if the document is not a receiver.
        /// </summary>
        public BopsReceivingRecord ReceiverDocument
        {
            get { return _ReceiverDocument; }
            set { _ReceiverDocument = value; }
        }

        /// <summary>
        /// Shipper record, which is null if the document is not a shipper (i.e., bill of lading).
        /// </summary>
        public BopsShippingRecord ShipperDocument
        {
            get { return _ShipperDocument; }
            set { _ShipperDocument = value; }
        }

        /// <summary>
        /// Product profile for the warehouse document, if available.
        /// </summary>
        public BopsProductProfile ProductProfile
        {
            get { return _ProductProfile; }
            set { _ProductProfile = value; }
        }

        public int GetPostedCount()
        {
            if (_DocumentType == WarehouseDocumentType.Received && _ReceiverDocument != null)
                return _ReceiverDocument.PostedCount ?? 0;
            if (_DocumentType == WarehouseDocumentType.Shipped && _ShipperDocument != null)
                return _ShipperDocument.PostedCount ?? 0;

            return 0;
        }
    }

    #endregion

    /// <summary>
    /// The interface defined by the RFS system for calculating RFS revenue.
    /// </summary>
    public interface IRfsRevenueCalculator
    {
        /// <summary>
        /// Precaches all RFS data relevant to the calculation process. If only a few calculations are to be performed,
        /// then this method is likely counterproductive. If many calculations are to be performed, then calling this
        /// method ahead of time will greatly speed operations.
        /// </summary>
        void PrecacheRfsData();

        /// <summary>
        /// Calculates RFS revenue for the specified list of loads.
        /// </summary>
        /// <param name="loads">The loads for which revenue is to be calculated.</param>
        /// <param name="returnValue">References an object into which the results will be set.</param>
        void CalculateLoadRevenue(IList<BopsLoad> loads, RfsLoadRevenueCalculationResult returnValue);

        /// <summary>
        /// Calculates RFS revenue for all loads whose load date is greater than or equal to the begin date but less than the end date.
        /// </summary>
        /// <param name="beginDate">Beginning date for the range of calculations.</param>
        /// <param name="endDate">Ending date for the range of calculations.</param>
        /// <returns>A load revenue calculation result object containing the results.</returns>
        RfsLoadRevenueCalculationResult CalculateLoadRevenue(DateTime beginDate, DateTime endDate);

        /// <summary>
        /// Calculates RFS revenue for the specified list of warehouse documents.
        /// </summary>
        /// <param name="documents">The warehouse documents for which revenue is to be calculated.</param>
        /// <param name="returnValue">References an object into which the results will be set.</param>
        void CalculateWarehouseRevenue(IList<WarehouseCalculationInputs> documents, RfsWarehouseRevenueCalculationResult returnValue);

        /// <summary>
        /// Calculates RFS revenue for all warehouse documents whose date is greater than or equal to the begin date but less than the end date.
        /// </summary>
        /// <param name="beginDate">Beginning date for the range of calculations.</param>
        /// <param name="endDate">Ending date for the range of calculations.</param>
        /// <returns></returns>
        RfsWarehouseRevenueCalculationResult CalculateWarehouseRevenue(DateTime beginDate, DateTime endDate);

        /// <summary>
        /// Cleans (i.e., deletes) invalid calculation results from the database. It is possible in our system for a user
        /// to create a receiver/load/shipper, which is later deleted for a variety of reasons. In such cases, because we
        /// don't have a client-server architecture, deleting the main entity does not delete the revenue. This method
        /// purges revenue records for receivers/loads/shippers that no longer exist.
        /// </summary>
        void CleanInvalidRevenueResults();
    }
}
