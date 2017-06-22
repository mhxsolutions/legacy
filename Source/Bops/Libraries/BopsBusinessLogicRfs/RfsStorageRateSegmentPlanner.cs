using System;
using System.Collections.Generic;
using BopsDataAccess;

namespace BopsBusinessLogicRfs
{
    /// <summary>
    /// A worker class that takes a begin/end date pair, along with a list of storage billing rate assignments,
    /// and produces a list of segments that cover the entire date range with the corresponding assignments.
    /// </summary>
    public class RfsStorageRateSegmentPlanner
    {
        public class Segment
        {
            private readonly DateTime _BeginDate;
            private readonly DateTime _EndDate;
            private readonly BopsRfsStorageRateAssignment _Assignment;

            public DateTime BeginDate
            {
                get { return _BeginDate; }
            }

            public DateTime EndDate
            {
                get { return _EndDate; }
            }

            public BopsRfsStorageRateAssignment Assignment
            {
                get { return _Assignment; }
            }

            public Segment(DateTime BeginDate, DateTime EndDate, BopsRfsStorageRateAssignment Assignment)
            {
                _BeginDate = BeginDate;
                _EndDate = EndDate;
                _Assignment = Assignment;
            }
        }

        private readonly List<Segment> _Segments;

        //[Conditional("DEBUG")] 
        private static void ValidateAssignments(IEnumerable<BopsRfsStorageRateAssignment> Assignments)
        {
            if (Assignments == null)
                throw new ArgumentNullException("Assignments");

            BopsRfsStorageRateAssignment LastAssignment = null;

            foreach (BopsRfsStorageRateAssignment Assignment in Assignments)
            {
                if (Assignment.EndDate <= Assignment.BeginDate)
                    throw new ArgumentOutOfRangeException("Assignments", "Assignment end date must be greater than begin date");

                if (LastAssignment != null)
                {
                    if (Assignment.BeginDate < LastAssignment.BeginDate)
                        throw new ArgumentOutOfRangeException("Assignments", "Assignments must be sorted ascending by begin date");
                    if (LastAssignment.EndDate < Assignment.BeginDate)
                        throw new ArgumentOutOfRangeException("Assignments", "Assignments cannot contain gaps");
                }

                LastAssignment = Assignment;
            }
        }

        //[Conditional("DEBUG")] 
        private static void ValidateDates(DateTime BeginDate, DateTime EndDate)
        {
            if (BeginDate >= EndDate)
                throw new ArgumentOutOfRangeException("EndDate", "BeginDate must be less than EndDate");
        }

        private enum SegmentPlanningState
        {
            SeekingBegin,
            SeekingEnd
        }

        /// <summary>
        /// Default constructor.
        /// </summary>
        /// <param name="BeginDate">The begin date for the interval to be covered by assignments.</param>
        /// <param name="EndDate">The end date for the interval to be covered by assignments.</param>
        /// <param name="Assignments">The list of assignments to be used in covering the interval.</param>
        public RfsStorageRateSegmentPlanner(DateTime BeginDate, DateTime EndDate, IEnumerable<BopsRfsStorageRateAssignment> Assignments)
        {
            ValidateDates(BeginDate, EndDate);
            ValidateAssignments(Assignments);
            _Segments = new List<Segment>();

            DateTime SegmentBegin = BeginDate;
            SegmentPlanningState CurrentState = SegmentPlanningState.SeekingBegin;

            foreach (BopsRfsStorageRateAssignment Assignment in Assignments)
            {
                if (CurrentState == SegmentPlanningState.SeekingEnd)
                {
                    if (Assignment.ContainsOrEndsWithDate(EndDate))
                    {
                        Segment NewSegment = new Segment(SegmentBegin, EndDate, Assignment);
                        _Segments.Add(NewSegment);
                        return;
                    }
                    else
                    {
                        Segment NewSegment = new Segment(SegmentBegin, Assignment.EndDate, Assignment);
                        _Segments.Add(NewSegment);

                        SegmentBegin = NewSegment.EndDate;
                    }
                }

                if (CurrentState == SegmentPlanningState.SeekingBegin)
                {
                    if (Assignment.ContainsDate(SegmentBegin))
                    {
                        if (Assignment.ContainsOrEndsWithDate(EndDate))
                        {
                            Segment NewSegment = new Segment(SegmentBegin, EndDate, Assignment);
                            _Segments.Add(NewSegment);
                            return;
                        }
                        else
                        {
                            Segment NewSegment = new Segment(SegmentBegin, Assignment.EndDate, Assignment);
                            _Segments.Add(NewSegment);

                            SegmentBegin = NewSegment.EndDate;
                            CurrentState = SegmentPlanningState.SeekingEnd;
                        }
                    }
                }
            }

            throw new ArgumentOutOfRangeException("EndDate", "Incomplete segment plan");
        }

        /// <summary>
        /// The list of segments produced by the parameters passed to the constructor.
        /// </summary>
        public List<Segment> Segments
        {
            get { return _Segments; }
        }
    }
}
