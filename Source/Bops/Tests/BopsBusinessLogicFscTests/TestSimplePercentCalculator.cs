using System.Text;
using BopsBusinessLogicFsc;
using BopsDataAccess;
using NUnit.Framework;

namespace BopsBusinessLogicFscTests
{
    [TestFixture]
    public class TestSimplePercentCalculator
    {
        [Test]
        public void TestDefaultPercentage()
        {
            const double expectedDefaultPercentage = 0.1;
            var calculator = new FscSimplePercentCalculator();
            Assert.AreEqual(expectedDefaultPercentage, calculator.FscPercentage);
        }

        [Test]
        public void TestSpecifiedPercentage()
        {
            const double expectedPercentage = 0.5;
            var calculator = new FscSimplePercentCalculator(expectedPercentage);
            Assert.AreEqual(expectedPercentage, calculator.FscPercentage);
        }

        [Test]
        public void TestSimpleCalculation()
        {
            const double fscPercentage = 0.25;
            const double revenueAmount = 100.0;

            var sb = new StringBuilder();
            var calculator = new FscSimplePercentCalculator(fscPercentage);
            var result = calculator.CalculateFsc(null, null, revenueAmount, sb);

            // Make sure the calculation worked and that the amount is correct.

            Assert.AreEqual(result.ResultCode, FscCalculationResultType.Success);
            Assert.AreEqual(fscPercentage * revenueAmount, result.FscAmount);
        }
    }
}
