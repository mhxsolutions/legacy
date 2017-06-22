using System;
using System.Collections.Generic;
using BopsBusinessLogicFsc;
using BopsDataAccess;
using NUnit.Framework;

namespace BopsBusinessLogicFscTests
{
    [TestFixture]
    public class TestFscFuelPriceLookup
    {
        private List<BopsFscFuelPriceHistory> CreateTestData()
        {
            List<BopsFscFuelPriceHistory> History = new List<BopsFscFuelPriceHistory>();

            BopsFscFuelPriceHistory H1 = new BopsFscFuelPriceHistory();
            H1.FuelPriceId = 1;
            H1.BeginDate = new DateTime(2007, 1, 1);
            H1.EndDate = H1.BeginDate.AddDays(7);
            H1.FuelPrice = 1.1;
            History.Add(H1);

            BopsFscFuelPriceHistory H2 = new BopsFscFuelPriceHistory();
            H2.FuelPriceId = 2;
            H2.BeginDate = H1.EndDate.Value;
            H2.EndDate = H2.BeginDate.AddDays(7);
            H2.FuelPrice = 2.2;
            History.Add(H2);

            BopsFscFuelPriceHistory H3 = new BopsFscFuelPriceHistory();
            H3.FuelPriceId = 3;
            H3.BeginDate = H2.EndDate.Value;
            H3.FuelPrice = 3.3;
            History.Add(H3);

            return History;
        }

        [Test]
        public void TestFailureBeforeData()
        {
            FscFuelPriceLookup Lookup = new FscFuelPriceLookup(CreateTestData());
            BopsFscFuelPriceHistory PriceData = Lookup.GetFuelPriceHistory(new DateTime(2001, 1, 1));
            Assert.IsNull(PriceData);
        }

        [Test]
        public void TestLeftBoundaryMatch()
        {
            FscFuelPriceLookup Lookup = new FscFuelPriceLookup(CreateTestData());
            BopsFscFuelPriceHistory PriceData = Lookup.GetFuelPriceHistory(new DateTime(2007, 1, 1));
            Assert.AreEqual(PriceData.FuelPrice, 1.1);
        }

        [Test]
        public void TestBetweenMatch()
        {
            FscFuelPriceLookup Lookup = new FscFuelPriceLookup(CreateTestData());
            BopsFscFuelPriceHistory PriceData = Lookup.GetFuelPriceHistory(new DateTime(2007, 1, 10));
            Assert.AreEqual(PriceData.FuelPrice, 2.2);
        }

        [Test]
        public void TestRightBoundaryMatch()
        {
            FscFuelPriceLookup Lookup = new FscFuelPriceLookup(CreateTestData());
            BopsFscFuelPriceHistory PriceData = Lookup.GetFuelPriceHistory(new DateTime(2007, 1, 1).AddDays(7));
            Assert.AreEqual(PriceData.FuelPrice, 2.2);
        }

        [Test]
        public void TestSuccessAfterData()
        {
            FscFuelPriceLookup Lookup = new FscFuelPriceLookup(CreateTestData());
            BopsFscFuelPriceHistory PriceData = Lookup.GetFuelPriceHistory(new DateTime(2008, 1, 1));
            Assert.AreEqual(PriceData.FuelPrice, 3.3);
        }
    }
}
