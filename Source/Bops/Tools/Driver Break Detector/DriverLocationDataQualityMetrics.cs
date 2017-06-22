using System;
using System.Diagnostics;
using System.Text;
using BopsUtilities;

namespace Driver_Break_Detector
{
    public class DriverLocationDataQualityMetrics
    {
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

        public DriverLocationDataQualityMetrics(DriverLocation[] Locations)
        {
            if (Locations != null)
                AnalyzeLocations(Locations);
        }

        public StringBuilder AnalyzeLocations(DriverLocation[] Locations)
        {
            if (Locations == null)
                throw new ArgumentNullException("Locations");

            StringBuilder Results = new StringBuilder();
            Results.AppendLine("Timestamp\tInterval\tDistance");
            PrepareResultFieldsForAnalysis();

            DriverLocation LastLocation = null;
            TimeSpan TotalInterval = new TimeSpan();
            double TotalDistance = 0;

            for (int Index = 0; Index < Locations.Length; Index++)
            {
                DriverLocation CurrentLocation = Locations[Index];
                
                // TODO: test if it's somehow a spurious point and skip if it is?

                _TotalDataPoints++;

                if (LastLocation == null)
                {
                    _BeginTime = CurrentLocation.Timestamp;
                    LastLocation = CurrentLocation;
                    continue;
                }

                Debug.Assert(LastLocation.Timestamp < CurrentLocation.Timestamp);

                TimeSpan Interval = CurrentLocation.Timestamp - LastLocation.Timestamp;
                TotalInterval += Interval;

                if (Interval < _MinimumInterval)
                    _MinimumInterval = Interval;
                if (Interval > _MaximumInterval)
                    _MaximumInterval = Interval;
                //if (Interval <= _ExpectedInterval)
                //    _ShorterIntervals++;
                //else
                //    _LongerIntervals++;
                //if (Interval > (_ExpectedInterval + _MaximumIntervalDelta))
                //    _PotentialDataHoles++;

                double Distance = GeocodingUtilities.ComputeSphericalDistance(LastLocation.Latitude, LastLocation.Longitude,
                    CurrentLocation.Latitude, CurrentLocation.Longitude);
                TotalDistance += Distance;

                if (Distance < _MinimumDistance)
                    _MinimumDistance = Distance;
                if (Distance > _MaximumDistance)
                    _MaximumDistance = Distance;

                _EndTime = CurrentLocation.Timestamp;

                Results.AppendLine(string.Format("{0}\t{1}\t{2}", CurrentLocation.Timestamp, Interval, Distance));

                LastLocation = CurrentLocation;
            }

            _AverageInterval = new TimeSpan(0, 0, (int)(TotalInterval.TotalSeconds / _TotalDataPoints));
            _AverageDistance = TotalDistance / _TotalDataPoints;

            // Second pass to calculate shorter/longer intervals on the basis of the average.

            LastLocation = Locations[0];
            TimeSpan HoleThreshold = new TimeSpan((long)(_AverageInterval.Ticks * 1.5));

            for (int Index = 1; Index < Locations.Length; Index++)
            {
                DriverLocation CurrentLocation = Locations[Index];

                TimeSpan Interval = CurrentLocation.Timestamp - LastLocation.Timestamp;

                if (Interval <= _AverageInterval)
                    _ShorterIntervals++;
                else
                    _LongerIntervals++;

                if (Interval > HoleThreshold)
                    _PotentialDataHoles++;

                LastLocation = CurrentLocation;
            }

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
            Sb.AppendLine(string.Format("Total Data Points\t{0}", _TotalDataPoints));
            Sb.AppendLine(string.Format("Potential Data Holes\t{0}\t{1:p}", _PotentialDataHoles, (double)_PotentialDataHoles / _TotalDataPoints));
            Sb.AppendLine(string.Format("Begin Time\t{0}", _BeginTime));
            Sb.AppendLine(string.Format("End Time\t{0}", _EndTime));
            Sb.AppendLine(string.Format("Below Average Intervals\t{0}\t{1:p}", _ShorterIntervals, (double)_ShorterIntervals / _TotalDataPoints));
            Sb.AppendLine(string.Format("Above Average Intervals\t{0}\t{1:p}", _LongerIntervals, (double)LongerIntervals / _TotalDataPoints));
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
