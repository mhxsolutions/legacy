using System;
using System.Collections.Generic;
using System.Diagnostics;
using BopsBusinessLogicRfs;
using BopsDataAccess;
using NUnit.Framework;

namespace BopsBusinessLogicRfsTests
{
    [TestFixture]
    public class TestRfsStorageRateSegmentPlanner
    {
        [Test]
        [ExpectedException(typeof(ArgumentOutOfRangeException))]
        public void TestInvalidDates()
        {
            DateTime RightNow = DateTime.Now;
            RfsStorageRateSegmentPlanner Planner = new RfsStorageRateSegmentPlanner(RightNow, RightNow, null);
            Debug.Assert(Planner != null);  // Useless line of code to keep Resharper happy.
            Assert.Fail("Segment planner accepted invalid data");
        }

        [Test]
        [ExpectedException(typeof(ArgumentNullException))]
        public void TestNullAssignments()
        {
            DateTime BeginDate = new DateTime(2009, 1, 1);
            DateTime EndDate = new DateTime(2010, 1, 1);
            RfsStorageRateSegmentPlanner Planner = new RfsStorageRateSegmentPlanner(BeginDate, EndDate, null);
            Debug.Assert(Planner != null);  // Useless line of code to keep Resharper happy.
            Assert.Fail("Segment planner accepted invalid data");
        }

        [Test]
        [ExpectedException(typeof(ArgumentOutOfRangeException))]
        public void TestIncorrectlySortedAssignmentDates()
        {
            DateTime RightNow = DateTime.Now;

            List<BopsRfsStorageRateAssignment> Assignments = new List<BopsRfsStorageRateAssignment>();
            BopsRfsStorageRateAssignment A1 = new BopsRfsStorageRateAssignment();
            A1.BeginDate = new DateTime(2009, 1, 1);
            A1.EndDate = new DateTime(2010, 1, 1);
            Assignments.Add(A1);
            Assignments.Add(A1);

            RfsStorageRateSegmentPlanner Planner = new RfsStorageRateSegmentPlanner(RightNow, RightNow, null);
            Debug.Assert(Planner != null);  // Useless line of code to keep Resharper happy.
            Assert.Fail("Segment planner accepted invalid data");
        }

        [Test]
        [ExpectedException(typeof(ArgumentOutOfRangeException))]
        public void TestGappedAssignmentDates()
        {
            List<BopsRfsStorageRateAssignment> Assignments = new List<BopsRfsStorageRateAssignment>();
            BopsRfsStorageRateAssignment A1 = new BopsRfsStorageRateAssignment();
            A1.BeginDate = new DateTime(2009, 1, 1);
            A1.EndDate = new DateTime(2010, 1, 1);
            Assignments.Add(A1);
            BopsRfsStorageRateAssignment A2 = new BopsRfsStorageRateAssignment();
            A2.BeginDate = new DateTime(2010, 3, 1);
            A2.EndDate = new DateTime(2011, 1, 1);
            Assignments.Add(A2);

            DateTime BeginDate = new DateTime(2009, 12, 1);
            DateTime EndDate = new DateTime(2010, 5, 1);
            RfsStorageRateSegmentPlanner Planner = new RfsStorageRateSegmentPlanner(BeginDate, EndDate, Assignments);

            Debug.Assert(Planner != null);  // Useless line of code to keep Resharper happy.
            Assert.Fail("Segment planner accepted invalid data");
        }

        [Test]
        public void TestOneSegmentPlan()
        {
            List<BopsRfsStorageRateAssignment> Assignments = new List<BopsRfsStorageRateAssignment>();
            BopsRfsStorageRateAssignment A1 = new BopsRfsStorageRateAssignment();
            A1.BeginDate = new DateTime(2009, 1, 1);
            A1.EndDate = new DateTime(2010, 1, 1);
            Assignments.Add(A1);
            BopsRfsStorageRateAssignment A2 = new BopsRfsStorageRateAssignment();
            A2.BeginDate = new DateTime(2010, 1, 1);
            A2.EndDate = new DateTime(2011, 1, 1);
            Assignments.Add(A2);

            DateTime BeginDate = new DateTime(2009, 2, 1);
            DateTime EndDate = new DateTime(2009, 3, 1);
            RfsStorageRateSegmentPlanner Planner = new RfsStorageRateSegmentPlanner(BeginDate, EndDate, Assignments);

            Assert.AreEqual(1, Planner.Segments.Count);

            RfsStorageRateSegmentPlanner.Segment S = Planner.Segments[0];
            Assert.AreSame(A1, S.Assignment);
        }

        [Test]
        public void TestTwoSegmentPlan()
        {
            List<BopsRfsStorageRateAssignment> Assignments = new List<BopsRfsStorageRateAssignment>();
            BopsRfsStorageRateAssignment A1 = new BopsRfsStorageRateAssignment();
            A1.Description = "Assignment #1";
            A1.BeginDate = new DateTime(2009, 1, 1);
            A1.EndDate = new DateTime(2010, 1, 1);
            Assignments.Add(A1);
            BopsRfsStorageRateAssignment A2 = new BopsRfsStorageRateAssignment();
            A2.Description = "Assignment #2";
            A2.BeginDate = new DateTime(2010, 1, 1);
            A2.EndDate = new DateTime(2011, 1, 1);
            Assignments.Add(A2);

            DateTime BeginDate = new DateTime(2009, 11, 1);
            DateTime EndDate = new DateTime(2010, 2, 1);
            RfsStorageRateSegmentPlanner Planner = new RfsStorageRateSegmentPlanner(BeginDate, EndDate, Assignments);

            Assert.AreEqual(2, Planner.Segments.Count);

            RfsStorageRateSegmentPlanner.Segment S1 = Planner.Segments[0];
            Assert.AreSame(A1, S1.Assignment);
            Assert.AreEqual(BeginDate, S1.BeginDate);
            Assert.AreEqual(A1.EndDate, S1.EndDate);
            RfsStorageRateSegmentPlanner.Segment S2 = Planner.Segments[1];
            Assert.AreSame(A2, S2.Assignment);
            Assert.AreEqual(A2.BeginDate, S2.BeginDate);
            Assert.AreEqual(EndDate, S2.EndDate);
        }

        [Test]
        public void TestThreeSegmentPlan()
        {
            List<BopsRfsStorageRateAssignment> Assignments = new List<BopsRfsStorageRateAssignment>();
            BopsRfsStorageRateAssignment A1 = new BopsRfsStorageRateAssignment();
            A1.Description = "Assignment #1";
            A1.BeginDate = new DateTime(2009, 1, 1);
            A1.EndDate = new DateTime(2010, 1, 1);
            Assignments.Add(A1);
            BopsRfsStorageRateAssignment A2 = new BopsRfsStorageRateAssignment();
            A2.Description = "Assignment #2";
            A2.BeginDate = new DateTime(2010, 1, 1);
            A2.EndDate = new DateTime(2011, 1, 1);
            Assignments.Add(A2);
            BopsRfsStorageRateAssignment A3 = new BopsRfsStorageRateAssignment();
            A3.Description = "Assignment #3";
            A3.BeginDate = new DateTime(2011, 1, 1);
            A3.EndDate = new DateTime(2012, 1, 1);
            Assignments.Add(A3);

            DateTime BeginDate = new DateTime(2009, 11, 1);
            DateTime EndDate = new DateTime(2011, 2, 1);
            RfsStorageRateSegmentPlanner Planner = new RfsStorageRateSegmentPlanner(BeginDate, EndDate, Assignments);

            Assert.AreEqual(3, Planner.Segments.Count);

            RfsStorageRateSegmentPlanner.Segment S1 = Planner.Segments[0];
            Assert.AreSame(A1, S1.Assignment);
            Assert.AreEqual(BeginDate, S1.BeginDate);
            Assert.AreEqual(A1.EndDate, S1.EndDate);
            RfsStorageRateSegmentPlanner.Segment S2 = Planner.Segments[1];
            Assert.AreSame(A2, S2.Assignment);
            Assert.AreEqual(A2.BeginDate, S2.BeginDate);
            Assert.AreEqual(A2.EndDate, S2.EndDate);
            RfsStorageRateSegmentPlanner.Segment S3 = Planner.Segments[2];
            Assert.AreSame(A3, S3.Assignment);
            Assert.AreEqual(A3.BeginDate, S3.BeginDate);
            Assert.AreEqual(EndDate, S3.EndDate);
        }

        [Test]
        public void TestPlanStartingOnAssignmentBegin()
        {
            List<BopsRfsStorageRateAssignment> Assignments = new List<BopsRfsStorageRateAssignment>();
            BopsRfsStorageRateAssignment A1 = new BopsRfsStorageRateAssignment();
            A1.Description = "Assignment #1";
            A1.BeginDate = new DateTime(2009, 1, 1);
            A1.EndDate = new DateTime(2010, 1, 1);
            Assignments.Add(A1);
            BopsRfsStorageRateAssignment A2 = new BopsRfsStorageRateAssignment();
            A2.Description = "Assignment #2";
            A2.BeginDate = new DateTime(2010, 1, 1);
            A2.EndDate = new DateTime(2011, 1, 1);
            Assignments.Add(A2);

            DateTime BeginDate = new DateTime(2010, 1, 1);
            DateTime EndDate = new DateTime(2010, 2, 1);
            RfsStorageRateSegmentPlanner Planner = new RfsStorageRateSegmentPlanner(BeginDate, EndDate, Assignments);

            Assert.AreEqual(1, Planner.Segments.Count);

            RfsStorageRateSegmentPlanner.Segment S1 = Planner.Segments[0];
            Assert.AreSame(A2, S1.Assignment);
            Assert.AreEqual(BeginDate, S1.BeginDate);
            Assert.AreEqual(EndDate, S1.EndDate);
        }

        [Test]
        public void TestPlanEndingOnAssignmentEnd()
        {
            List<BopsRfsStorageRateAssignment> Assignments = new List<BopsRfsStorageRateAssignment>();
            BopsRfsStorageRateAssignment A1 = new BopsRfsStorageRateAssignment();
            A1.Description = "Assignment #1";
            A1.BeginDate = new DateTime(2009, 1, 1);
            A1.EndDate = new DateTime(2010, 1, 1);
            Assignments.Add(A1);
            BopsRfsStorageRateAssignment A2 = new BopsRfsStorageRateAssignment();
            A2.Description = "Assignment #2";
            A2.BeginDate = new DateTime(2010, 1, 1);
            A2.EndDate = new DateTime(2011, 1, 1);
            Assignments.Add(A2);

            DateTime BeginDate = new DateTime(2009, 12, 1);
            DateTime EndDate = new DateTime(2010, 1, 1);
            RfsStorageRateSegmentPlanner Planner = new RfsStorageRateSegmentPlanner(BeginDate, EndDate, Assignments);

            Assert.AreEqual(1, Planner.Segments.Count);

            RfsStorageRateSegmentPlanner.Segment S1 = Planner.Segments[0];
            Assert.AreSame(A1, S1.Assignment);
            Assert.AreEqual(BeginDate, S1.BeginDate);
            Assert.AreEqual(A1.EndDate, S1.EndDate);
        }

        [Test]
        public void TestPlanMatchingAssignment()
        {
            List<BopsRfsStorageRateAssignment> Assignments = new List<BopsRfsStorageRateAssignment>();
            BopsRfsStorageRateAssignment A1 = new BopsRfsStorageRateAssignment();
            A1.Description = "Assignment #1";
            A1.BeginDate = new DateTime(2009, 1, 1);
            A1.EndDate = new DateTime(2010, 1, 1);
            Assignments.Add(A1);
            BopsRfsStorageRateAssignment A2 = new BopsRfsStorageRateAssignment();
            A2.Description = "Assignment #2";
            A2.BeginDate = new DateTime(2010, 1, 1);
            A2.EndDate = new DateTime(2011, 1, 1);
            Assignments.Add(A2);

            DateTime BeginDate = new DateTime(2009, 1, 1);
            DateTime EndDate = new DateTime(2010, 1, 1);
            RfsStorageRateSegmentPlanner Planner = new RfsStorageRateSegmentPlanner(BeginDate, EndDate, Assignments);

            Assert.AreEqual(1, Planner.Segments.Count);

            RfsStorageRateSegmentPlanner.Segment S1 = Planner.Segments[0];
            Assert.AreSame(A1, S1.Assignment);
            Assert.AreEqual(A1.BeginDate, S1.BeginDate);
            Assert.AreEqual(A1.EndDate, S1.EndDate);
        }
    }
}
