using System;
using System.Collections.Generic;

namespace Driver_Break_Detector
{
    public class DateDriverResults
    {
        private DateTime _PlanDate;
        private List<DriverBreaks> _DriverResults;

        public DateTime PlanDate
        {
            get { return _PlanDate; }
            set { _PlanDate = value; }
        }

        public List<DriverBreaks> DriverResults
        {
            get { return _DriverResults; }
            set { _DriverResults = value; }
        }

        public DateDriverResults(DateTime PlanDate)
        {
            _PlanDate = PlanDate;
            _DriverResults = new List<DriverBreaks>();
        }

        public DriverBreaks GetDriverResult(int DriverId)
        {
            foreach (DriverBreaks Result in _DriverResults)
            {
                if (Result.Driver.Id == DriverId)
                    return Result;
            }

            return null;
        }

        public override string ToString()
        {
            return string.Format("{0}, {1} driver results", _PlanDate.ToShortDateString(), _DriverResults.Count);
        }
    }
}
