using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using BopsDataAccess;
using NHibernate;
using NHibernate.Criterion;
using Scm.OpsCore.Legacy.DataLayer;

namespace Scm.OpsCore.Legacy.NHibernate
{
    /// <summary>
    /// NHibernate implementation of the <see cref="IRfsDataContext"/> interface.
    /// </summary>
    public class RfsDataContext : IRfsDataContext
    {
        private readonly ISession _dwsNoRepData;
        private ISession _dwsRepData;

        private string _dwsNoRepDataConnectionString;
        private string _dwsRepDataConnectionString;

        /// <summary>
        /// Default constructor, initializes session factories for DWS No Rep Data and DWS Rep Data databases.
        /// </summary>
        public RfsDataContext()
        {
            // TODO: move all the connection data to a file or something.

            var dwsNoRepDataSessionFactory = new NHibernateSessionFactory("SQL4", "DWS No Rep Data", "UnitTestUser", "19ZkV1e6Fto8QX");
            _dwsNoRepData = dwsNoRepDataSessionFactory.CreateSession();
            var dwsRepDataSessionFactory = new NHibernateSessionFactory("SQL4", "DWS Rep Data", "UnitTestUser", "19ZkV1e6Fto8QX");
            _dwsRepData = dwsRepDataSessionFactory.CreateSession();

            _dwsNoRepDataConnectionString = "Data Source=SQL4;Initial Catalog=DWS No Rep Data;User ID=UnitTestUser;Password=19ZkV1e6Fto8QX";
            _dwsRepDataConnectionString = "Data Source=SQL4;Initial Catalog=DWS Rep Data;User ID=UnitTestUser;Password=19ZkV1e6Fto8QX";
        }

        public int SaveChanges()
        {
            _dwsNoRepData.Flush();
            _dwsRepData.Flush();

            // Since NHibernate is going away I'm simply going to return a meaningless count.
            // If it becomes important in the future I can create an interceptor at session
            // open and use it to track pre/post-flush events.
            //
            // See: https://www.targetprocess.com/blog/2006/08/entity-life-cycle-in-nhibernate/

            return 0;
        }

        /// <inheritdoc/>
        public IList<BopsRfsStatus> GetStatuses()
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsRfsStatus)).List<BopsRfsStatus>();
        }

        /// <inheritdoc/>
        public IList<BopsRfsBillingStatus> GetBillingStatuses()
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsRfsBillingStatus)).List<BopsRfsBillingStatus>();
        }

        /// <inheritdoc/>
        public BopsRfsBillingStatus GetBillingStatusById(int id)
        {
            return _dwsNoRepData.Load<BopsRfsBillingStatus>(id);
        }

        /// <inheritdoc/>
        public IList<BopsRfsInvoiceStatus> GetInvoiceStatuses()
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsRfsInvoiceStatus)).List<BopsRfsInvoiceStatus>();
        }

        /// <inheritdoc/>
        public IList<BopsRfsCalculationResultType> GetCalculationResultTypes()
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsRfsCalculationResultType)).List<BopsRfsCalculationResultType>();
        }

        /// <inheritdoc/>
        public BopsLoad GetLoadByReference(string loadReference)
        {
            return _dwsNoRepData.Get<BopsLoad>(loadReference);
        }

        /// <inheritdoc/>
        public IList<BopsLoad> GetLoadsByReferences(string[] loadReferences)
        {
            return NHibernateDataUtilities.GetObjectsByIds<BopsLoad, string>(_dwsNoRepData, loadReferences, "LoadReference");
        }

        /// <inheritdoc/>
        public IList<BopsLoad> GetLoadsByLoadDateRange(DateTime beginDate, DateTime endDate)
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsLoad))
                .Add(Restrictions.Between("LoadDate", beginDate, endDate))
                .List<BopsLoad>();
        }

        /// <inheritdoc/>
        public IList<BopsRfsCalculationResult> GetCalculationResultsByLoadReference(string loadReference)
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsRfsCalculationResult))
                .Add(Restrictions.Eq("LoadReference", loadReference)).List<BopsRfsCalculationResult>();
        }

        /// <inheritdoc/>
        public IList<BopsRfsCalculationResult> GetCalculationResultsByLoadReferences(string[] loadReferences)
        {
            // NOTE: Of all the methods that use this kind of boilerplate, this one had to remain custom
            // because it requires the null warehouse values as well. Refactoring the lower-level call
            // to accept a list of criteria would make it more useful at some point.

            const int maxValuesForInQuery = 300;    // Specifies the maximum size of each chunk of data to read.

            var returnValue = new List<BopsRfsCalculationResult>();
            if (loadReferences == null)
                return returnValue;

            var inputIndex = 0;
            var numberRemaining = loadReferences.Length;

            while (numberRemaining > 0)
            {
                // Figure out how many objects to read, up to the maximum chunk size. Then allocate an array
                // of the proper size and fill it up with IDs.

                var arraySize = Math.Min(numberRemaining, maxValuesForInQuery);
                var chunkIds = new string[arraySize];

                for (var i = 0; i < arraySize; i++)
                {
                    chunkIds[i] = loadReferences[inputIndex++];
                    numberRemaining--;
                }

                var chunk = _dwsNoRepData.CreateCriteria(typeof(BopsRfsCalculationResult))
                    .Add(Restrictions.In("LoadReference", chunkIds))
                    .Add(Restrictions.IsNull("WarehouseDocumentId"))
                    .Add(Restrictions.IsNull("WarehouseDocumentType"))
                    .List<BopsRfsCalculationResult>();

                returnValue.AddRange(chunk);
            }

            return returnValue;
        }

        /// <inheritdoc/>
        public IList<BopsRfsServiceCalculationResult> GetServiceCalculationResultsByLoadReferences(string[] loadReferences)
        {
            return NHibernateDataUtilities.GetObjectsByIds<BopsRfsServiceCalculationResult, string>(_dwsNoRepData, loadReferences, "LoadRef");
        }

        /// <inheritdoc/>
        public IList<BopsRfsServiceCalculationResult> GetServiceCalculationResultsByIds(int[] resultIds)
        {
            return NHibernateDataUtilities.GetObjectsByIds<BopsRfsServiceCalculationResult, int>(_dwsNoRepData, resultIds, "ResultId");
        }

        /// <inheritdoc/>
        public IList<BopsRfsServiceCalculationResult> GetServiceCalculationResultsByLoadReference(string loadReference)
        {
            return _dwsNoRepData.CreateCriteria((typeof(BopsRfsServiceCalculationResult)))
                .Add(Restrictions.Eq("LoadRef", loadReference)).List<BopsRfsServiceCalculationResult>();

        }

        /// <inheritdoc/>
        public BopsRfsServiceCalculationResult GetServiceCalculationResultById(int serviceCalculationResultId)
        {
            return _dwsNoRepData.Get<BopsRfsServiceCalculationResult>(serviceCalculationResultId);
        }

        /// <inheritdoc/>
        public BopsReceivingRecord GetReceiverById(int receiverId)
        {
            return _dwsNoRepData.Get<BopsReceivingRecord>(receiverId);
        }

        /// <inheritdoc/>
        public IList<BopsReceivingRecord> GetReceiversByIDs(int[] receiverIds)
        {
            return NHibernateDataUtilities.GetObjectsByIds<BopsReceivingRecord, int>(_dwsNoRepData, receiverIds, "ReceiverId");
        }

        /// <inheritdoc/>
        public IList<BopsReceivingRecord> GetReceiversByDateReceivedRange(DateTime beginDate, DateTime endDate)
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsReceivingRecord))
                .Add(Restrictions.Between("DateReceived", beginDate, endDate))
                .List<BopsReceivingRecord>();
        }

        /// <inheritdoc/>
        public BopsShippingRecord GetShipperById(int shipperId)
        {
            return _dwsNoRepData.Get<BopsShippingRecord>(shipperId);
        }

        /// <inheritdoc/>
        public IList<BopsShippingRecord> GetShippersByIDs(int[] shipperIds)
        {
            return NHibernateDataUtilities.GetObjectsByIds<BopsShippingRecord, int>(_dwsNoRepData, shipperIds, "LoadId");
        }

        /// <inheritdoc/>
        public IList<BopsShippingRecord> GetShippersByShipmentDateRange(DateTime beginDate, DateTime endDate)
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsShippingRecord))
                .Add(Restrictions.Between("ShipmentDate", beginDate, endDate))
                .List<BopsShippingRecord>();
        }

        /// <inheritdoc/>
        public IList<BopsRfsCalculationResult> GetCalculationResultsByReceiverId(int receiverId)
        {
            return _dwsNoRepData.CreateCriteria(typeof (BopsRfsCalculationResult))
                .Add(Restrictions.Eq("WarehouseDocumentId", receiverId))
                .Add(Restrictions.Eq("WarehouseDocumentType", WarehouseDocumentType.Received))
                .List<BopsRfsCalculationResult>();
        }

        /// <inheritdoc/>
        public IList<BopsRfsServiceCalculationResult> GetServiceCalculationResultsByReceiverId(int receiverId)
        {
            return _dwsNoRepData.CreateCriteria((typeof(BopsRfsServiceCalculationResult)))
                .Add(Restrictions.Eq("DocumentId", receiverId))
                .Add(Restrictions.Eq("DocumentType", WarehouseDocumentType.Received))
                .List<BopsRfsServiceCalculationResult>();
        }

        /// <inheritdoc/>
        public IList<BopsRfsServiceCalculationResult> GetServiceCalculationResultsByShipperId(int shipperId)
        {
            return _dwsNoRepData.CreateCriteria((typeof(BopsRfsServiceCalculationResult)))
                .Add(Restrictions.Eq("DocumentId", shipperId))
                .Add(Restrictions.Eq("DocumentType", WarehouseDocumentType.Shipped))
                .List<BopsRfsServiceCalculationResult>();
        }

        /// <inheritdoc/>
        public IList<BopsRfsCalculationResult> GetCalculationResultsByShipperId(int shipperId)
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsRfsCalculationResult))
                .Add(Restrictions.Eq("WarehouseDocumentId", shipperId))
                .Add(Restrictions.Eq("WarehouseDocumentType", WarehouseDocumentType.Shipped))
                .List<BopsRfsCalculationResult>();
        }

        /// <inheritdoc/>
        public IList<BopsRfsCalculationResult> GetCalculationResultsByWarehouseDocumentIds(int[] warehouseDocumentIds)
        {
            return NHibernateDataUtilities.GetObjectsByIds<BopsRfsCalculationResult, int>(_dwsNoRepData, warehouseDocumentIds, "WarehouseDocumentId");
        }

        /// <inheritdoc/>
        public IList<BopsRfsServiceCalculationResult> GetServiceCalculationResultsByWarehouseDocumentIds(int[] warehouseDocumentIds)
        {
            return NHibernateDataUtilities.GetObjectsByIds<BopsRfsServiceCalculationResult, int>(_dwsNoRepData, warehouseDocumentIds, "DocumentId");
        }

        /// <inheritdoc/>
        public IList<BopsRfs> GetRfs()
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsRfs)).List<BopsRfs>();
        }

        /// <inheritdoc/>
        public BopsRfs GetRfsById(int rfsId)
        {
            return _dwsNoRepData.Get<BopsRfs>(rfsId);
        }

        /// <inheritdoc/>
        public IList<BopsRfs> GetRfsByIds(int[] rfsIds)
        {
            return NHibernateDataUtilities.GetObjectsByIds<BopsRfs, int>(_dwsNoRepData, rfsIds, "RfsId");
        }

        /// <inheritdoc/>
        public IList<BopsRfsInvoiceDetail> GetInvoiceDetailsByInvoiceId(int invoiceId)
        {
            return _dwsNoRepData.CreateCriteria((typeof(BopsRfsInvoiceDetail)))
                .Add(Restrictions.Eq("InvoiceRef", invoiceId))
                .List<BopsRfsInvoiceDetail>();
        }

        /// <inheritdoc/>
        public IList<BopsRfsInvoiceDetail> GetInvoiceDetailsByInvoiceIds(int[] invoiceIds)
        {
            return NHibernateDataUtilities.GetObjectsByIds<BopsRfsInvoiceDetail, int>(_dwsNoRepData, invoiceIds, "InvoiceRef");
        }

        /// <inheritdoc/>
        public IList<BopsRfsInvoiceDetail> GetInvoiceDetailsFromServiceCalculationResults(int[] ids)
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsRfsInvoiceDetail))
                .Add(Restrictions.In("ServiceCalculationResultRef", ids))
                .List<BopsRfsInvoiceDetail>();
        }

        /// <inheritdoc/>
        public BopsDestination GetDestinationById(int destinationId)
        {
            return _dwsRepData.Get<BopsDestination>(destinationId);
        }

        /// <inheritdoc/>
        public IList<BopsDestination> GetDestinationsByIds(int[] destinationIds)
        {
            return NHibernateDataUtilities.GetObjectsByIds<BopsDestination, int>(_dwsRepData, destinationIds, "DestinationId");
        }

        /// <inheritdoc/>
        public BopsRfsCostMethod GetCostMethodById(int costMethodId)
        {
            return _dwsNoRepData.Get<BopsRfsCostMethod>(costMethodId);
        }

        /// <inheritdoc/>
        public IList<BopsSysUnitOfMeasure> GetUnitsOfMeasure()
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsSysUnitOfMeasure)).List<BopsSysUnitOfMeasure>();
        }

        /// <inheritdoc/>
        public BopsSysUnitOfMeasure GetUnitOfMeasureById(int unitId)
        {
            return _dwsNoRepData.Get<BopsSysUnitOfMeasure>(unitId);
        }

        /// <inheritdoc/>
        public BopsRfsCostMatrix GetCostMatrixById(int matrixId)
        {
            return _dwsNoRepData.Get<BopsRfsCostMatrix>(matrixId);
        }

        /// <inheritdoc/>
        public IList<BopsDriver> GetEmployeesByRoleType(EmployeeRoleTypes roleType)
        {
            // This is a two-step process. First we get the role assignments themselves...

            var employeeReferences = _dwsNoRepData.CreateCriteria(typeof(BopsEmployeeRole))
                .Add(Restrictions.Eq("EmployeeRoleTypeRef", (int)roleType))
                .List<BopsEmployeeRole>();

            // ...then we use those to create an array of actual employee IDs...

            var employeeIds = new int[employeeReferences.Count];
            for (var i = 0; i < employeeReferences.Count; i++)
            {
                employeeIds[i] = employeeReferences[i].EmployeeRef;
            }

            // ... which we use to do the actual query that matters.

            return _dwsNoRepData.CreateCriteria(typeof(BopsDriver))
                .Add(Restrictions.In("DriverId", employeeIds))
                .List<BopsDriver>();
        }

        /// <inheritdoc/>
        public IList<BopsDestination> GetDestinations()
        {
            return _dwsRepData.CreateCriteria(typeof(BopsDestination)).List<BopsDestination>();
        }

        /// <inheritdoc/>
        public IList<BopsAtsfProduct> GetProducts()
        {
            return _dwsRepData.CreateCriteria(typeof(BopsAtsfProduct)).List<BopsAtsfProduct>();
        }

        /// <inheritdoc/>
        public IList<BopsRfsWorkType> GetWorkTypes()
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsRfsWorkType)).List<BopsRfsWorkType>();
        }

        public BopsRfsStakeholder GetStakeholderById(int stakeholderId)
        {
            return _dwsNoRepData.Get<BopsRfsStakeholder>(stakeholderId);
        }

        /// <inheritdoc/>
        public IList<BopsRfsStakeholder> GetStakeholdersByRfsId(int rfsId)
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsRfsStakeholder))
                .Add(Restrictions.Eq("RfsRef", rfsId))
                .List<BopsRfsStakeholder>();
        }

        /// <inheritdoc/>
        public IList<BopsRfsStakeholderRole> GetStakeholderRoles()
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsRfsStakeholderRole)).List<BopsRfsStakeholderRole>();
        }

        /// <inheritdoc/>
        public IList<BopsRfsServicesOffered> GetServicesOffered()
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsRfsServicesOffered)).List<BopsRfsServicesOffered>();
        }

        /// <inheritdoc/>
        public IList<BopsRfsServicesRequested> GetServicesRequested()
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsRfsServicesRequested)).List<BopsRfsServicesRequested>();
        }

        /// <inheritdoc/>
        public IList<BopsRfsServicesRequested> GetServicesRequestedByRfsId(int rfsId)
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsRfsServicesRequested))
                .Add(Restrictions.Eq("RfsRef", rfsId))
                .List<BopsRfsServicesRequested>();
        }

        /// <inheritdoc/>
        public BopsRfsInvoice GetInvoiceById(int invoiceId)
        {
            return _dwsNoRepData.Get<BopsRfsInvoice>(invoiceId);
        }

        /// <inheritdoc/>
        public IList<BopsRfsInvoice> GetInvoicesByIds(int[] invoiceIds)
        {
            return NHibernateDataUtilities.GetObjectsByIds<BopsRfsInvoice, int>(_dwsNoRepData, invoiceIds, "InvoiceId");
        }

        /// <inheritdoc/>
        public IList<BopsRfsInvoice> GetInvoicesByBatchIds(int[] batchIds)
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsRfsInvoice))
                .Add(Restrictions.In("BatchId", batchIds))
                .List<BopsRfsInvoice>();
        }

        public IList<BopsRfsInvoice> GetInvoicesByDates(DateTime beginDate, DateTime endDate)
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsRfsInvoice))
                    .Add(Restrictions.Ge("InvoiceDate", beginDate))
                    .Add(Restrictions.Lt("InvoiceDate", endDate))
                    //.Add(Restrictions.IsNull("BatchId"))
                    .List<BopsRfsInvoice>();
        }

        /// <inheritdoc/>
        public IList<BopsRfsStakeholder> GetStakeholders()
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsRfsStakeholder)).List<BopsRfsStakeholder>();
        }

        /// <inheritdoc/>
        public IList<BopsRfsServiceCalculationResult> GetServiceCalculationResultsByDatesAndBillingStatus(DateTime beginDate, DateTime endDate,
            RfsBillingStatus billingStatus)
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsRfsServiceCalculationResult))
                .Add(Restrictions.Ge("BillingDate", beginDate))
                .Add(Restrictions.Lt("BillingDate", endDate))
                .Add(Restrictions.Eq("BillingStatus", billingStatus))
                .List<BopsRfsServiceCalculationResult>();
        }

        /// <inheritdoc/>
        public int GetStorageBillsToInvoice()
        {
            return _dwsNoRepData.QueryOver<BopsRfsStorageBillingDetail>()
                .Where(d => d.BillingStatus < RfsBillingStatus.OnInvoice).RowCount();
        }

        /// <inheritdoc/>
        public IList<BopsRfsStorageBillingDetail> GetStorageBillingDetailsByIds(int[] storageBillingDetailIds)
        {
            return NHibernateDataUtilities.GetObjectsByIds<BopsRfsStorageBillingDetail, int>(_dwsNoRepData, storageBillingDetailIds, "DetailId");
        }

        /// <inheritdoc/>
        public IList<BopsRfsStorageBillingDetail> GetStorageBillingDetailsByBillingId(int storageBillingId)
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsRfsStorageBillingDetail))
                .Add(Restrictions.Eq("BillingRef", storageBillingId))
                .List<BopsRfsStorageBillingDetail>();
        }

        /// <inheritdoc/>
        public BopsRfsStorageBillingDetail GetStorageBillingDetailById(int storageBillingDetailId)
        {
            return _dwsNoRepData.Get<BopsRfsStorageBillingDetail>(storageBillingDetailId);
        }

        /// <inheritdoc/>
        public IList<BopsRfsStorageBillingDetail> GetStorageBillingDetailsUpToBillingStatus(RfsBillingStatus billingStatus)
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsRfsStorageBillingDetail))
                .Add(Restrictions.Lt("BillingStatus", billingStatus))
                .List<BopsRfsStorageBillingDetail>();
        }

        public IList<BopsRfsStorageBillingDetail> GetStorageBillingDetailsByBillingIdAndUpToBillingStatus(int billingId, RfsBillingStatus billingStatus)
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsRfsStorageBillingDetail))
                .Add(Restrictions.Eq("BillingRef", billingId))
                .Add(Restrictions.Lt("BillingStatus", billingStatus))
                .List<BopsRfsStorageBillingDetail>();
        }

        public IList<BopsRfsStorageBilling> GetStorageBillings()
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsRfsStorageBilling)).List<BopsRfsStorageBilling>();
        }

        /// <inheritdoc/>
        public BopsRfsStorageBilling GetStorageBillingById(int storageBillingId)
        {
            return _dwsNoRepData.Load<BopsRfsStorageBilling>(storageBillingId);
        }

        /// <inheritdoc/>
        public IList<BopsRfsStorageBilling> GetStorageBillingsByIDs(int[] storageBillingIds)
        {
            return NHibernateDataUtilities.GetObjectsByIds<BopsRfsStorageBilling, int>(_dwsNoRepData, storageBillingIds, "BillingId");
        }

        /// <inheritdoc/>
        public IList<BopsInventoryDetail> GetInventoryDetailsByIDs(int[] inventoryDetailIds)
        {
            return NHibernateDataUtilities.GetObjectsByIds<BopsInventoryDetail, int>(_dwsNoRepData, inventoryDetailIds, "DetailId");
        }

        public BopsProductProfile GetProductProfileById(int productProfileId)
        {
            return _dwsNoRepData.Load<BopsProductProfile>(productProfileId);
        }

        /// <inheritdoc/>
        public IList<BopsProductProfile> GetProductProfilesByIDs(int[] productProfileIDs)
        {
            return NHibernateDataUtilities.GetObjectsByIds<BopsProductProfile, int>(_dwsNoRepData, productProfileIDs, "ProfileId");
        }

        /// <inheritdoc/>
        public IList<BopsRfsLocation> GetLocations()
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsRfsLocation)).List<BopsRfsLocation>();
        }

        /// <inheritdoc/>
        public void AddInvoice(BopsRfsInvoice newInvoice)
        {
            _dwsNoRepData.Save(newInvoice);
        }

        /// <inheritdoc/>
        public void AddInvoiceDetail(BopsRfsInvoiceDetail newInvoiceDetail)
        {
            _dwsNoRepData.Save(newInvoiceDetail);
        }

        /// <inheritdoc/>
        public void AddStorageBillingEvent(BopsRfsStorageBillingEvent newEvent)
        {
            _dwsNoRepData.Save(newEvent);
        }

        /// <inheritdoc/>
        public void AddRfs(BopsRfs newRfs)
        {
            _dwsNoRepData.Save(newRfs);
        }

        /// <inheritdoc/>
        public void AddStakeholder(BopsRfsStakeholder newStakeholder)
        {
            _dwsNoRepData.Save(newStakeholder);
        }

        /// <inheritdoc/>
        public void AddServiceRequested(BopsRfsServicesRequested newServiceRequested)
        {
            _dwsNoRepData.Save(newServiceRequested);
        }

        /// <inheritdoc/>
        public void AddInvoiceExport(BopsRfsInvoiceExport newInvoiceExport)
        {
            _dwsNoRepData.Save(newInvoiceExport);
        }

        /// <inheritdoc/>
        public void AddInvoiceTransferBatch(BopsRfsInvoiceXferBatch newInvoiceTransferBatch)
        {
            _dwsNoRepData.Save(newInvoiceTransferBatch);
        }

        /// <inheritdoc/>
        public void AddServiceCalculationResult(BopsRfsServiceCalculationResult newServiceCalculationResult)
        {
            _dwsNoRepData.Save(newServiceCalculationResult);
        }

        /// <inheritdoc/>
        public void AddLoadRevenue(BopsLoadRevenue newLoadRevenue)
        {
            _dwsNoRepData.Save(newLoadRevenue);
        }

        /// <inheritdoc/>
        public void AddWarehouseRevenue(BopsWarehouseRevenue newWarehouseRevenue)
        {
            _dwsNoRepData.Save(newWarehouseRevenue);
        }

        /// <inheritdoc/>
        public BopsDestination GetParentDestination(int childDestinationId)
        {
            var child = _dwsRepData.Load<BopsDestination>(childDestinationId);
            if (child.ParentRef.HasValue && child.ParentRef.Value != child.DestinationId)
                return _dwsRepData.Load<BopsDestination>(childDestinationId);
            return child;
        }

        /// <inheritdoc/>
        public void RemoveInvoiceAndDetails(int invoiceId)
        {
            //2.x Version of Delete deprecated in 3.x
            //_DwsNoRepData.Delete("from BopsRfsInvoiceDetail d where d.InvoiceRef = :Id", InvoiceId, NHibernateUtil.Int32);
            //
            _dwsNoRepData
                .CreateQuery("DELETE FROM BopsRfsInvoiceDetail WHERE InvoiceRef = :Id")
                .SetParameter("Id", invoiceId)
                .ExecuteUpdate();
            //
            _dwsNoRepData
                .CreateQuery("DELETE FROM BopsRfsInvoice WHERE InvoiceId = :Id")
                .SetParameter("Id", invoiceId)
                .ExecuteUpdate();

            _dwsNoRepData.Flush();
        }

        public void RemoveInvoiceDetails(int invoiceId)
        {
            _dwsNoRepData
                .CreateQuery("DELETE FROM BopsRfsInvoiceDetail d WHERE d.InvoiceRef = :Id")
                .SetParameter("Id", invoiceId)
                .ExecuteUpdate();

            _dwsNoRepData.Flush();
        }

        /// <inheritdoc/>
        private static BopsRfsStorageBillingInput GetStorageBillingInputFromReader(IDataRecord reader)
        {
            var returnValue = new BopsRfsStorageBillingInput
            {
                InventoryId = DataUtilities.GetReaderInteger(reader, "Inventory Id"),
                WeightLabel = DataUtilities.GetReaderString(reader, "Weight Label"),
                Weight = DataUtilities.GetReaderInteger(reader, "Weight"),
                ProfileId = DataUtilities.GetReaderInteger(reader, "Profile ID"),
                CountLabel = DataUtilities.GetReaderString(reader, "Count Label"),
                Count = DataUtilities.GetReaderInteger(reader, "Count"),
                DateBilledThrough = DataUtilities.GetReaderNullableDateTime(reader, "Date Billed Through"),
                ReceiverId = DataUtilities.GetReaderInteger(reader, "Receiver ID"),
                DateReceived = DataUtilities.GetReaderDateTime(reader, "Date Received"),
                ReceivingClientRef = DataUtilities.GetReaderInteger(reader, "Receiving Client Ref"),
                RateId = DataUtilities.GetReaderInteger(reader, "Rate Id"),
                BillToClientRef = DataUtilities.GetReaderInteger(reader, "Bill To Client Ref"),
                BillingType = (RfsStorageBillingType) DataUtilities.GetReaderInteger(reader, "Billing Type Ref"),
                DaysInCycle = DataUtilities.GetReaderInteger(reader, "Days In Cycle"),
                UnitCostPerCycle = DataUtilities.GetReaderDouble(reader, "Unit Cost Per Cycle"),
                UnitRef = DataUtilities.GetReaderInteger(reader, "Unit Ref"),
                AssignmentId = DataUtilities.GetReaderInteger(reader, "Assignment Id"),
                BeginDate = DataUtilities.GetReaderDateTime(reader, "Begin Date"),
                EndDate = DataUtilities.GetReaderDateTime(reader, "End Date"),
                RfsId = DataUtilities.GetReaderInteger(reader, "Rfs Id"),
                StorageFreeDays = DataUtilities.GetReaderInteger(reader, "Storage Free Days")
            };

            if (reader["Shipment Date"] != DBNull.Value)
                returnValue.DateShipped = DataUtilities.GetReaderDateTime(reader, "Shipment Date");

            return returnValue;
        }

        /// <inheritdoc/>
        public IList<BopsRfsStorageBillingInput> GetStorageBillingInputData()
        {
            var returnValue = new List<BopsRfsStorageBillingInput>();
            var databaseConnectionString = _dwsNoRepDataConnectionString;

            using (var connection = new SqlConnection(databaseConnectionString))
            {
                connection.Open();

                using (var command = new SqlCommand("BopsRfsStorageBillingGetInputData", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            var newInput = GetStorageBillingInputFromReader(reader);
                            returnValue.Add(newInput);
                        }

                        reader.Close();
                    }
                }

                connection.Close();
            }

            return returnValue;
        }

        /// <inheritdoc/>
        public IList<BopsRfsStorageBillingInventoryTracking> GetStorageBillingInventoryTrackingsByIds(
            int[] storageBillingInventoryIds)
        {
            return NHibernateDataUtilities.GetObjectsByIds<BopsRfsStorageBillingInventoryTracking, int>
                (_dwsNoRepData, storageBillingInventoryIds, "InventoryRef");
        }

        /// <inheritdoc/>
        public IList<BopsRfsStorageRate> GetStorageRatesByRateIds(int[] rateIds)
        {
            return NHibernateDataUtilities.GetObjectsByIds<BopsRfsStorageRate, int>(_dwsNoRepData, rateIds, "RateId");
        }

        /// <inheritdoc/>
        public IList<BopsRfsStorageRateEscalation> GetStorageRateEscalationsByRateIds(int[] rateIds)
        {
            return NHibernateDataUtilities.GetObjectsByIds<BopsRfsStorageRateEscalation, int>(_dwsNoRepData, rateIds, "StorageRateRef");
        }

        /// <inheritdoc/>
        public IList<BopsRfsStorageRateAssignment> GetStorageRateAssignmentsByProfileIds(int[] profileIds)
        {
            return NHibernateDataUtilities.GetObjectsByIds<BopsRfsStorageRateAssignment, int>(_dwsNoRepData, profileIds, "ProfileRef");
        }

        /// <inheritdoc/>
        public BopsRfsStorageBilling GetLastStorageBilling()
        {
            // This is one formluation, but it relies upon HQL.
            //
            //var billings = _dwsNoRepData.CreateQuery("SELECT MAX(B.BillingId) FROM BopsRfsStorageBilling B").List();

            // This is arguably a better formulation. Both were taken from the original RfsStorageBillingCalculator file.

            var billings = _dwsNoRepData.CreateCriteria(typeof(BopsRfsStorageBilling))
                .SetMaxResults(1)
                .AddOrder(new Order("BillingId", false))
                .List<BopsRfsStorageBilling>();

            Debug.Assert(billings.Count == 1);
            return billings.Count == 1 ? billings[0] : null;
        }

        /// <inheritdoc/>
        public void RemoveStorageBilling(BopsRfsStorageBilling storageBilling)
        {
            _dwsNoRepData.Delete(storageBilling);
            _dwsNoRepData.Flush();
        }

        /// <inheritdoc/>
        public void RemoveStorageBillingDetail(BopsRfsStorageBillingDetail storageBillingDetail)
        {
            _dwsNoRepData.Delete(storageBillingDetail);
            _dwsNoRepData.Flush();
        }

        /// <inheritdoc/>
        public IList<BopsRfsServiceCalculationResult> GetServiceCalculationResultsByRfsForBulkInvoice(int rfsNumber)
        {
            // TODO: Improve efficiency. I couldn't get an NHibernate custom query bound to a stored
            //  procedure and returning good results after an hour or so of banging at it. I suspect
            //  it's due to bugs in the very outdated version we're using, so I'm just going to do the
            //  ineffecient thing and load the result IDs via the stored procedure and then use those
            //  to fetch the actual data via NHibernate.

            var databaseConnectionString = _dwsNoRepDataConnectionString;
            var resultIds = new Dictionary<int, int>();

            using (var connection = new SqlConnection(databaseConnectionString))
            {
                connection.Open();

                using (var command = new SqlCommand("BopsRfsInvoiceGetBillsForRfs", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@RfsNumber", SqlDbType.Int).Value = rfsNumber;

                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            var resultId = DataUtilities.GetReaderInteger(reader, "Result ID");
                            if (!resultIds.ContainsKey(resultId))
                                resultIds.Add(resultId, 0);
                        }
                        reader.Close();
                    }
                }
                connection.Close();
            }

            return GetServiceCalculationResultsByIds(resultIds.Keys.ToArray());
        }

        /// <inheritdoc/>
        public IList<BopsScan> GetScansByLoadReferencesTypeSignedAndReject(string[] loadRefs, int docType, bool isSigned, int rejectRef)
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsScan))
                .Add(Restrictions.In("LoadRef", loadRefs))
                .Add(Restrictions.Eq("DocTypeRef", docType))
                .Add(Restrictions.Eq("Signed", isSigned))
                .Add(Restrictions.Eq("RejectRef", rejectRef))
                .List<BopsScan>();
        }

        /// <inheritdoc/>
        public IList<BopsRfsStakeholderClientMapping> GetStakeholderClientMappingsByRfsId(int rfsId)
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsRfsStakeholderClientMapping))
                .Add(Expression.Eq("RfsRef", rfsId))
                .List<BopsRfsStakeholderClientMapping>();
        }

        /// <inheritdoc/>
        public IList<BopsRfsStakeholderClientMappingDetail> GetStakeholderClientMappingsByIdAndOriginOrDestinationRole(int mappingId)
        {
            const int originRole = 3;
            const int destinationRole = 4;

            return _dwsNoRepData.CreateCriteria(typeof(BopsRfsStakeholderClientMappingDetail))
                .Add(Restrictions.Eq("MappingRef", mappingId))
                .Add(Restrictions.Or(
                    Restrictions.Eq("RoleRef", originRole), 
                    Restrictions.Eq("RoleRef", destinationRole)))
                .List<BopsRfsStakeholderClientMappingDetail>();
        }

        /// <inheritdoc/>
        public IList<BopsTransitTime> GetTransitTimeByOriginDestinationAndHour(int originId, int destinationId, int hour)
        {
            return _dwsRepData.CreateCriteria(typeof(BopsTransitTime))
                .Add(Restrictions.Eq("FromRef", originId))
                .Add(Restrictions.Eq("ToRef", destinationId))
                .Add(Restrictions.Eq("Hour", 0))
                .List<BopsTransitTime>();
        }

        /// <inheritdoc/>
        public BopsRfsServicesOffered GetServiceOfferedById(int serviceOfferedId)
        {
            return _dwsNoRepData.Load<BopsRfsServicesOffered>(serviceOfferedId);
        }

        /// <inheritdoc/>
        public IList<BopsMas90ClientCode> GetMas90ClientCodes()
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsMas90ClientCode)).List<BopsMas90ClientCode>();
        }

        /// <inheritdoc/>
        public IList<BopsRfsInvoiceTypeData> GetInvoiceTypeData()
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsRfsInvoiceTypeData)).List<BopsRfsInvoiceTypeData>();
        }

        /// <inheritdoc/>
        public BopsRfsInvoiceExport GetInvoiceExportById(int exportId)
        {
            return _dwsNoRepData.Load<BopsRfsInvoiceExport>(exportId);
        }

        /// <inheritdoc/>
        public IList<BopsRfsInvoiceExportDetail> GetInvoiceExportDetailsByExportId(int exportId)
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsRfsInvoiceExportDetail))
                .Add(Restrictions.Eq("ExportRef", exportId))
                .List<BopsRfsInvoiceExportDetail>();
        }

        /// <inheritdoc/>
        public IList<BopsRfsInvoiceXferBatch> GetInvoiceTransferBatchesByIds(int[] batchIds)
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsRfsInvoiceXferBatch))
                .Add(Restrictions.In("BatchId", batchIds))
                .List<BopsRfsInvoiceXferBatch>();
        }

        /// <inheritdoc/>
        public BopsRfsInvoiceXferBatch GetInvoiceTransferBatchNotPostedByLocation(string location)
        {
            return _dwsNoRepData.CreateCriteria(typeof (BopsRfsInvoiceXferBatch))
                .Add(Restrictions.Eq("LocationCode", location))
                .Add(Restrictions.IsNull("PostedDate"))
                .List<BopsRfsInvoiceXferBatch>().FirstOrDefault();
        }

        /// <inheritdoc/>
        public BopsLoadRevenue GetLoadRevenueByReference(string loadReference)
        {
            return _dwsNoRepData.Get<BopsLoadRevenue>(loadReference);
        }

        /// <inheritdoc/>
        public void RemoveLoadRevenue(BopsLoadRevenue loadRevenue)
        {
            _dwsNoRepData.Delete(loadRevenue);
            _dwsNoRepData.Flush();
        }

        /// <inheritdoc/>
        public void RemoveServiceCalculationResult(BopsRfsServiceCalculationResult serviceCalculationResult)
        {
            _dwsNoRepData.Delete(serviceCalculationResult);
            _dwsNoRepData.Flush();
        }

        /// <inheritdoc/>
        public BopsWarehouseRevenue GetWarehouseRevenueByDocumentTypeAndId(WarehouseDocumentType documentType, int documentId)
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsWarehouseRevenue))
                .Add(Restrictions.Eq("DocumentId", documentId))
                .Add(Restrictions.Eq("DocumentType", documentType))
                .UniqueResult<BopsWarehouseRevenue>();
        }

        /// <inheritdoc/>
        public void RemoveWarehouseRevenue(BopsWarehouseRevenue warehouseRevenue)
        {
            _dwsNoRepData.Delete(warehouseRevenue);
            _dwsNoRepData.Flush();
        }

        /// <inheritdoc/>
        public void RemoveInvalidRevenueResults()
        {
            using (var connection = new SqlConnection(_dwsNoRepDataConnectionString))
            {
                connection.Open();

                using (var command = new SqlCommand("BopsCleanRfsResults", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.CommandTimeout = 120;   // Wait for up to two minutes to try to avoid deadlocks.
                    command.ExecuteNonQuery();
                }

                connection.Close();
            }
        }

        public IList<BopsFscFuelPriceHistory> GetFuelPriceHistoryOrderedByBeginDate()
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsFscFuelPriceHistory))
                .AddOrder(Order.Asc("BeginDate"))
                .List<BopsFscFuelPriceHistory>();
        }

        public IList<BopsFsc> GetFuelSurcharge()
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsFsc)).List<BopsFsc>();
        }

        public IList<BopsFscDetailFloatIndexed> GetFuelSurchargeDetailFloatIndexedByFscIdOrderedByIndexMinimum(int fscId)
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsFscDetailFloatIndexed))
                .Add(Restrictions.Eq("FscRef", fscId))
                .AddOrder(Order.Asc("IndexMinimum"))
                .List<BopsFscDetailFloatIndexed>();
        }

        public IList<BopsFscDetailOdIndexed> GetFuelSurchargeDetailOdByFscIdIndexedOrderedByMatchMode(int fscId)
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsFscDetailOdIndexed))
                .Add(Expression.Eq("FscRef", fscId))
                .AddOrder(Order.Desc("MatchMode"))
                .List<BopsFscDetailOdIndexed>();
        }

        public IList<BopsRfsInvoiceXferBatch> GetInvoiceTransferBatchesToPostByDates(DateTime beginDate, DateTime endDate)
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsRfsInvoiceXferBatch))
                    .Add(Restrictions.Ge("CreatedDate", beginDate))
                    .Add(Restrictions.Lt("CreatedDate", endDate))
                    .Add(Restrictions.IsNull("PostedDate"))
                    .List<BopsRfsInvoiceXferBatch>();
        }

        public void AddStorageBilling(BopsRfsStorageBilling newStorageBilling)
        {
            _dwsNoRepData.Save(newStorageBilling);
        }

        public void AddStorageBillingDetail(BopsRfsStorageBillingDetail newStorageBillingDetail)
        {
            _dwsNoRepData.Save(newStorageBillingDetail);
        }

        public IList<BopsDriverPlanDetail> GetDriverPlanDetailsByLoadReference(string loadReference)
        {
            return _dwsNoRepData.CreateCriteria(typeof(BopsDriverPlanDetail))
                .Add(Restrictions.Eq("LoadRef", loadReference))
                .List<BopsDriverPlanDetail>();
        }

        public BopsDriverPlan GetDriverPlanById(int planId)
        {
            return _dwsNoRepData.Load<BopsDriverPlan>(planId);
        }

        public IList<CopsUserDetails> GetCopsUserDetails()
        {
            return _dwsNoRepData.CreateCriteria(typeof(CopsUserDetails)).List<CopsUserDetails>();
        }

        public void RemoveCopsUserDetails(string copsUserId)
        {
            var copsUserDetails = _dwsNoRepData.Get<CopsUserDetails>(copsUserId);
            if (copsUserDetails != null)
                _dwsNoRepData.Delete(copsUserDetails);
            _dwsNoRepData.Flush();
        }
    }
}
