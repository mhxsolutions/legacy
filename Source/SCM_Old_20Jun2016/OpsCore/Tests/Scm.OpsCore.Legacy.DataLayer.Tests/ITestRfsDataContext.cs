namespace Scm.OpsCore.Legacy.DataLayer.Tests
{
    /// <summary>
    /// Defines methods for testing the <see cref="IRfsDataContext"/> interface.
    /// </summary>
    /// <remarks>
    /// The purpose is to define an interface of known test methods to make it easier to 
    /// exercise NHibernate, Entity Framework, and any other implementations. Should even
    /// make it possible to compare data returned for byte equivalence.
    /// </remarks>
    public interface ITestRfsDataContext
    {
        void TestGetStatuses(IRfsDataContext context);
        void TestGetBillingStatuses(IRfsDataContext context);
        void TestGetBillingStatusById(IRfsDataContext context);
        void TestGetInvoiceStatuses(IRfsDataContext context);
        void TestGetCalculationResultTypes(IRfsDataContext context);
        void TestGetLoadByReference(IRfsDataContext context);
        void TestGetLoadsByReferences(IRfsDataContext context);
        void TestGetLoadsByDateRange(IRfsDataContext context);
        void TestGetCalculationResultsByLoadReference(IRfsDataContext context);
        void TestGetCalculationResultsByLoadReferences(IRfsDataContext context);
        void TestGetServiceCalculationResultsByLoadReferences(IRfsDataContext context);
        void TestGetServiceCalculationResultsByIds(IRfsDataContext context);
        void TestGetServiceCalculationResultsByLoadReference(IRfsDataContext context);
        void TestGetServiceCalculationResultById(IRfsDataContext context);
        void TestGetReceiverById(IRfsDataContext context);
        void TestGetReceiversByIDs(IRfsDataContext context);
        void TestGetReceiversByDateReceivedRange(IRfsDataContext context);
        void TestGetShipperById(IRfsDataContext context);
        void TestGetShippersByIDs(IRfsDataContext context);
        void TestGetShippersByShipmentDateRange(IRfsDataContext context);
        void TestGetCalculationResultsByReceiverId(IRfsDataContext context);
        void TestGetServiceCalculationResultsByReceiverId(IRfsDataContext context);
        void TestGetServiceCalculationResultsByShipperId(IRfsDataContext context);
        void TestGetCalculationResultsByShipperId(IRfsDataContext context);
        void TestGetCalculationResultsByWarehouseDocumentIds(IRfsDataContext context);
        void TestGetServiceCalculationResultsByWarehouseDocumentIds(IRfsDataContext context);
        void TestGetRfs(IRfsDataContext context);
        void TestGetRfsById(IRfsDataContext context);
        void TestGetRfsByIds(IRfsDataContext context);
        void TestGetInvoiceDetailsByInvoiceId(IRfsDataContext context);
        void TestGetInvoiceDetailsByInvoiceIds(IRfsDataContext context);
        void TestGetInvoiceDetailsFromServiceCalculationResults(IRfsDataContext context);
        void TestGetDestinations(IRfsDataContext context);
        void TestGetDestinationById(IRfsDataContext context);
        void TestGetDestinationsByIds(IRfsDataContext context);
        void TestGetCostMethodById(IRfsDataContext context);
        void TestGetUnitsOfMeasure(IRfsDataContext context);
        void TestGetUnitOfMeasureById(IRfsDataContext context);
        void TestGetCostMatrixById(IRfsDataContext context);
        void TestGetEmployeesByRoleType(IRfsDataContext context);
        void TestGetProducts(IRfsDataContext context);
        void TestGetWorkTypes(IRfsDataContext context);
        void TestGetStakeholderById(IRfsDataContext context);
        void TestGetStakeholdersByRfsId(IRfsDataContext context);
        void TestGetStakeholderRoles(IRfsDataContext context);
        void TestGetServicesOffered(IRfsDataContext context);
        void TestGetServicesRequested(IRfsDataContext context);
        void TestGetServicesRequestedByRfsId(IRfsDataContext context);
        void TestGetInvoiceById(IRfsDataContext context);
        void TestGetInvoicesByIds(IRfsDataContext context);
        void TestGetInvoicesByBatchIds(IRfsDataContext context);
        void TestGetInvoicesByDates(IRfsDataContext context);
        void TestGetStakeholders(IRfsDataContext context);
        void TestGetServiceCalculationResultsByDatesAndBillingStatus(IRfsDataContext context);
        void TestGetStorageBillsToInvoice(IRfsDataContext context);
        void TestGetStorageBillingDetailsByIds(IRfsDataContext context);
        void TestGetStorageBillingDetailsByBillingId(IRfsDataContext context);
        void TestGetStorageBillingDetailById(IRfsDataContext context);
        void TestGetStorageBillingDetailsUpToBillingStatus(IRfsDataContext context);
        void TestGetStorageBillingDetailsByBillingIdAndUpToBillingStatus(IRfsDataContext context);
        void TestGetStorageBillings(IRfsDataContext context);
        void TestGetStorageBillingById(IRfsDataContext context);
        void TestGetStorageBillingsByIDs(IRfsDataContext context);
        void TestGetInventoryDetailsByIDs(IRfsDataContext context);
        void TestGetProductProfileById(IRfsDataContext context);
        void TestGetProductProfilesByIDs(IRfsDataContext context);
        void TestGetLocations(IRfsDataContext context);
    }
}
