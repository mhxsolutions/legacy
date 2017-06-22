using System;
using BopsBusinessLogicFsc;
using NUnit.Framework;

namespace BopsBusinessLogicFscTests
{
    [TestFixture]
    public class TestFscFactory
    {
        [Test]
        [ExpectedException(typeof(NullReferenceException))]
        public void TestCalculatorInstantiation()
        {
            IFscCalculator CalculatorInterface = FscFactory.GetFscCalculator(null);
            Assert.IsNotNull(CalculatorInterface);
        }
    }
}
