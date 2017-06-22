using System;

namespace Driver_Break_Detector
{
    public class BreakDetails
    {
        private bool _PossibleLunch;
        private int _BeginIndex;
        private int _EndIndex;
        private DriverLocation _BeginLocation;
        private DriverLocation _EndLocation;
        private TargetLocation _CustomLocation;

        public bool PossibleLunch
        {
            get { return _PossibleLunch; }
            set { _PossibleLunch = value; }
        }

        public int BeginIndex
        {
            get { return _BeginIndex; }
            set { _BeginIndex = value; }
        }

        public int EndIndex
        {
            get { return _EndIndex; }
            set { _EndIndex = value; }
        }

        public DriverLocation BeginLocation
        {
            get { return _BeginLocation; }
            set { _BeginLocation = value; }
        }

        public DriverLocation EndLocation
        {
            get { return _EndLocation; }
            set { _EndLocation = value; }
        }

        public TargetLocation CustomLocation
        {
            get { return _CustomLocation; }
            set { _CustomLocation = value; }
        }

        public BreakDetails(int BeginIndex, DriverLocation BeginLocation, int EndIndex, DriverLocation EndLocation, bool PossibleLunch)
        {
            _BeginIndex = BeginIndex;
            _EndIndex = EndIndex;
            _PossibleLunch = PossibleLunch;
            _BeginLocation = BeginLocation;
            _EndLocation = EndLocation;
            _CustomLocation = null;
        }

        public override string ToString()
        {
            TimeSpan Interval = _EndLocation.Timestamp - _BeginLocation.Timestamp;
            return string.Format("Begin Index {0} at {1}, End Index {2} at {3}, {4}, Possible Lunch {5}",
                _BeginIndex, _BeginLocation.Timestamp.ToShortTimeString(), _EndIndex, _EndLocation.Timestamp.ToShortTimeString(), 
                Interval, _PossibleLunch);
        }
    }
}
