using System;
using BopsDataAccess;
using NUnit.Framework;

namespace BopsDataAccessTests
{
    [TestFixture]
    public class TestBopsRfsServiceCalculationResult
    {
        const double _TestAmount = 12.34567;

        [Test]
        public void TestRfsRevenueRounding()
        {
            BopsRfsServiceCalculationResult Result = new BopsRfsServiceCalculationResult();
            Result.PublicRate.RfsRevenue = _TestAmount;
            Assert.AreEqual(Math.Round(_TestAmount, 2), Result.PublicRate.RfsRevenue);
        }

        [Test]
        public void TestFscRevenueRounding()
        {
            BopsRfsServiceCalculationResult Result = new BopsRfsServiceCalculationResult();
            Result.PublicRate.FscRevenue = _TestAmount;
            Assert.AreEqual(Math.Round(_TestAmount, 2), Result.PublicRate.FscRevenue);
        }
    }
}
