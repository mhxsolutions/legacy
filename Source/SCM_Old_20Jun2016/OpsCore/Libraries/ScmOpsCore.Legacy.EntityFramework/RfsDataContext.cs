using System;
using System.Collections.Generic;
using System.Linq;
using BopsDataAccess;
using Scm.OpsCore.Legacy.DataLayer;

namespace ScmOpsCore.Legacy.EntityFramework
{
    /// <summary>
    /// Entity Framework implementation of the <see cref="IRfsDataContext"/> interface.
    /// </summary>
    public class RfsDataContext : IRfsDataContext
    {
        public int SaveChanges()
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsStatus> GetStatuses()
        {
            throw new System.NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsBillingStatus> GetBillingStatuses()
        {
            var context = new RfsDbContext();
            var query = from s in context.BillingStatuses select s;
            return query.ToList();
        }

        /// <inheritdoc/>
        public BopsRfsBillingStatus GetBillingStatusById(int id)
        {
            throw new System.NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsInvoiceStatus> GetInvoiceStatuses()
        {
            throw new System.NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsCalculationResultType> GetCalculationResultTypes()
        {
            throw new System.NotImplementedException();
        }

        /// <inheritdoc/>
        public BopsLoad GetLoadByReference(string loadReference)
        {
            throw new System.NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsLoad> GetLoadsByReferences(string[] loadReferences)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsLoad> GetLoadsByLoadDateRange(DateTime beginDate, DateTime endDate)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsCalculationResult> GetCalculationResultsByLoadReference(string loadReference)
        {
            throw new System.NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsCalculationResult> GetCalculationResultsByLoadReferences(string[] loadReferences)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsServiceCalculationResult> GetServiceCalculationResultsByLoadReferences(string[] loadReferences)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsServiceCalculationResult> GetServiceCalculationResultsByIds(int[] resultIds)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsServiceCalculationResult> GetServiceCalculationResultsByLoadReference(string loadReference)
        {
            throw new System.NotImplementedException();
        }

        /// <inheritdoc/>
        public BopsRfsServiceCalculationResult GetServiceCalculationResultById(int serviceCalculationResultId)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public BopsReceivingRecord GetReceiverById(int receiverId)
        {
            throw new System.NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsReceivingRecord> GetReceiversByIDs(int[] receiverIds)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsReceivingRecord> GetReceiversByDateReceivedRange(DateTime beginDate, DateTime endDate)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public BopsShippingRecord GetShipperById(int shipperId)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsShippingRecord> GetShippersByIDs(int[] shipperIds)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsShippingRecord> GetShippersByShipmentDateRange(DateTime beginDate, DateTime endDate)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsCalculationResult> GetCalculationResultsByReceiverId(int receiverId)
        {
            throw new System.NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsServiceCalculationResult> GetServiceCalculationResultsByReceiverId(int receiverId)
        {
            throw new System.NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsServiceCalculationResult> GetServiceCalculationResultsByShipperId(int shipperId)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsCalculationResult> GetCalculationResultsByShipperId(int shipperId)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsCalculationResult> GetCalculationResultsByWarehouseDocumentIds(int[] warehouseDocumentIds)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsServiceCalculationResult> GetServiceCalculationResultsByWarehouseDocumentIds(int[] warehouseDocumentIds)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfs> GetRfs()
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public BopsRfs GetRfsById(int rfsId)
        {
            throw new System.NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfs> GetRfsByIds(int[] rfsIds)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsInvoiceDetail> GetInvoiceDetailsByInvoiceId(int invoiceId)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsInvoiceDetail> GetInvoiceDetailsByInvoiceIds(int[] invoiceIds)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsInvoiceDetail> GetInvoiceDetailsFromServiceCalculationResults(int[] ids)
        {
            throw new System.NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsDestination> GetDestinations()
        {
            throw new System.NotImplementedException();
        }

        /// <inheritdoc/>
        public BopsDestination GetDestinationById(int destinationId)
        {
            throw new System.NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsDestination> GetDestinationsByIds(int[] destinationIds)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public BopsRfsCostMethod GetCostMethodById(int costMethodId)
        {
            throw new System.NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsSysUnitOfMeasure> GetUnitsOfMeasure()
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public BopsSysUnitOfMeasure GetUnitOfMeasureById(int unitId)
        {
            throw new System.NotImplementedException();
        }

        /// <inheritdoc/>
        public BopsRfsCostMatrix GetCostMatrixById(int matrixId)
        {
            throw new System.NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsDriver> GetEmployeesByRoleType(EmployeeRoleTypes roleType)
        {
            throw new System.NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsAtsfProduct> GetProducts()
        {
            throw new System.NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsWorkType> GetWorkTypes()
        {
            throw new System.NotImplementedException();
        }

        /// <inheritdoc/>
        public BopsRfsStakeholder GetStakeholderById(int stakeholderId)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsStakeholder> GetStakeholdersByRfsId(int rfsId)
        {
            throw new System.NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsStakeholderRole> GetStakeholderRoles()
        {
            throw new System.NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsServicesOffered> GetServicesOffered()
        {
            throw new System.NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsServicesRequested> GetServicesRequested()
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsServicesRequested> GetServicesRequestedByRfsId(int rfsId)
        {
            throw new System.NotImplementedException();
        }

        public BopsRfsInvoice GetInvoiceById(int invoiceId)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsInvoice> GetInvoicesByIds(int[] invoiceIds)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsInvoice> GetInvoicesByBatchIds(int[] batchIds)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsInvoice> GetInvoicesByDates(DateTime beginDate, DateTime endDate)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsStakeholder> GetStakeholders()
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsServiceCalculationResult> GetServiceCalculationResultsByDatesAndBillingStatus(DateTime beginDate, DateTime endDate,
            RfsBillingStatus billingStatus)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public int GetStorageBillsToInvoice()
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsStorageBillingDetail> GetStorageBillingDetailsByIds(int[] storageBillingDetailIds)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsStorageBillingDetail> GetStorageBillingDetailsByBillingId(int storageBillingId)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public BopsRfsStorageBillingDetail GetStorageBillingDetailById(int storageBillingDetailId)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsStorageBillingDetail> GetStorageBillingDetailsUpToBillingStatus(RfsBillingStatus billingStatus)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsStorageBillingDetail> GetStorageBillingDetailsByBillingIdAndUpToBillingStatus(int billingId, RfsBillingStatus billingStatus)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsStorageBilling> GetStorageBillings()
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public BopsRfsStorageBilling GetStorageBillingById(int storageBillingId)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsStorageBilling> GetStorageBillingsByIDs(int[] storageBillingIds)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsInventoryDetail> GetInventoryDetailsByIDs(int[] inventoryDetailIds)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public BopsProductProfile GetProductProfileById(int productProfileId)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsProductProfile> GetProductProfilesByIDs(int[] productProfileIDs)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsLocation> GetLocations()
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public void AddInvoice(BopsRfsInvoice newInvoice)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public void AddInvoiceDetail(BopsRfsInvoiceDetail newInvoiceDetail)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public void AddStorageBillingEvent(BopsRfsStorageBillingEvent newEvent)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public void AddRfs(BopsRfs newRfs)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public void AddStakeholder(BopsRfsStakeholder newStakeholder)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public void AddServiceRequested(BopsRfsServicesRequested newServiceRequested)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public void AddInvoiceExport(BopsRfsInvoiceExport newInvoiceExport)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public void AddInvoiceTransferBatch(BopsRfsInvoiceXferBatch newInvoiceTransferBatch)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public void AddServiceCalculationResult(BopsRfsServiceCalculationResult newServiceCalculationResult)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public void AddLoadRevenue(BopsLoadRevenue newLoadRevenue)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public void AddWarehouseRevenue(BopsWarehouseRevenue newWarehouseRevenue)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public BopsDestination GetParentDestination(int childDestinationId)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public void RemoveInvoiceAndDetails(int invoiceId)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public void RemoveInvoiceDetails(int invoiceId)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsStorageBillingInput> GetStorageBillingInputData()
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsStorageBillingInventoryTracking> GetStorageBillingInventoryTrackingsByIds(int[] storageBillingInventoryIds)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsStorageRateAssignment> GetStorageRateAssignmentsByProfileIds(int[] profileIds)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsStorageRate> GetStorageRatesByRateIds(int[] rateIds)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsStorageRateEscalation> GetStorageRateEscalationsByRateIds(int[] rateIds)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public BopsRfsStorageBilling GetLastStorageBilling()
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public void RemoveStorageBilling(BopsRfsStorageBilling storageBilling)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public void RemoveStorageBillingDetail(BopsRfsStorageBillingDetail storageBillingDetail)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsServiceCalculationResult> GetServiceCalculationResultsByRfsForBulkInvoice(int rfsNumber)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsScan> GetScansByLoadReferencesTypeSignedAndReject(string[] loadRefs, int docType, bool isSigned, int rejectRef)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsStakeholderClientMapping> GetStakeholderClientMappingsByRfsId(int rfsId)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsStakeholderClientMappingDetail> GetStakeholderClientMappingsByIdAndOriginOrDestinationRole(int mappingId)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsTransitTime> GetTransitTimeByOriginDestinationAndHour(int originId, int destinationId, int hour)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public BopsRfsServicesOffered GetServiceOfferedById(int serviceOfferedId)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsMas90ClientCode> GetMas90ClientCodes()
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsInvoiceTypeData> GetInvoiceTypeData()
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public BopsRfsInvoiceExport GetInvoiceExportById(int exportId)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsInvoiceExportDetail> GetInvoiceExportDetailsByExportId(int exportId)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsInvoiceXferBatch> GetInvoiceTransferBatchesByIds(int[] batchIds)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public BopsRfsInvoiceXferBatch GetInvoiceTransferBatchNotPostedByLocation(string location)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public BopsLoadRevenue GetLoadRevenueByReference(string loadReference)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public void RemoveLoadRevenue(BopsLoadRevenue loadRevenue)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public void RemoveServiceCalculationResult(BopsRfsServiceCalculationResult serviceCalculationResult)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public BopsWarehouseRevenue GetWarehouseRevenueByDocumentTypeAndId(WarehouseDocumentType documentType, int documentId)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public void RemoveWarehouseRevenue(BopsWarehouseRevenue warehouseRevenue)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public void RemoveInvalidRevenueResults()
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsFscFuelPriceHistory> GetFuelPriceHistoryOrderedByBeginDate()
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsFsc> GetFuelSurcharge()
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsFscDetailFloatIndexed> GetFuelSurchargeDetailFloatIndexedByFscIdOrderedByIndexMinimum(int fscId)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsFscDetailOdIndexed> GetFuelSurchargeDetailOdByFscIdIndexedOrderedByMatchMode(int fscId)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public IList<BopsRfsInvoiceXferBatch> GetInvoiceTransferBatchesToPostByDates(DateTime beginDate, DateTime endDate)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public void AddStorageBilling(BopsRfsStorageBilling newStorageBilling)
        {
            throw new NotImplementedException();
        }

        /// <inheritdoc/>
        public void AddStorageBillingDetail(BopsRfsStorageBillingDetail newStorageBillingDetail)
        {
            throw new NotImplementedException();
        }

        public IList<BopsDriverPlanDetail> GetDriverPlanDetailsByLoadReference(string loadReference)
        {
            throw new NotImplementedException();
        }

        public BopsDriverPlan GetDriverPlanById(int planId)
        {
            throw new NotImplementedException();
        }

        public IList<CopsUserDetails> GetCopsUserDetails()
        {
            throw new NotImplementedException();
        }

        public void RemoveCopsUserDetails(string copsUserId)
        {
            throw new NotImplementedException();
        }
    }
}
