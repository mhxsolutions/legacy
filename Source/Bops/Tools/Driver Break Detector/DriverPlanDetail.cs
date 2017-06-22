using System;

namespace Driver_Break_Detector
{
    public class DriverPlanDetail
    {
        private int _DriverId;
        private string _FirstName;
        private string _LastName;
        private int _PlanId;
        private DateTime _PlanDate;
        private DateTime? _StartTime;
        private DateTime? _PayrollStart;
        private DateTime? _EndTime;

        public int DriverId
        {
            get { return _DriverId; }
            set { _DriverId = value; }
        }

        public string FirstName
        {
            get { return _FirstName; }
            set { _FirstName = value; }
        }

        public string LastName
        {
            get { return _LastName; }
            set { _LastName = value; }
        }

        public int PlanId
        {
            get { return _PlanId; }
            set { _PlanId = value; }
        }

        public DateTime PlanDate
        {
            get { return _PlanDate; }
            set { _PlanDate = value; }
        }

        public DateTime? StartTime
        {
            get { return _StartTime; }
            set { _StartTime = value; }
        }

        public DateTime? PayrollStart
        {
            get { return _PayrollStart; }
            set { _PayrollStart = value; }
        }

        public DateTime? EndTime
        {
            get { return _EndTime; }
            set { _EndTime = value; }
        }
    }
}
