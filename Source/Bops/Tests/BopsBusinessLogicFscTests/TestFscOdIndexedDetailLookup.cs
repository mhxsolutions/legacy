using BopsBusinessLogicFsc;
using BopsDataAccess;
using NUnit.Framework;
using Scm.OpsCore.Legacy.DataLayer;

namespace BopsBusinessLogicFscTests
{
    [TestFixture]
    public class TestFscOdIndexedDetailLookup
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
        public void TestFailureFromNoMatch()
        {
            var load = new BopsLoad
            {
                OriginRef = 21,
                DeliveryLocationRef = 22
            };

            var fsc = _rfsDataContext.GetFuelSurchargeById(3);
            var lookup = new FscOdIndexedDetailLookup(fsc, _rfsDataContext);
            var result = lookup.GetOdSurcharge(load);
            Assert.AreEqual(result.ResultCode, FscOdIndexedDetailLookup.LookupResult.Code.NoMatch);
        }
    }
}
