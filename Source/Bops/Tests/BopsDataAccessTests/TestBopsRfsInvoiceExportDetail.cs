using System;
using BopsDataAccess;
using NUnit.Framework;

namespace BopsDataAccessTests
{
    [TestFixture]
    public class TestBopsRfsInvoiceExportDetail
    {
        [Test]
        public void TestInvoiceDetailAmountRounding()
        {
            const double TestAmount = 12.34567;
            BopsRfsInvoiceExportDetail Detail = new BopsRfsInvoiceExportDetail();
            Detail.DetailAmount = TestAmount;
            Assert.AreEqual(Math.Round(TestAmount, 2), Detail.DetailAmount);
        }
    }
}
