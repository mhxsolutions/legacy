using System;
using BopsBusinessLogicFsc;
using NUnit.Framework;
using Scm.OpsCore.Legacy.DataLayer;

namespace BopsBusinessLogicFscTests
{
    [TestFixture]
    public class TestFscFloatIndexedDetailLookup
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
        public void TestFailureFromNoFuelPrice()
        {
            var fsc = _rfsDataContext.GetFuelSurchargeById(1);
            var lookup = new FscFloatIndexedDetailLookup(fsc, _rfsDataContext);
            var result = lookup.GetIndexedValue(new DateTime(2001, 1, 1));
            Assert.AreEqual(result.ResultCode, FscFloatIndexedDetailLookup.LookupResult.Code.FuelPriceUnavailable);
        }

        [Test]
        public void TestSuccessfulLookup()
        {
            const double expectedFsc = 0.124;

            var fsc = _rfsDataContext.GetFuelSurchargeById(1);
            var lookup = new FscFloatIndexedDetailLookup(fsc, _rfsDataContext);
            var result = lookup.GetIndexedValue(new DateTime(2007, 1, 1));
            Assert.AreEqual(result.ResultCode, FscFloatIndexedDetailLookup.LookupResult.Code.Success);
            Assert.AreEqual(expectedFsc, Math.Round(result.FuelSurcharge, 3));
        }
    }
}
