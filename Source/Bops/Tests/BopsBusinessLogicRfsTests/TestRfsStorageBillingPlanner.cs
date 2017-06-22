using System;
using System.Collections.Generic;
using BopsBusinessLogicRfs;
using BopsDataAccess;
using NUnit.Framework;

namespace BopsBusinessLogicRfsTests
{
    [TestFixture]
    public class TestRfsStorageBillingPlanner
    {
        [Test]
        public void TestSingleSegmentPlan()
        {
            BopsRfsStorageRate Rate1 = new BopsRfsStorageRate();
            Rate1.RateId = 1;
            Rate1.BillToClientRef = 100;
            Rate1.BillingType = RfsStorageBillingType.PerWeightUnit;
            Rate1.DaysInCycle = 30;
            Rate1.UnitCostPerCycle = 2.75;
            Rate1.UnitRef = 4;  // I think maybe that's pounds?
            Rate1.Description = "Test Rate 1";
            Dictionary<int, BopsRfsStorageRate> RateMap = new Dictionary<int, BopsRfsStorageRate>();
            RateMap.Add(1, Rate1);

            List<BopsRfsStorageRateAssignment> Assignments = new List<BopsRfsStorageRateAssignment>();
            BopsRfsStorageRateAssignment Ass1 = new BopsRfsStorageRateAssignment();
            Ass1.AssignmentId = 5;
            Ass1.StorageRateRef = 1;
            Ass1.ProfileRef = 10;
            Ass1.BeginDate = new DateTime(2010, 1, 1);
            Ass1.EndDate = new DateTime(2011, 1, 1);
            Ass1.Description = "Test Assignment 1";
            Assignments.Add(Ass1);

            DateTime DateBilledThrough = new DateTime(2010, 4, 1);
            DateTime TargetDate = DateBilledThrough.AddDays(20);
            RfsStorageBillingPlanner Planner = new RfsStorageBillingPlanner(DateBilledThrough, TargetDate, Assignments, RateMap);

            Assert.AreEqual(1, Planner.Segments.Count);
            Assert.AreEqual(20, Planner.TotalBillingDays);
            Assert.AreEqual(30, Planner.TotalCycleDays);
        }

        [Test]
        public void TestDualSegmentPlan()
        {
            BopsRfsStorageRate Rate1 = new BopsRfsStorageRate();
            Rate1.RateId = 1;
            Rate1.BillToClientRef = 100;
            Rate1.BillingType = RfsStorageBillingType.PerWeightUnit;
            Rate1.DaysInCycle = 10;
            Rate1.UnitCostPerCycle = 2.75;
            Rate1.UnitRef = 4;  // I think maybe that's pounds?
            Rate1.Description = "Test Rate 1";

            BopsRfsStorageRate Rate2 = new BopsRfsStorageRate();
            Rate2.RateId = 2;
            Rate2.BillToClientRef = 100;
            Rate2.BillingType = RfsStorageBillingType.PerWeightUnit;
            Rate2.DaysInCycle = 30;
            Rate2.UnitCostPerCycle = 8.99;
            Rate2.UnitRef = 4;  // I think maybe that's pounds?
            Rate2.Description = "Test Rate 2";
            
            Dictionary<int, BopsRfsStorageRate> RateMap = new Dictionary<int, BopsRfsStorageRate>();
            RateMap.Add(Rate1.RateId, Rate1);
            RateMap.Add(Rate2.RateId, Rate2);

            List<BopsRfsStorageRateAssignment> Assignments = new List<BopsRfsStorageRateAssignment>();
            BopsRfsStorageRateAssignment Ass1 = new BopsRfsStorageRateAssignment();
            Ass1.AssignmentId = 5;
            Ass1.StorageRateRef = 1;
            Ass1.ProfileRef = 10;
            Ass1.BeginDate = new DateTime(2010, 1, 1);
            Ass1.EndDate = new DateTime(2011, 1, 1);
            Ass1.Description = "Test Assignment 1";
            Assignments.Add(Ass1);

            BopsRfsStorageRateAssignment Ass2 = new BopsRfsStorageRateAssignment();
            Ass2.AssignmentId = 6;
            Ass2.StorageRateRef = 2;
            Ass2.ProfileRef = 10;
            Ass2.BeginDate = new DateTime(2011, 1, 1);
            Ass2.EndDate = new DateTime(2012, 1, 1);
            Ass2.Description = "Test Assignment 2";
            Assignments.Add(Ass2);

            DateTime DateBilledThrough = new DateTime(2010, 12, 25);
            DateTime TargetDate = DateBilledThrough.AddDays(20);
            RfsStorageBillingPlanner Planner = new RfsStorageBillingPlanner(DateBilledThrough, TargetDate, Assignments, RateMap);

            Assert.AreEqual(2, Planner.Segments.Count);
            Assert.AreEqual(20, Planner.TotalBillingDays);
            Assert.AreEqual(37, Planner.TotalCycleDays);

            Assert.AreEqual(7, Planner.Segments[0].BillingDays);
            Assert.AreEqual(0.7, Planner.Segments[0].Cycles);
            Assert.AreEqual(13, Planner.Segments[1].BillingDays);
            Assert.AreEqual(1, Planner.Segments[1].Cycles);
        }
    }
}
