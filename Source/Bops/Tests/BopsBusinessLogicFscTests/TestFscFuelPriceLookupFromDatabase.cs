using System;
using BopsBusinessLogicFsc;
using NUnit.Framework;
using Scm.OpsCore.Legacy.DataLayer;

namespace BopsBusinessLogicFscTests
{
    [TestFixture]
    public class TestFscFuelPriceLookupFromDatabase
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
        public void TestLookup()
        {
            var lookup = new FscFuelPriceLookup(_rfsDataContext);
            var priceData = lookup.GetFuelPriceHistory(new DateTime(2007, 1, 3));
            Assert.AreEqual(priceData.FuelPrice, 2.8830);
        }
    }
}
