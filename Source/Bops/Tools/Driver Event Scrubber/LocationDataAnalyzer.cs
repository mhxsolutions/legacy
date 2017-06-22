using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;
using AgilisCore;
using BopsUtilities;

namespace Driver_Event_Scrubber
{
    public class LocationDataAnalyzer
    {
        #region Helper Classes
        private class DriverPositionComparer : IComparer<AgilisDriverPosition>
        {
            public int Compare(AgilisDriverPosition Left, AgilisDriverPosition Right)
            {
                if (Left.Timestamp < Right.Timestamp)
                    return -1;
                if (Left.Timestamp > Right.Timestamp)
                    return 1;
                return 0;
            }
        }
        #endregion

        // Analysis control fields

        private TimeSpan _ExpectedInterval;
        private TimeSpan _MaximumIntervalDelta;
        // TODO: come up with some kind of maximum distance difference?

        // Result fields

        private int _TotalDataPoints;
        private int _PotentialDataHoles;
        private int _ShorterIntervals;
        private int _LongerIntervals;
        private DateTime _BeginTime;
        private DateTime _EndTime;
        private TimeSpan _MinimumInterval;
        private TimeSpan _MaximumInterval;
        private TimeSpan _AverageInterval;
        private double _MinimumDistance;
        private double _MaximumDistance;
        private double _AverageDistance;

        #region Fields
        public TimeSpan ExpectedInterval
        {
            get { return _ExpectedInterval; }
            set { _ExpectedInterval = value; }
        }

        public TimeSpan MaximumIntervalDelta
        {
            get { return _MaximumIntervalDelta; }
            set { _MaximumIntervalDelta = value; }
        }

        public int TotalDataPoints
        {
            get { return _TotalDataPoints; }
        }

        public int PotentialDataHoles
        {
            get { return _PotentialDataHoles; }
        }

        public int ShorterIntervals
        {
            get { return _ShorterIntervals; }
        }

        public int LongerIntervals
        {
            get { return _LongerIntervals; }
        }

        public DateTime BeginTime
        {
            get { return _BeginTime; }
        }

        public DateTime EndTime
        {
            get { return _EndTime; }
        }

        public TimeSpan MinimumInterval
        {
            get { return _MinimumInterval; }
        }

        public TimeSpan MaximumInterval
        {
            get { return _MaximumInterval; }
        }

        public TimeSpan AverageInterval
        {
            get { return _AverageInterval; }
        }

        public double MinimumDistance
        {
            get { return _MinimumDistance; }
        }

        public double MaximumDistance
        {
            get { return _MaximumDistance; }
        }

        public double AverageDistance
        {
            get { return _AverageDistance; }
        }
        #endregion

        public LocationDataAnalyzer()
        {
            _ExpectedInterval = new TimeSpan(0, 2, 0);      // Two-minute intervals
            _MaximumIntervalDelta = new TimeSpan(0, 2, 0);  // Half an interval is the most we want to allow
        }

        public StringBuilder AnalyzeLocations(IList<AgilisDriverPosition> Locations)
        {
            StringBuilder Results = new StringBuilder();
            Results.AppendLine("Timestamp\tInterval\tDistance");
            PrepareResultFieldsForAnalysis();

            List<AgilisDriverPosition> LocalCopy = new List<AgilisDriverPosition>(Locations);
            LocalCopy.Sort(new DriverPositionComparer());

            AgilisDriverPosition LastPosition = null;
            TimeSpan TotalInterval = new TimeSpan();
            double TotalDistance = 0;

            foreach (AgilisDriverPosition Position in LocalCopy)
            {
                // TODO: test if it's somehow a spurious point and skip if it is?

                _TotalDataPoints++;

                if (LastPosition == null)
                {
                    _BeginTime = Position.Timestamp;
                    LastPosition = Position;
                    continue;
                }

                Debug.Assert(LastPosition.Timestamp < Position.Timestamp);

                TimeSpan Interval = Position.Timestamp - LastPosition.Timestamp;
                TotalInterval += Interval;

                if (Interval < _MinimumInterval)
                    _MinimumInterval = Interval;
                if (Interval > _MaximumInterval)
                    _MaximumInterval = Interval;
                if (Interval <= _ExpectedInterval)
                    _ShorterIntervals++;
                else
                    _LongerIntervals++;
                if (Interval > (_ExpectedInterval + _MaximumIntervalDelta))
                    _PotentialDataHoles++;

                double Distance = GeocodingUtilities.ComputeSphericalDistance(LastPosition.Latitude, LastPosition.Longitude,
                    Position.Latitude, Position.Longitude);
                TotalDistance += Distance;

                if (Distance < _MinimumDistance)
                    _MinimumDistance = Distance;
                if (Distance > _MaximumDistance)
                    _MaximumDistance = Distance;

                _EndTime = Position.Timestamp;

                Results.AppendLine(string.Format("{0}\t{1}\t{2}", Position.Timestamp, Interval, Distance));

                LastPosition = Position;
            }

            _AverageInterval = new TimeSpan(0, 0, (int)(TotalInterval.TotalSeconds / _TotalDataPoints));
            _AverageDistance = TotalDistance / _TotalDataPoints;

            Results.AppendLine();
            Results.AppendLine("Summary Information");
            Results.Append(ToString());

            return Results;
        }

        private void PrepareResultFieldsForAnalysis()
        {
            _TotalDataPoints = _PotentialDataHoles = 0;
            _ShorterIntervals = _LongerIntervals = 0;
            _BeginTime = DateTime.MaxValue;
            _EndTime = DateTime.MinValue;
            _MinimumInterval = TimeSpan.MaxValue;
            _MaximumInterval = TimeSpan.MinValue;
            _AverageInterval = new TimeSpan();
            _MinimumDistance = double.MaxValue;
            _MaximumDistance = double.MinValue;
            _AverageDistance = 0;
        }

        public override string ToString()
        {
            StringBuilder Sb = new StringBuilder();
            Sb.AppendLine(string.Format("Expected Interval\t{0}", _ExpectedInterval));
            Sb.AppendLine(string.Format("Maximum Interval Delta\t{0}", _MaximumIntervalDelta));
            Sb.AppendLine(string.Format("Total Data Points\t{0}", _TotalDataPoints));
            Sb.AppendLine(string.Format("Potential Data Holes\t{0}\t{1:p}", _PotentialDataHoles, (double)_PotentialDataHoles / _TotalDataPoints));
            Sb.AppendLine(string.Format("Begin Time\t{0}", _BeginTime));
            Sb.AppendLine(string.Format("End Time\t{0}", _EndTime));
            Sb.AppendLine(string.Format("Shorter Intervals\t{0}\t{1:p}", _ShorterIntervals, (double)_ShorterIntervals / _TotalDataPoints));
            Sb.AppendLine(string.Format("Longer Intervals\t{0}\t{1:p}", _LongerIntervals, (double)LongerIntervals / _TotalDataPoints));
            Sb.AppendLine(string.Format("Minimum Interval\t{0}", _MinimumInterval));
            Sb.AppendLine(string.Format("Maximum Interval\t{0}", _MaximumInterval));
            Sb.AppendLine(string.Format("Average Interval\t{0}", _AverageInterval));
            Sb.AppendLine(string.Format("Minimum Distance\t{0:f}", _MinimumDistance));
            Sb.AppendLine(string.Format("Maximum Distance\t{0:f}", _MaximumDistance));
            Sb.AppendLine(string.Format("Average Distance\t{0:f}", _AverageDistance));
            return Sb.ToString();
        }
    }
}
