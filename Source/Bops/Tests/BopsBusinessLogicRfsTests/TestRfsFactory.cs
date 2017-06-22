using BopsBusinessLogicRfs;
using NUnit.Framework;

namespace BopsBusinessLogicRfsTests
{
    [TestFixture]
    public class TestRfsFactory
    {
        /// <summary>
        /// This test exercises calculator creation and makes sure the underlying type name is as expected.
        /// In the event that future development changes the underlying class, this test will fail as a 
        /// reminder to check anything that might need updating.
        /// </summary>
        [Test]
        public void TestGetRevenueCalculator()
        {
            var calc = RfsFactory.GetRfsRevenueCalculator(null, null);
            Assert.IsNotNull(calc);
            var typeName = calc.GetType().Name;
            Assert.AreEqual(typeName, "RfsRevenueCalculator");
        }

        [Test]
        public void TestGetRfsEstimatedServiceThroughputCalculator()
        {
            var calc = RfsFactory.GetRfsEstimatedServiceThroughputCalculator(null);
            Assert.IsNotNull(calc);
            Assert.AreEqual(typeof(RfsEstimatedServiceThroughputCalculator), calc.GetType());
        }
    }
}
