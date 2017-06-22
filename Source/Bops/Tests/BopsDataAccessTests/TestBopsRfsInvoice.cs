using System;
using BopsDataAccess;
using NUnit.Framework;

namespace BopsDataAccessTests
{
    [TestFixture]
    public class TestBopsRfsInvoice
    {
        [Test]
        public void TestInvoiceAmountRounding()
        {
            const double TestAmount = 12.34567;
            BopsRfsInvoice Invoice = new BopsRfsInvoice();
            Invoice.InvoiceTotal = TestAmount;
            Assert.AreEqual(Math.Round(TestAmount, 2), Invoice.InvoiceTotal);
        }
    }
}
