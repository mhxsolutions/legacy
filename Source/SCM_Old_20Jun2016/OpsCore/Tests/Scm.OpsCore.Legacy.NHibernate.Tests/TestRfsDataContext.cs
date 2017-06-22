using NUnit.Framework;
using Scm.OpsCore.Legacy.DataLayer;
using Scm.OpsCore.Legacy.DataLayer.Tests;

namespace Scm.OpsCore.Legacy.NHibernate.Tests
{
    /// <summary>
    /// Tests the NHibernate implementation of the RFS data context.
    /// </summary>
    [TestFixture]
    public class TestRfsDataContext
    {
        private IRfsDataContext _context;
        private ITestRfsDataContext _tester;

        /// <summary>
        /// NUnit setup method run individually to get a fresh tester for each test.
        /// </summary>
        [SetUp]
        public void SetUp()
        {
            _context = new RfsDataContext();
            _tester = new DataLayer.Tests.TestRfsDataContext();
        }

        [TearDown]
        public void TearDown()
        {
            // TODO: free the context
            _context = null;
        }

        /// <summary>
        /// Ensures RFS statuses may be retrieved.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetStatuses()
        {
            _tester.TestGetStatuses(_context);
        }

        /// <summary>
        /// Ensures RFS billing statuses may be retrieved.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetBillingStatuses()
        {
            _tester.TestGetBillingStatuses(_context);
        }

        /// <summary>
        /// Ensures RFS billing statuses may be retrieved by ID.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetBillingStatusById()
        {
            _tester.TestGetBillingStatusById(_context);
        }

        /// <summary>
        /// Ensures invoice statuses may be retrieved.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetInvoiceStatuses()
        {
            _tester.TestGetInvoiceStatuses(_context);
        }

        /// <summary>
        /// Ensures calculation result types may be retrieved.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetCalculationResultTypes()
        {
            _tester.TestGetCalculationResultTypes(_context);
        }

        /// <summary>
        /// Ensures load may be retrieved by reference.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetLoadByReference()
        {
            _tester.TestGetLoadByReference(_context);
        }

        /// <summary>
        /// Ensures loads may be retrieved by references.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetLoadsByReferences()
        {
            _tester.TestGetLoadsByReferences(_context);
        }

        /// <summary>
        /// Ensures loads may be retrieved by load date range.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetLoadsByDateRange()
        {
            _tester.TestGetLoadsByDateRange(_context);
        }

        /// <summary>
        /// Ensures calculation results may be retrieved by load reference.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetCalculationResultsByLoadReference()
        {
            _tester.TestGetCalculationResultsByLoadReference(_context);
        }

        /// <summary>
        /// Ensures calculation results may be retrieved by load references.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetCalculationResultsByLoadReferences()
        {
            _tester.TestGetCalculationResultsByLoadReferences(_context);
        }

        /// <summary>
        /// Ensures service calculation results may be retrieved by load references.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetServiceCalculationResultsByLoadReferences()
        {
            _tester.TestGetServiceCalculationResultsByLoadReferences(_context);
        }

        /// <summary>
        /// Ensures service calculation results may be retrieved by IDs.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetServiceCalculationResultsByIds()
        {
            _tester.TestGetServiceCalculationResultsByIds(_context);
        }

        /// <summary>
        /// Ensures service calculation results may be retrieved by load reference..
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetServiceCalculationResultsByLoadReference()
        {
            _tester.TestGetServiceCalculationResultsByLoadReference(_context);
        }

        /// <summary>
        /// Ensures service calculation result may be retrieved by ID.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetServiceCalculationResultById()
        {
            _tester.TestGetServiceCalculationResultById(_context);
        }

        /// <summary>
        /// Ensures receiver may be retrieved by ID.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetReceiverById()
        {
            _tester.TestGetReceiverById(_context);
        }

        /// <summary>
        /// Ensures receivers may be retrieved by IDs.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetReceiversByIDs()
        {
            _tester.TestGetReceiversByIDs(_context);
        }

        /// <summary>
        /// Ensures receivers may be retrieved by received date range.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetReceiversByDateReceivedRange()
        {
            _tester.TestGetReceiversByDateReceivedRange(_context);
        }

        /// <summary>
        /// Ensures shipper may be retrieved by ID.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetShipperById()
        {
            _tester.TestGetShipperById(_context);
        }

        /// <summary>
        /// Ensures shippers may be retrieved by IDs.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetShippersByIDs()
        {
            _tester.TestGetShippersByIDs(_context);
        }

        /// <summary>
        /// Ensures shippers may be retrieved by shipment date range.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetShippersByShipmentDateRange()
        {
            _tester.TestGetShippersByShipmentDateRange(_context);
        }

        /// <summary>
        /// Ensures calculation results may be retrieved by receiver ID.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetCalculationResultsByReceiverId()
        {
            _tester.TestGetCalculationResultsByReceiverId(_context);
        }

        /// <summary>
        /// Ensures service calculation results may be retrieved by receiver ID.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetServiceCalculationResultsByReceiverId()
        {
            _tester.TestGetServiceCalculationResultsByReceiverId(_context);
        }

        /// <summary>
        /// Ensures service calculation results may be retrieved by shipper ID.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetServiceCalculationResultsByShipperId()
        {
            _tester.TestGetServiceCalculationResultsByShipperId(_context);
        }

        /// <summary>
        /// Ensures calculation results may be retrieved by shipper ID.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void GetCalculationResultsByShipperId()
        {
            _tester.TestGetCalculationResultsByShipperId(_context);
        }

        /// <summary>
        /// Ensures calculation results may be retrieved by warehouse document IDs.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetCalculationResultsByWarehouseDocumentIds()
        {
            _tester.TestGetCalculationResultsByWarehouseDocumentIds(_context);
        }

        /// <summary>
        /// Ensures service calculation results may be retrieved by warehouse document IDs.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetServiceCalculationResultsByWarehouseDocumentIds()
        {
            _tester.TestGetServiceCalculationResultsByWarehouseDocumentIds(_context);
        }

        /// <summary>
        /// Ensures RFS may be retrieved.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetRfs()
        {
            _tester.TestGetRfs(_context);
        }

        /// <summary>
        /// Ensures RFS may be retrieved by ID.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetRfsById()
        {
            _tester.TestGetRfsById(_context);
        }

        /// <summary>
        /// Ensures RFS may be retrieved by IDs.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetRfsByIds()
        {
            _tester.TestGetRfsByIds(_context);
        }

        /// <summary>
        /// Ensures invoice details may be retrieved by invoice ID.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetInvoiceDetailsByInvoiceId()
        {
            _tester.TestGetInvoiceDetailsByInvoiceId(_context);
        }

        /// <summary>
        /// Ensures invoice details may be retrieved by invoice IDs.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetInvoiceDetailsByInvoiceIds()
        {
            _tester.TestGetInvoiceDetailsByInvoiceIds(_context);
        }

        /// <summary>
        /// Ensures invoice details may be retrieved by service calculation results.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetInvoiceDetailsFromServiceCalculationResults()
        {
            _tester.TestGetInvoiceDetailsFromServiceCalculationResults(_context);
        }

        /// <summary>
        /// Ensures destinations may be retrieved.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetDestinations()
        {
            _tester.TestGetDestinations(_context);
        }

        /// <summary>
        /// Ensures destination may be retrieved by ID.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetDestinationById()
        {
            _tester.TestGetDestinationById(_context);
        }

        /// <summary>
        /// Ensures destinations may be retrieved by IDs.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetDestinationsByIds()
        {
            _tester.TestGetDestinationsByIds(_context);
        }

        /// <summary>
        /// Ensures cost method may be retrieved by IDs.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetCostMethodById()
        {
            _tester.TestGetCostMethodById(_context);
        }

        /// <summary>
        /// Ensures units of measure may be retrieved.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetUnitsOfMeasure()
        {
            _tester.TestGetUnitsOfMeasure(_context);
        }

        /// <summary>
        /// Ensures unit of measure may be retrieved by ID.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetUnitOfMeasureById()
        {
            _tester.TestGetUnitOfMeasureById(_context);
        }

        /// <summary>
        /// Ensures cost matrix may be retrieved by ID.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetCostMatrixById()
        {
            _tester.TestGetCostMatrixById(_context);
        }

        /// <summary>
        /// Ensures employees may be retrieved by role type.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetEmployeesByRoleType()
        {
            _tester.TestGetEmployeesByRoleType(_context);
        }

        /// <summary>
        /// Ensures products may be retrieved.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetProducts()
        {
            _tester.TestGetProducts(_context);
        }

        /// <summary>
        /// Ensures work types may be retrieved.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetWorkTypes()
        {
            _tester.TestGetWorkTypes(_context);
        }

        /// <summary>
        /// Ensures stakeholder may be retrieved by ID.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetStakeholderById()
        {
            _tester.TestGetStakeholderById(_context);
        }

        /// <summary>
        /// Ensures stakeholders may be retrieved by RFS ID.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetStakeholdersByRfsId()
        {
            _tester.TestGetStakeholdersByRfsId(_context);
        }

        /// <summary>
        /// Ensures stakeholder roles may be retrieved.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetStakeholderRoles()
        {
            _tester.TestGetStakeholderRoles(_context);
        }

        /// <summary>
        /// Ensures services offered may be retrieved.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetServicesOffered()
        {
            _tester.TestGetServicesOffered(_context);
        }

        /// <summary>
        /// Ensures services requested may be retrieved.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetServicesRequested()
        {
            _tester.TestGetServicesRequested(_context);
        }

        /// <summary>
        /// Ensures services requested may be retrieved by RFS ID.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetServicesRequestedByRfsId()
        {
            _tester.TestGetServicesRequestedByRfsId(_context);
        }

        /// <summary>
        /// Ensures invoice may be retrieved by ID.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetInvoiceById()
        {
            _tester.TestGetInvoiceById(_context);
        }

        /// <summary>
        /// Ensures invoices may be retrieved by IDs.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetInvoicesByIds()
        {
            _tester.TestGetInvoicesByIds(_context);
        }

        /// <summary>
        /// Ensures invoices may be retrieved by batch IDs.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetInvoicesByBatchIds()
        {
            _tester.TestGetInvoicesByBatchIds(_context);
        }

        /// <summary>
        /// Ensures invoices may be retrieved by dates.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetInvoicesByDates()
        {
            _tester.TestGetInvoicesByDates(_context);
        }

        /// <summary>
        /// Ensures stakeholders may be retrieved.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetStakeholders()
        {
            _tester.TestGetStakeholders(_context);
        }

        /// <summary>
        /// Ensures sevice calculation results may be retrieved by dates and billing status.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetServiceCalculationResultsByDatesAndBillingStatus()
        {
            _tester.TestGetServiceCalculationResultsByDatesAndBillingStatus(_context);
        }

        /// <summary>
        /// Ensures storage bills ready for invoice may be retrieved.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetStorageBillsToInvoice()
        {
            _tester.TestGetStorageBillsToInvoice(_context);
        }

        /// <summary>
        /// Ensures storage billing details may be retrieved by IDs.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetStorageBillingDetailsByIds()
        {
            _tester.TestGetStorageBillingDetailsByIds(_context);
        }

        /// <summary>
        /// Ensures storage billing details may be retrieved by billing ID.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetStorageBillingDetailsByBillingId()
        {
            _tester.TestGetStorageBillingDetailsByBillingId(_context);
        }

        /// <summary>
        /// Ensures storage billing detail may be retrieved by ID.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetStorageBillingDetailById()
        {
            _tester.TestGetStorageBillingDetailById(_context);
        }

        /// <summary>
        /// Ensures storage billing details may be retrieved by billing status.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetStorageBillingDetailsByBillingStatus()
        {
            _tester.TestGetStorageBillingDetailsUpToBillingStatus(_context);
        }

        /// <summary>
        /// Ensures storage billing details may be retrieved by billing ID and status.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetStorageBillingDetailsByBillingIdAndUpToBillingStatus()
        {
            _tester.TestGetStorageBillingDetailsByBillingIdAndUpToBillingStatus(_context);
        }

        /// <summary>
        /// Ensures storage billings may be retrieved.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetStorageBillings()
        {
            _tester.TestGetStorageBillings(_context);
        }

        /// <summary>
        /// Ensures storage billings may be retrieved by ID.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetStorageBillingById()
        {
            _tester.TestGetStorageBillingById(_context);
        }

        /// <summary>
        /// Ensures storage billings may be retrieved by IDs.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetStorageBillingsByIDs()
        {
            _tester.TestGetStorageBillingsByIDs(_context);
        }

        /// <summary>
        /// Ensures inventory details may be retrieved by IDs.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetInventoryDetailsByIDs()
        {
            _tester.TestGetInventoryDetailsByIDs(_context);
        }

        /// <summary>
        /// Ensures product profile may be retrieved by ID.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetProductProfileById()
        {
            _tester.TestGetProductProfileById(_context);
        }

        /// <summary>
        /// Ensures product profiles may be retrieved by IDs.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetProductProfilesByIDs()
        {
            _tester.TestGetProductProfilesByIDs(_context);
        }

        /// <summary>
        /// Ensures locations may be retrieved.
        /// </summary>
        [Test]
        [Category("DatabaseRequired")]
        public void TestGetLocations()
        {
            _tester.TestGetLocations(_context);
        }

    }
}
