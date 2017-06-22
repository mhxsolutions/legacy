using System;
using BopsDataAccess;
using NUnit.Framework;

namespace BopsDataAccessTests
{
    [TestFixture]
    public class TestBopsRfsInvoiceDetail
    {
        [Test]
        public void TestInvoiceDetailAmountRounding()
        {
            const double TestAmount = 12.34567;
            BopsRfsInvoiceDetail Detail = new BopsRfsInvoiceDetail();
            Detail.ItemTotal = TestAmount;
            Assert.AreEqual(Math.Round(TestAmount, 2), Detail.ItemTotal);
        }
    }
}
