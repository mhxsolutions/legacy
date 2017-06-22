using System;
using System.Collections.Generic;

namespace Driver_Break_Detector
{
    [FlagsAttribute]
    public enum DriverBreakDetectError
    {
        None = 0x0,
        NullStartTime = 0x1,
        NullEndTime = 0x2,
        NoLocations = 0x4,
        NotEnoughLocations = 0x8,
        NotEnoughLocationsDuringWorkDay = 0x10
    }

    public class DriverBreaks
    {
        private DriverLocationDataQualityMetrics _LocationQualityMetrics;
        private DriverBreakDetectError _Error;
        private DriverDetails _Driver;
        private DriverLocation[] _Locations;
        private List<BreakDetails> _Breaks;
        private DriverPlanDetail _PlanDetail;
        private int _LocationsExamined;

        public DriverLocationDataQualityMetrics LocationQualityMetrics
        {
            get { return _LocationQualityMetrics; }
        }

        public DriverBreakDetectError Error
        {
            get { return _Error; }
            set { _Error = value; }
        }

        public DriverDetails Driver
        {
            get { return _Driver; }
            set { _Driver = value; }
        }

        public DriverLocation[] Locations
        {
            get { return _Locations; }
            set
            {
                _Locations = value;
                _LocationQualityMetrics = new DriverLocationDataQualityMetrics(_Locations);
            }
        }

        public List<BreakDetails> Breaks
        {
            get { return _Breaks; }
            set { _Breaks = value; }
        }

        public DriverPlanDetail PlanDetail
        {
            get { return _PlanDetail; }
            set { _PlanDetail = value; }
        }

        public int LocationsExamined
        {
            get { return _LocationsExamined; }
            set { _LocationsExamined = value; }
        }

        public DriverBreaks(DriverDetails Driver, DriverPlanDetail PlanDetail)
        {
            _Driver = Driver;
            _PlanDetail = PlanDetail;
            _Breaks = new List<BreakDetails>();
        }

        public override string ToString()
        {
            return string.Format("{0}, {1}, {2} breaks", _PlanDetail.PlanDate.ToShortDateString(), _Driver.FullName, _Breaks.Count);
        }
    }
}
