using System;
using BopsDataAccess;
using NUnit.Framework;

namespace BopsDataAccessTests
{
    [TestFixture]
    public class TestBopsRfsInvoiceExport
    {
        [Test]
        public void TestInvoiceTotalRounding()
        {
            const double TestAmount = 12.34567;
            BopsRfsInvoiceExport Export = new BopsRfsInvoiceExport();
            Export.TotalRevenue = TestAmount;
            Assert.AreEqual(Math.Round(TestAmount, 2), Export.TotalRevenue);
        }
    }
}
