using System;
using System.Text;
using BopsBusinessLogicFsc;
using BopsDataAccess;
using NUnit.Framework;
using Scm.OpsCore.Legacy.DataLayer;

namespace BopsBusinessLogicFscTests
{
    [TestFixture]
    public class TestFscCalculator
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
        public void TestFailureFromInvalidFsc()
        {
            var sb = new StringBuilder();
            var calculator = new FscCalculator(_rfsDataContext);
            var service = new BopsRfsServicesRequested {PrivateRate = {FscMatrixRef = 999999}};
            var result = calculator.CalculateFsc(null, service.PrivateRate, 0, sb);
            Assert.AreEqual(FscCalculationResultType.InvalidFscId, result.ResultCode);
        }

        [Test]
        public void TestFailureFromInvalidLogoutDate()
        {
            var sb = new StringBuilder();
            var load = new BopsLoad();
            var calculator = new FscCalculator(_rfsDataContext);
            var service = new BopsRfsServicesRequested {PrivateRate = {FscMatrixRef = 1}};
            var result = calculator.CalculateFsc(load, service.PrivateRate, 0, sb);
            Assert.AreEqual(FscCalculationResultType.InvalidLogoutDate, result.ResultCode);
        }

        [Test]
        public void TestFailureFromNoFuelPrice()
        {
            var sb = new StringBuilder();
            var load = new BopsLoad {LogOutDate = new DateTime(2001, 1, 1)};
            var service = new BopsRfsServicesRequested {PrivateRate = {FscMatrixRef = 1}};
            var calculator = new FscCalculator(_rfsDataContext);
            var result = calculator.CalculateFsc(load, service.PrivateRate, 200, sb);
            Assert.AreEqual(FscCalculationResultType.FloatLookupFuelPriceUnavailable, result.ResultCode);
        }

        [Test]
        public void TestSuccessfulFloatLookup()
        {
            const double expectedFsc = 24.8;

            var sb = new StringBuilder();
            var load = new BopsLoad {LogOutDate = new DateTime(2007, 1, 1), OriginRef = 1, DeliveryLocationRef = 4};
            var service = new BopsRfsServicesRequested {PrivateRate = {FscMatrixRef = 1}};

            var calculator = new FscCalculator(_rfsDataContext);
            var result = calculator.CalculateFsc(load, service.PrivateRate, 200, sb);
            Assert.AreEqual(FscCalculationResultType.Success, result.ResultCode);
            Assert.AreEqual(expectedFsc, Math.Round(result.FscAmount, 3));
        }

        [Test]
        public void TestSuccessfulCentsPerMileLookup()
        {
            const double expectedFsc = 12.6;

            var sb = new StringBuilder();
            var load = new BopsLoad {LogOutDate = new DateTime(2007, 1, 1)};
            var service = new BopsRfsServicesRequested {PrivateRate = {Mileage = 45.0, FscMatrixRef = 2}};

            var calculator = new FscCalculator(_rfsDataContext);
            var result = calculator.CalculateFsc(load, service.PrivateRate, 0, sb);
            Assert.AreEqual(FscCalculationResultType.Success, result.ResultCode);
            Assert.AreEqual(expectedFsc, Math.Round(result.FscAmount, 3));
        }
    }
}
