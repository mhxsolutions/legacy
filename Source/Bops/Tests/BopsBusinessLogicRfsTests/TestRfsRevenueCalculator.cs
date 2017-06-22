using System.Collections.Generic;
using BopsBusinessLogicRfs;
using BopsDataAccess;
using NUnit.Framework;
using Scm.OpsCore.Legacy.DataLayer;

namespace BopsBusinessLogicRfsTests
{
    [TestFixture]
    public class TestRfsRevenueCalculator
    {
        private IRfsDataContext _rfsDataContext;

        [SetUp]
        public void Initialize()
        {
            _rfsDataContext = Scm.OpsCore.Bootstrap.Bootstrap.Kernel.Get<IRfsDataContext>();
        }

        [TearDown]
        public void Uninitialize()
        {
            // TODO: free the RFS data context
        }

        [Test]
        public void TestSingleWarehouseCalculationNullRfs()
        {
            var theCalculator = RfsFactory.GetRfsRevenueCalculator(_rfsDataContext, null);
            Assert.IsNotNull(theCalculator);

            // Relying on a receiver in the database without an RFS value; setting the value to null
            // explicitly, just in case.

            const int receiverId = 49738;
            var receiver = _rfsDataContext.GetReceiverById(receiverId);
            receiver.RfsRef = null;

            var doc1 = new WarehouseCalculationInputs
            {
                DocumentId = receiverId,
                DocumentType = WarehouseDocumentType.Received,
                DocumentDate = receiver.DateReceived.Value,
                ProductProfile = _rfsDataContext.GetProductProfileById(receiver.ProductProfileRef.Value),
                ReceiverDocument = receiver,
                ShipperDocument = null
            };

            var documents = new List<WarehouseCalculationInputs> {doc1};
            var returnValue = new RfsWarehouseRevenueCalculationResult();
            theCalculator.CalculateWarehouseRevenue(documents, returnValue);

            Assert.IsTrue(returnValue.ErrorCount == 0);
            Assert.IsTrue(returnValue.SkippedWithNullRfs == 1);
        }

        [Test]
        public void TestSingleWarehouseCalculationZeroRfs()
        {
            var theCalculator = RfsFactory.GetRfsRevenueCalculator(_rfsDataContext, null);
            Assert.IsNotNull(theCalculator);

            // Relying on a receiver in the database without an RFS value; setting the value to null
            // explicitly, just in case.

            const int receiverId = 49738;
            var receiver = _rfsDataContext.GetReceiverById(receiverId);
            receiver.RfsRef = 0;

            WarehouseCalculationInputs doc1 = new WarehouseCalculationInputs
            {
                DocumentId = receiverId,
                DocumentType = WarehouseDocumentType.Received,
                DocumentDate = receiver.DateReceived.Value,
                ProductProfile = _rfsDataContext.GetProductProfileById(receiver.ProductProfileRef.Value),
                RfsRef = 0,
                ReceiverDocument = receiver,
                ShipperDocument = null
            };

            var documents = new List<WarehouseCalculationInputs> {doc1};
            var returnValue = new RfsWarehouseRevenueCalculationResult();
            theCalculator.CalculateWarehouseRevenue(documents, returnValue);

            Assert.IsTrue(returnValue.ErrorCount == 0);
            Assert.IsTrue(returnValue.RevenueDeletedWithZeroRfs == 1);
        }

        [Test]
        public void TestSingleWarehouseCalculationRfs24()
        {
            var theCalculator = RfsFactory.GetRfsRevenueCalculator(_rfsDataContext, null);
            Assert.IsNotNull(theCalculator);

            // Relying on a receiver in the database without an RFS value; setting the value to null
            // explicitly, just in case.

            const int receiverId = 49727;
            var receiver = _rfsDataContext.GetReceiverById(receiverId);
            receiver.RfsRef = 24;

            var doc1 = new WarehouseCalculationInputs
            {
                DocumentId = receiverId,
                DocumentType = WarehouseDocumentType.Received,
                DocumentDate = receiver.DateReceived.Value,
                ProductProfile = _rfsDataContext.GetProductProfileById(receiver.ProductProfileRef.Value),
                RfsRef = 24,
                ReceiverDocument = receiver,
                ShipperDocument = null
            };

            var documents = new List<WarehouseCalculationInputs> {doc1};
            var returnValue = new RfsWarehouseRevenueCalculationResult();
            theCalculator.CalculateWarehouseRevenue(documents, returnValue);

            Assert.IsTrue(returnValue.ErrorCount == 0);
            Assert.IsTrue(returnValue.TotalReceivedCalculated == 1);
        }
    }
}
