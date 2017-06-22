using System;
using System.Collections.Generic;
using BopsDataAccess;

namespace BopsBusinessLogicRfs
{
    public class RfsStorageBillingPlanner
    {
        public class BillingSegment
        {
            private int _AssignmentId;
            private int _RateId;
            private double _Cycles;
            private int _BillingDays;
            private int _CycleDays;
            private DateTime _BeginDate;
            private DateTime _EndDate;
            private double _Quantity;
            private double _Rate;
            private double _Revenue;
            private string _QuantityString;
            private string _UnitString;

            public int AssignmentId
            {
                get { return _AssignmentId; }
                set { _AssignmentId = value; }
            }

            public int RateId
            {
                get { return _RateId; }
                set { _RateId = value; }
            }

            public double Cycles
            {
                get { return _Cycles; }
                set { _Cycles = value; }
            }

            public int BillingDays
            {
                get { return _BillingDays; }
                set { _BillingDays = value; }
            }

            public int CycleDays
            {
                get { return _CycleDays; }
                set { _CycleDays = value; }
            }

            public DateTime BeginDate
            {
                get { return _BeginDate; }
                set { _BeginDate = value; }
            }

            public DateTime EndDate
            {
                get { return _EndDate; }
                set { _EndDate = value; }
            }

            public double Quantity
            {
                get { return _Quantity; }
                set { _Quantity = value; }
            }

            public double Rate
            {
                get { return _Rate; }
                set { _Rate = value; }
            }

            public double Revenue
            {
                get { return _Revenue; }
                set { _Revenue = value; }
            }

            public string QuantityString
            {
                get { return _QuantityString; }
                set { _QuantityString = value; }
            }

            public string UnitString
            {
                get { return _UnitString; }
                set { _UnitString = value; }
            }

            public string SingleResultString
            {
                get
                {
                    return string.Format(" for {0:n3} {1} at {2:c}/{3}.", _Quantity, _QuantityString, _Rate, _UnitString);
                }
            }
        }

        private readonly double _TotalCycles;
        private readonly int _TotalBillingDays;
        private readonly int _TotalCycleDays;
        private readonly List<BillingSegment> _Segments;

        public RfsStorageBillingPlanner(DateTime DateBilledThrough, DateTime TargetDate, IEnumerable<BopsRfsStorageRateAssignment> Assignments,
            IDictionary<int, BopsRfsStorageRate> RateMap)
        {
            bool Done = false;
            _Segments = new List<BillingSegment>();
            _TotalCycles = 0;
            _TotalBillingDays = 0;
            _TotalCycleDays = 0;
            DateTime StartDate = DateBilledThrough;
            
            do
            {
                RfsStorageRateSegmentPlanner Plan = new RfsStorageRateSegmentPlanner(StartDate, TargetDate, Assignments);
                BillingSegment NewSegment = new BillingSegment();
                NewSegment.AssignmentId = Plan.Segments[0].Assignment.AssignmentId;
                NewSegment.BeginDate = Plan.Segments[0].BeginDate;
                NewSegment.EndDate = Plan.Segments[0].EndDate;
                NewSegment.RateId = Plan.Segments[0].Assignment.StorageRateRef;
                NewSegment.BillingDays = (NewSegment.EndDate - NewSegment.BeginDate).Days;

                BopsRfsStorageRate Rate = RateMap[NewSegment.RateId];
                double PreciseCycles = NewSegment.BillingDays / (double)Rate.DaysInCycle;

                // In the event that we have a single segment, it means we're not crossing a rate boundary.
                // As such, we round up the precise cycle count to arrive at a number of cycles to bill
                // and then calculate the corresponding number of cycle days.
                //
                // Otherwise, we must have crossed a boundary, in which case we set the cycle days to the
                // number of billing days. When all is said and done, the total cycle days will be used
                // to calculate a new dated billed through.

                if (Plan.Segments.Count == 1)
                {
                    NewSegment.Cycles = Math.Ceiling(PreciseCycles);
                    NewSegment.CycleDays = (int)NewSegment.Cycles * Rate.DaysInCycle;
                    Done = true;
                }
                else
                {
                    NewSegment.Cycles = PreciseCycles;
                    NewSegment.CycleDays = NewSegment.BillingDays;
                }

                StartDate = NewSegment.EndDate;
                _TotalCycles += NewSegment.Cycles;
                _TotalBillingDays += NewSegment.BillingDays;
                _TotalCycleDays += NewSegment.CycleDays;

                _Segments.Add(NewSegment);

            } while (!Done);
        }

        public double TotalCycles
        {
            get { return _TotalCycles; }
        }

        public int TotalBillingDays
        {
            get { return _TotalBillingDays; }
        }

        public int TotalCycleDays
        {
            get { return _TotalCycleDays; }
        }

        public List<BillingSegment> Segments
        {
            get { return _Segments; }
        }
    }
}
