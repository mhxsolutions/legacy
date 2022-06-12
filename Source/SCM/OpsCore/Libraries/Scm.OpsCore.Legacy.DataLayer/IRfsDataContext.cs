using System;
using System.Collections.Generic;
using BopsDataAccess;

namespace Scm.OpsCore.Legacy.DataLayer
{
    /// <summary>
    /// Defines methods for interacting with data used by the Request For Service (RFS) system.
    /// </summary>
    public interface IRfsDataContext
    {
        /// <summary>
        /// Saves all pending changes in the context.
        /// </summary>
        /// <remarks>
        /// Can throw exceptions in case of failure, specific to the underlying ORM technology.
        /// </remarks>
        /// <returns>The number of changes made.</returns>
        int SaveChanges();

        /// <summary>
        /// Gets all RFS statuses.
        /// </summary>
        /// <returns>A list of the RFS statuses if successful, null otherwise.</returns>
        IList<BopsRfsStatus> GetStatuses();
        
        /// <summary>
        /// Gets all billing statuses.
        /// </summary>
        /// <returns>A list of the billing statuses if successful, null otherwise.</returns>
        IList<BopsRfsBillingStatus> GetBillingStatuses();
        
        /// <summary>
        /// Gets a billing status by its ID.
        /// </summary>
        /// <param name="id">The billing status ID.</param>
        /// <returns>A billing status if successful, null otherwise.</returns>
        BopsRfsBillingStatus GetBillingStatusById(int id);
        
        /// <summary>
        /// Gets all invoice statuses.
        /// </summary>
        /// <returns>A list of the invoice statuses if successful, null otherwise.</returns>
        IList<BopsRfsInvoiceStatus> GetInvoiceStatuses();
        
        /// <summary>
        /// Gets all calculation result types.
        /// </summary>
        /// <returns>A list of the calculation result types if successful, null otherwise.</returns>
        IList<BopsRfsCalculationResultType> GetCalculationResultTypes();
        
        /// <summary>
        /// Gets the load by its reference.
        /// </summary>
        /// /// <param name="loadReference">The load reference.</param>
        /// <returns>The load if successful, null otherwise.</returns>
        BopsLoad GetLoadByReference(string loadReference);
        
        /// <summary>
        /// Gets a list of loads by their references.
        /// </summary>
        /// /// <param name="loadReferences">An array of load references.</param>
        /// <returns>A list of loads if successful, null otherwise.</returns>
        IList<BopsLoad> GetLoadsByReferences(string[] loadReferences);
        
        /// <summary>
        /// Gets a list of loads within a load date range.
        /// </summary>
        /// <param name="beginDate">The begin date.</param>
        /// <param name="endDate">The end date.</param>
        /// <remarks>
        /// In the process of creating the data layer it was discovered that the underlying
        /// NHibernate implementation deviates from the usual convention. To wit, the usual
        /// convention for all software has been to specify date ranges as follows:
        /// 
        ///     beginDate &lt;= x &lt; endDate
        /// 
        /// In other words, all other use has been intended to select items greater than or 
        /// equal to the begin date but less than the end date. However, the underlying 
        /// NHibernate implementation of the 'between' expression turns out to be inclusive
        /// of both end points:
        /// 
        ///     beginDate &lt;= x &lt;= endDate
        /// 
        /// I've left it working this way and written the tests to correspond to avoid
        /// disturbing existing practice. Perhaps in the future this can be fixed. It will
        /// certainly become an issue when crafting the Entity Framework implementation.
        /// </remarks>
        /// <returns>A IList&lt;BopsLoad&gt; if successful, empty list otherwise.</returns>
        IList<BopsLoad> GetLoadsByLoadDateRange(DateTime beginDate, DateTime endDate);
        
        /// <summary>
        /// Gets calculation results by load reference.
        /// </summary>
        /// ///
        /// <param name="loadReference">The load reference.</param>
        /// <returns>A list of the calculation results if successful, null otherwise.</returns>
        IList<BopsRfsCalculationResult> GetCalculationResultsByLoadReference(string loadReference);
        
        /// <summary>
        /// Gets calculation results by load references.
        /// </summary>
        /// <param name="loadReferences">The load references.</param>
        /// <returns>A list of the calculation results if successful, null otherwise.</returns>
        IList<BopsRfsCalculationResult> GetCalculationResultsByLoadReferences(string[] loadReferences);
        
        /// <summary>
        /// Gets service calculation results by load references.
        /// </summary>
        /// <param name="loadReferences">The load references.</param>
        /// <returns>A list of the service calculation results if successful, null otherwise.</returns>
        IList<BopsRfsServiceCalculationResult> GetServiceCalculationResultsByLoadReferences(string[] loadReferences);
        
        /// <summary>
        /// Gets service calculation results by IDs.
        /// </summary>
        /// <param name="resultIds">The service calculation result IDs.</param>
        /// <returns>A list of the service calculation results if successful, empty list otherwise.</returns>
        IList<BopsRfsServiceCalculationResult> GetServiceCalculationResultsByIds(int[] resultIds);
        
        /// <summary>
        /// Gets service calculation results by load reference.
        /// </summary>
        /// /// <param name="loadReference">The load reference.</param>
        /// <returns>A list of the service calculation results if successful, null otherwise.</returns>
        IList<BopsRfsServiceCalculationResult> GetServiceCalculationResultsByLoadReference(string loadReference);
        
        /// <summary>
        /// Gets service calculation result by ID.
        /// </summary>
        /// <param name="serviceCalculationResultId">The service calculation result ID.</param>
        /// <returns>The service calculation result if successful, null otherwise.</returns>
        BopsRfsServiceCalculationResult GetServiceCalculationResultById(int serviceCalculationResultId);
        
        /// <summary>
        /// Gets the receiver by its ID.
        /// </summary>
        /// <param name="receiverId">The receiver ID.</param>
        /// <returns>The receiver if successful, null otherwise.</returns>
        BopsReceivingRecord GetReceiverById(int receiverId);
        
        /// <summary>
        /// Gets a list of receivers by their IDs.
        /// </summary>
        /// <param name="receiverIds">An array of receiver IDs.</param>
        /// <returns>A list of receivers if successful, null otherwise.</returns>
        IList<BopsReceivingRecord> GetReceiversByIDs(int[] receiverIds);
        
        /// <summary>
        /// Gets the receivers by date received range.
        /// </summary>
        /// <param name="beginDate">The begin date.</param>
        /// <param name="endDate">The end date.</param>
        /// <returns>A IList&lt;BopsReceivingRecord&gt; of receivers if successful, empty list otherwise.</returns>
        IList<BopsReceivingRecord> GetReceiversByDateReceivedRange(DateTime beginDate, DateTime endDate);
        
        /// <summary>
        /// Gets the shipper by its ID.
        /// </summary>
        /// <param name="shipperId">The shipper ID.</param>
        /// <returns>The shipper if successful, null otherwise.</returns>
        BopsShippingRecord GetShipperById(int shipperId);
        
        /// <summary>
        /// Gets a list of shippers by their IDs.
        /// </summary>
        /// /// <param name="shipperIds">An array of shipper IDs.</param>
        /// <returns>A list of shippers if successful, null otherwise.</returns>
        IList<BopsShippingRecord> GetShippersByIDs(int[] shipperIds);
        
        /// <summary>
        /// Gets the shippers by shipment date range.
        /// </summary>
        /// <param name="beginDate">The begin date.</param>
        /// <param name="endDate">The end date.</param>
        /// <returns>A IList&lt;BopsShippingRecord&gt; of shippers if successful, empty list otherwise.</returns>
        IList<BopsShippingRecord> GetShippersByShipmentDateRange(DateTime beginDate, DateTime endDate);
        
        /// <summary>
        /// Gets calculation results by receiver ID.
        /// </summary>
        /// <param name="receiverId">The receiver ID.</param>
        /// <returns>A list of the calculation results if successful, null otherwise.</returns>
        IList<BopsRfsCalculationResult> GetCalculationResultsByReceiverId(int receiverId);
        
        /// <summary>
        /// Gets service calculation results by receiver ID.
        /// </summary>
        /// <param name="receiverId">The receiver ID.</param>
        /// <returns>A list of service calculation results if successful, null otherwise.</returns>
        IList<BopsRfsServiceCalculationResult> GetServiceCalculationResultsByReceiverId(int receiverId);
        
        /// <summary>
        /// Gets service calculation results by shipper ID.
        /// </summary>
        /// <param name="shipperId">The shipper ID.</param>
        /// <returns>A list of service calculation results if successful, null otherwise.</returns>
        IList<BopsRfsServiceCalculationResult> GetServiceCalculationResultsByShipperId(int shipperId);
        
        /// <summary>
        /// Gets calculation results by shipper ID.
        /// </summary>
        /// <param name="shipperId">The shipper ID.</param>
        /// <returns>A list of the calculation results if successful, null otherwise.</returns>
        IList<BopsRfsCalculationResult> GetCalculationResultsByShipperId(int shipperId);
        
        /// <summary>
        /// Gets the calculation results by warehouse document IDs.
        /// </summary>
        /// <param name="warehouseDocumentIds">The warehouse document ids.</param>
        /// <returns>A IList&lt;BopsRfsCalculationResult&gt; of the calculation results if successful, an empty list otherwise.</returns>
        IList<BopsRfsCalculationResult> GetCalculationResultsByWarehouseDocumentIds(int[] warehouseDocumentIds, WarehouseDocumentType documentType);
        
        /// <summary>
        /// Gets the service calculation results by warehouse document IDs.
        /// </summary>
        /// <param name="warehouseDocumentIds">The warehouse document ids.</param>
        /// <returns>A IList&lt;BopsRfsServiceCalculationResult&gt; of the calculation results if successful, an empty list otherwise.</returns>
        IList<BopsRfsServiceCalculationResult> GetServiceCalculationResultsByWarehouseDocumentIds(int[] warehouseDocumentIds, WarehouseDocumentType documentType);
        
        /// <summary>
        /// Gets all RFS.
        /// </summary>
        /// <param name="companyId">The ID of the company by which to filter (zero if none).</param>
        /// <param name="maxRows">The maximum number of rows to retrieve (zero if all).</param>
        /// <param name="skipRows">The number of rows to skip.</param>
        /// <returns>A list of RFS if successful, null otherwise.</returns>
        IList<BopsRfs> GetRfs(int companyId, int maxRows, int skipRows);
        
        /// <summary>
        /// Gets request for service (RFS) by ID.
        /// </summary>
        /// <param name="rfsId">The RFS ID.</param>
        /// <returns>The RFS if successful, null otherwise.</returns>
        BopsRfs GetRfsById(int rfsId);
        
        /// <summary>
        /// Gets RFS by IDs.
        /// </summary>
        /// <param name="rfsIds">The RFS IDs.</param>
        /// <returns>A list of the RFS if successfull, an empty list otherwise.</returns>
        IList<BopsRfs> GetRfsByIds(int[] rfsIds);
        
        /// <summary>
        /// Gets invoice details by invoice ID.
        /// </summary>
        /// <param name="invoiceId">The invoice ID.</param>
        /// <returns>A list of invoice details if successful, null otherwise.</returns>
        IList<BopsRfsInvoiceDetail> GetInvoiceDetailsByInvoiceId(int invoiceId);
        
        /// <summary>
        /// Gets the invoice details by invoice IDs.
        /// </summary>
        /// <param name="invoiceIds">The invoice IDs.</param>
        /// <returns>A list of invoice details if successful, an empty list otherwise.</returns>
        IList<BopsRfsInvoiceDetail> GetInvoiceDetailsByInvoiceIds(int[] invoiceIds);
        
        /// <summary>
        /// Gets invoice details from service calculation result IDs.
        /// </summary>
        /// <param name="ids">The RFS service calculation result IDs.</param>
        /// <returns>A list of invoice details if successful, null otherwise.</returns>
        IList<BopsRfsInvoiceDetail> GetInvoiceDetailsFromServiceCalculationResults(int[] ids);

        /// <summary>
        /// Gets all destinations.
        /// </summary>
        /// <param name="companyId">The ID of the company by which to filter (zero if none).</param>
        /// <param name="maxRows">The maximum number of rows to retrieve (zero if all).</param>
        /// <param name="skipRows">The number of rows to skip.</param>
        /// <returns>A list of destinations if successful, null otherwise.</returns>
        IList<BopsDestination> GetDestinations(int companyId, int maxRows, int skipRows);
        
        /// <summary>
        /// Gets destination by its ID.
        /// </summary>
        /// <param name="destinationId">The destination ID.</param>
        /// <returns>The destination if successful, null otherwise.</returns>
        BopsDestination GetDestinationById(int destinationId);
        
        /// <summary>
        /// Gets a list of destinations by their IDs.
        /// </summary>
        /// <param name="destinationIds">The destination IDs.</param>
        /// <returns>A list of destinations if successful, null otherwise.</returns>
        IList<BopsDestination> GetDestinationsByIds(int[] destinationIds);
        
        /// <summary>
        /// Gets a cost method by its ID.
        /// </summary>
        /// <param name="costMethodId">The cost method ID.</param>
        /// <returns>The cost method if successful, null otherwise.</returns>
        BopsRfsCostMethod GetCostMethodById(int costMethodId);
        
        /// <summary>
        /// Gets all units of measure.
        /// </summary>
        /// <returns>A list of units of measure if successful, null otherwise.</returns>
        IList<BopsSysUnitOfMeasure> GetUnitsOfMeasure();
        
        /// <summary>
        /// Gets a unit of measure by its ID.
        /// </summary>
        /// <param name="unitId">The unit ID.</param>
        /// <returns>The unit of measure if successful, null otherwise.</returns>
        BopsSysUnitOfMeasure GetUnitOfMeasureById(int unitId);
        
        /// <summary>
        /// Gets an RFS cost matrix by its ID.
        /// </summary>
        /// <param name="matrixId">The cost matrix ID.</param>
        /// <returns>The RFS cost matrix if successful, null otherwise.</returns>
        BopsRfsCostMatrix GetCostMatrixById(int matrixId);
        
        /// <summary>
        /// Gets employees by role type.
        /// </summary>
        /// <param name="roleType">The role type.</param>
        /// <returns>A list of employees if successful, null otherwise.</returns>
        IList<BopsDriver> GetEmployeesByRoleType(EmployeeRoleTypes roleType);
        
        /// <summary>
        /// Gets all products.
        /// </summary>
        /// <returns>A list of products if successful, null otherwise.</returns>
        IList<BopsAtsfProduct> GetProducts();
        
        /// <summary>
        /// Gets all work types.
        /// </summary>
        /// <returns>A list of work types if successful, null otherwise.</returns>
        IList<BopsRfsWorkType> GetWorkTypes();
        
        /// <summary>
        /// Gets the stakeholder by identifier.
        /// </summary>
        /// <param name="stakeholderId">The stakeholder identifier.</param>
        /// <returns>The stakeholder if successful, null otherwise.</returns>
        BopsRfsStakeholder GetStakeholderById(int stakeholderId);
        
        /// <summary>
        /// Gets the stakeholders for an RFS ID.
        /// </summary>
        /// <param name="rfsId">The RFS ID.</param>
        /// <returns>A list of stakeholders if successful, null otherwise.</returns>
        IList<BopsRfsStakeholder> GetStakeholdersByRfsId(int rfsId);
        
        /// <summary>
        /// Gets all RFS stakeholder roles.
        /// </summary>
        /// <returns>A list of the stakeholder roles if successful, null otherwise.</returns>
        IList<BopsRfsStakeholderRole> GetStakeholderRoles();
        
        /// <summary>
        /// Gets all RFS services offered.
        /// </summary>
        /// <param name="companyId">The ID of the company by which to filter (zero if none).</param>
        /// <returns>A list of the services offered if successful, null otherwise.</returns>
        IList<BopsRfsServicesOffered> GetServicesOffered(int companyId);
        
        /// <summary>
        /// Gets all RFS services requested.
        /// </summary>
        /// <param name="companyId">The ID of the company by which to filter (zero if none).</param>
        /// <param name="maxRows">The maximum number of rows to retrieve (zero if all).</param>
        /// <param name="skipRows">The number of rows to skip.</param>
        /// <returns>A list of the services requested if successful, null otherwise.</returns>
        IList<BopsRfsServicesRequested> GetServicesRequested(int companyId, int maxRows, int skipRows);
        
        /// <summary>
        /// Gets the services requested for an RFS ID.
        /// </summary>
        /// <param name="rfsId">The RFS ID.</param>
        /// <returns>A list of the services requested if successful, null otherwise.</returns>
        IList<BopsRfsServicesRequested> GetServicesRequestedByRfsId(int rfsId);
        
        /// <summary>
        /// Gets an invoice by its unique ID.
        /// </summary>
        /// <param name="invoiceId">The invoice ID.</param>
        /// <returns>The invoice if successful, null otherwise.</returns>
        BopsRfsInvoice GetInvoiceById(int invoiceId);
        
        /// <summary>
        /// Gets a list of invoices by their IDs.
        /// </summary>
        /// <param name="invoiceIds">The invoice IDs.</param>
        /// <returns>A list of invoices if successful, null otherwise.</returns>
        IList<BopsRfsInvoice> GetInvoicesByIds(int[] invoiceIds);
        
        /// <summary>
        /// Gets the invoices by batch IDs.
        /// </summary>
        /// <param name="batchIds">The batch IDs.</param>
        /// <returns>A list of the invoices if successful, null otherwise.</returns>
        IList<BopsRfsInvoice> GetInvoicesByBatchIds(int[] batchIds);
        
        /// <summary>
        /// Gets invoices by dates.
        /// </summary>
        /// <param name="beginDate">The begin date.</param>
        /// <param name="endDate">The end date.</param>
        /// <param name="companyId">The ID of the company by which to filter (zero if none).</param>
        /// <returns>A list of invoices if successful, null otherwise.</returns>
        IList<BopsRfsInvoice> GetInvoicesByDates(DateTime beginDate, DateTime endDate, int companyId);

        /// <summary>
        /// Gets all RFS stakeholders.
        /// </summary>
        /// <param name="companyId">The ID of the company by which to filter (zero if none).</param>
        /// <param name="maxRows">The maximum number of rows to retrieve (zero if all).</param>
        /// <param name="skipRows">The number of rows to skip.</param>
        /// <returns>A list of stakeholders if successful, null otherwise.</returns>
        IList<BopsRfsStakeholder> GetStakeholders(int companyId, int maxRows, int skipRows);

        /// <summary>
        /// Gets a list of RFS service calculation results within a specified data range and billing status.
        /// </summary>
        /// <param name="beginDate">The beginning date for the range (inclusive).</param>
        /// <param name="endDate">The ending date for the range (exclusive).</param>
        /// <param name="billingStatus">The billing status to match (if any).</param>
        /// <param name="companyId">The ID of the company by which to filter (zero if none).</param>
        /// <returns>A list of RFS service calculation results if successful, null otherwise.</returns>
        IList<BopsRfsServiceCalculationResult> GetServiceCalculationResultsByDatesAndBillingStatus(DateTime beginDate, DateTime endDate, RfsBillingStatus billingStatus, int companyId);
        
        /// <summary>
        /// Gets a count of the storage bills to invoice.
        /// </summary>
        /// <returns>The count of storage bills to invoice.</returns>
        int GetStorageBillsToInvoice();

        IList<BopsRfsStorageBillingDetail> GetStorageBillingDetailsByIds(int[] storageBillingDetailIds);

        IList<BopsRfsStorageBillingDetail> GetStorageBillingDetailsByBillingId(int storageBillingId);

        BopsRfsStorageBillingDetail GetStorageBillingDetailById(int storageBillingDetailId);

        IList<BopsRfsStorageBillingDetail> GetStorageBillingDetailsUpToBillingStatus(RfsBillingStatus billingStatus);

        IList<BopsRfsStorageBillingDetail> GetStorageBillingDetailsByBillingIdAndUpToBillingStatus(int billingId, RfsBillingStatus billingStatus);

        IList<BopsRfsStorageBilling> GetStorageBillings();

        BopsRfsStorageBilling GetStorageBillingById(int storageBillingId);

        IList<BopsRfsStorageBilling> GetStorageBillingsByIDs(int[] storageBillingIds);

        IList<BopsInventoryDetail> GetInventoryDetailsByIDs(int[] inventoryDetailIds);

        BopsProductProfile GetProductProfileById(int productProfileId);

        IList<BopsProductProfile> GetProductProfilesByIDs(int[] productProfileIDs);

        IList<BopsRfsLocation> GetLocations(int companyId);

        void AddInvoice(BopsRfsInvoice newInvoice);

        void AddInvoiceDetail(BopsRfsInvoiceDetail newInvoiceDetail);

        void AddStorageBillingEvent(BopsRfsStorageBillingEvent newEvent);

        void AddRfs(BopsRfs newRfs);

        void AddStakeholder(BopsRfsStakeholder newStakeholder);

        void AddServiceRequested(BopsRfsServicesRequested newServiceRequested);

        void AddInvoiceExport(BopsRfsInvoiceExport newInvoiceExport);

        void AddInvoiceExportDetail(BopsRfsInvoiceExportDetail newInvoiceExportDetail);

        void AddInvoiceTransferBatch(BopsRfsInvoiceXferBatch newInvoiceTransferBatch);

        void AddCalculationResult(BopsRfsCalculationResult newCalculationResult);

        void AddServiceCalculationResult(BopsRfsServiceCalculationResult newServiceCalculationResult);

        void AddLoadRevenue(BopsLoadRevenue newLoadRevenue);

        void AddWarehouseRevenue(BopsWarehouseRevenue newWarehouseRevenue);

        BopsDestination GetParentDestination(int childDestinationId);

        void RemoveInvoiceAndDetails(int invoiceId);

        void RemoveInvoiceDetails(int invoiceId);


        /// <summary>
        /// Gets the storage billing input data.
        /// </summary>
        /// <returns>A list of the storage billing input data if successful, an empty list otherwise.</returns>
        IList<BopsRfsStorageBillingInput> GetStorageBillingInputData();

        IList<BopsRfsStorageBillingInventoryTracking> GetStorageBillingInventoryTrackingsByIds(int[] storageBillingInventoryIds);

        IList<BopsRfsStorageRateAssignment> GetStorageRateAssignmentsByProfileIds(int[] profileIds);

        IList<BopsRfsStorageRate> GetStorageRatesByRateIds(int[] rateIds);

        IList<BopsRfsStorageRateEscalation> GetStorageRateEscalationsByRateIds(int[] rateIds);

        BopsRfsStorageBilling GetLastStorageBilling();

        void RemoveStorageBilling(BopsRfsStorageBilling storageBilling);

        void RemoveStorageBillingDetail(BopsRfsStorageBillingDetail storageBillingDetail);

        IList<BopsRfsServiceCalculationResult> GetServiceCalculationResultsByRfsForBulkInvoice(int rfsNumber);

        IList<BopsScan> GetScansByDocumentIdsSignedAndReject(string[] loadRefs, bool isSigned, int rejectRef);

        IList<BopsScan> GetInvoiceSupportingDocuments(int invoiceId);
        
        IList<BopsRfsStakeholderClientMapping> GetStakeholderClientMappingsByRfsId(int rfsId);

        IList<BopsRfsStakeholderClientMappingDetail> GetStakeholderClientMappingsByIdAndOriginOrDestinationRole(int mappingId);

        IList<BopsTransitTime> GetTransitTimeByOriginDestinationAndHour(int originId, int destinationId, int hour);

        BopsRfsServicesOffered GetServiceOfferedById(int serviceOfferedId);

        IList<BopsRfsServicesOffered> GetServicesOfferedByIds(int[] serviceOfferedIds);

        BopsRfsServicesOffered GetServiceOfferedByServiceRequestedId(int serviceRequestedId);

        IList<BopsMas90ClientCode> GetMas90ClientCodes();

        IList<BopsRfsInvoiceTypeData> GetInvoiceTypeData();

        BopsRfsInvoiceExport GetInvoiceExportById(int exportId);

        IList<BopsRfsInvoiceExportDetail> GetInvoiceExportDetailsByExportId(int exportId);

        IList<BopsRfsInvoiceXferBatch> GetInvoiceTransferBatchesByIds(int[] batchIds);

        BopsRfsInvoiceXferBatch GetInvoiceTransferBatchNotPostedByLocation(string location);

        BopsLoadRevenue GetLoadRevenueByReference(string loadReference);

        void RemoveLoadRevenue(BopsLoadRevenue loadRevenue);

        void RemoveServiceCalculationResult(BopsRfsServiceCalculationResult serviceCalculationResult);

        BopsWarehouseRevenue GetWarehouseRevenueByDocumentTypeAndId(WarehouseDocumentType documentType, int documentId);

        void RemoveWarehouseRevenue(BopsWarehouseRevenue warehouseRevenue);

        void RemoveInvalidRevenueResults();

        IList<BopsFscFuelPriceHistory> GetFuelPriceHistoryOrderedByBeginDate();

        IList<BopsFsc> GetFuelSurcharge();

        BopsFsc GetFuelSurchargeById(int fscId);

        IList<BopsFscDetailFloatIndexed> GetFuelSurchargeDetailFloatIndexedByFscIdOrderedByIndexMinimum(int fscId);

        IList<BopsFscDetailOdIndexed> GetFuelSurchargeDetailOdByFscIdIndexedOrderedByMatchMode(int fscId);

        IList<BopsRfsInvoiceXferBatch> GetInvoiceTransferBatchesToPostByDates(DateTime beginDate, DateTime endDate);

        void AddStorageBilling(BopsRfsStorageBilling newStorageBilling);

        void AddStorageBillingDetail(BopsRfsStorageBillingDetail newStorageBillingDetail);

        IList<BopsDriverPlanDetail> GetDriverPlanDetailsByLoadReference(string loadReference);

        BopsDriverPlan GetDriverPlanById(int planId);

        IList<BopsCompany> GetCompanies();

        IList<BopsCompanyUser> GetCompanyUsers();

        IList<BopsCompanyUserPermission> GetCompanyUserPermissions();

        void UpdateStorageBillingInventoryTracking(int inventoryId, DateTime newDateBilledThrough);


        // TODO: Move these to a Cops specific (or at least other, non-RFS) context

        IList<CopsUserDetails> GetCopsUserDetails(); 
        void RemoveCopsUserDetails(string copsUserId);

        IList<BopsRfsInvoiceReportDetail> GetInvoiceDetail(int invoiceId);
    }
}
