using System;
using System.Collections.Generic;
using System.Diagnostics;
using BopsUtilities;

namespace Driver_Break_Detector
{
    public class DriverBreakDetector
    {
        #region Helper Classes

        #endregion

        private readonly Dictionary<int, DriverDetails> _DriverMap;
        private readonly DriverPlanCache _PlanCache;
        private readonly Dictionary<int, DriverLocationCache> _LocationCacheMap;
        private Dictionary<DateTime, DateDriverResults> _Results;
        private IStatusDisplay _Status;

        public Dictionary<int, DriverDetails> DriverMap
        {
            get { return _DriverMap; }
        }

        public DriverPlanCache PlanCache
        {
            get { return _PlanCache; }
        }

        public Dictionary<int, DriverLocationCache> LocationCacheMap
        {
            get { return _LocationCacheMap; }
        }

        public Dictionary<DateTime, DateDriverResults> Results
        {
            get { return _Results; }
        }

        public DriverBreakDetector(Dictionary<int, DriverDetails> DriverMap, DriverPlanCache PlanCache, Dictionary<int, DriverLocationCache> LocationCacheMap, IStatusDisplay Status)
        {
            _DriverMap = DriverMap;
            _PlanCache = PlanCache;
            _LocationCacheMap = LocationCacheMap;
            _Status = Status;
        }

        public void DetectBreaks(IList<TargetLocation> CustomLocations)
        {
            _Results = new Dictionary<DateTime, DateDriverResults>();
            Dictionary<DateTime, List<DriverPlanDetail>> DatePlansMap = GetPlansDateMap();

            foreach (KeyValuePair<DateTime, List<DriverPlanDetail>> Pair in DatePlansMap)
            {
                DateDriverResults NewDateDriverResults = new DateDriverResults(Pair.Key);

                foreach (DriverPlanDetail PlanDetail in Pair.Value)
                {
                    _Status.PrimaryTaskDescription = string.Format("Detecting breaks for on {0} for {1}...", PlanDetail.PlanDate.ToShortDateString(), _DriverMap[PlanDetail.DriverId].FullName);

                    DriverBreaks NewDriverBreaks = DetectDriverBreaks(PlanDetail);
                    AssignCustomLocations(NewDriverBreaks, CustomLocations);

                    NewDateDriverResults.DriverResults.Add(NewDriverBreaks);
                }

                _Results.Add(Pair.Key, NewDateDriverResults);
            }
        }

        private void AssignCustomLocations(DriverBreaks DriverBreaks, IList<TargetLocation> CustomLocations)
        {
            if (CustomLocations == null || CustomLocations.Count < 1) return;

            foreach (BreakDetails Break in DriverBreaks.Breaks)
            {
                foreach (TargetLocation Location in CustomLocations)
                {
                    double BeginDistance = ComputeDistanceDelta(Break.BeginLocation, Location);
                    double EndDistance = ComputeDistanceDelta(Break.EndLocation, Location);

                    if (BeginDistance < Location.Distance || EndDistance < Location.Distance)
                        Break.CustomLocation = Location;
                }
            }
        }

        private DriverBreaks DetectDriverBreaks(DriverPlanDetail PlanDetail)
        {
            TimeSpan MaximumBreakTime = new TimeSpan(2, 0, 0);

            DriverBreaks ReturnValue = new DriverBreaks(_DriverMap[PlanDetail.DriverId], PlanDetail);

            // Fetch the locations for the day into the return value and set the error bit if there are none.

            ReturnValue.Locations = _LocationCacheMap[PlanDetail.DriverId].GetLocationsForDate(PlanDetail.PlanDate.Date);
            if (ReturnValue.Locations == null)
                ReturnValue.Error |= DriverBreakDetectError.NoLocations;

            // In the event that we don't have a start time or an end time for the driver's plan, we set the relevant error bits.

            if (!PlanDetail.StartTime.HasValue)
                ReturnValue.Error |= DriverBreakDetectError.NullStartTime;
            if (!PlanDetail.EndTime.HasValue)
                ReturnValue.Error |= DriverBreakDetectError.NullEndTime;

            // If any error bits have been set we cannot do meaningful break analysis, in which case we bail at this point.

            if (ReturnValue.Error != DriverBreakDetectError.None)
                return ReturnValue;

            // Next we do a check to ensure that we have "enough" locations, the problem being that there is no clear metric.
            // This much is certain: if we take the total time of his day and divide by the number of location data points and
            // the resulting time/point ratio is greater than the value we're using for a possible break (20 minutes), we just
            // don't have anough points to do anything meaningful.

            Debug.Assert(ReturnValue.Locations != null && ReturnValue.Locations.Length > 0);    // Not necessary but makes Resharper happy.
            Debug.Assert(PlanDetail.StartTime.HasValue && PlanDetail.EndTime.HasValue);         // Not necessary but makes Resharper happy.

            TimeSpan MinimumBreakTime = new TimeSpan(0, 20, 0);
            const double MaximumBreakDistance = 0.25;

            double TotalSeconds = (PlanDetail.EndTime.Value - PlanDetail.StartTime.Value).TotalSeconds;
            double SecondsPerLocation = TotalSeconds / ReturnValue.Locations.Length;
            if (SecondsPerLocation > MinimumBreakTime.TotalSeconds)
                ReturnValue.Error |= DriverBreakDetectError.NotEnoughLocations;

            // If any error bits have been set since the check above, we still cannot do meaningful break analysis, 
            // in which case we bail at this point.

            if (ReturnValue.Error != DriverBreakDetectError.None)
                return ReturnValue;

            int BreakBeginLocation = -1;
            int LocationsExamined = 0;

            for (int Index = 1; Index < ReturnValue.Locations.Length; Index++)
            {
                // We don't look at locations that fall outside the start or end times for the driver's day of work.

                if (ReturnValue.Locations[Index].Timestamp < PlanDetail.StartTime || PlanDetail.EndTime < ReturnValue.Locations[Index].Timestamp)
                    continue;

                LocationsExamined++;

                if (BreakBeginLocation > -1)
                {
                    double Distance = ComputeDistanceDelta(ReturnValue.Locations, BreakBeginLocation, Index);
                    if (Distance > MaximumBreakDistance)
                    {
                        // TODO: add code to figure out if this is a real break or should be ignored.

                        TimeSpan TotalTime = ComputeTimeDelta(ReturnValue.Locations, BreakBeginLocation, Index);
                        if (TotalTime < MaximumBreakTime)
                        {
                            BreakDetails NewBreakDetails = new BreakDetails(BreakBeginLocation, ReturnValue.Locations[BreakBeginLocation], Index, ReturnValue.Locations[Index], TotalTime > MinimumBreakTime);
                            ReturnValue.Breaks.Add(NewBreakDetails);
                        }
                        BreakBeginLocation = -1;
                    }
                }
                else
                {
                    double Distance = ComputeDistanceDelta(ReturnValue.Locations, Index - 1, Index);
                    if (Distance < MaximumBreakDistance)
                    {
                        // TODO: add code to figure out if this is a real break or should be ignored.

                        BreakBeginLocation = Index;
                    }
                }
            }

            // If the routine ended in a break we need to add that one to the list.

            if (BreakBeginLocation != -1)
            {
                TimeSpan TotalTime = ComputeTimeDelta(ReturnValue.Locations, BreakBeginLocation, ReturnValue.Locations.Length - 1);
                if (TotalTime < MaximumBreakTime)
                {
                    BreakDetails NewBreakDetails = new BreakDetails(BreakBeginLocation, ReturnValue.Locations[BreakBeginLocation], ReturnValue.Locations.Length - 1, ReturnValue.Locations[ReturnValue.Locations.Length - 1], TotalTime > MinimumBreakTime);
                    ReturnValue.Breaks.Add(NewBreakDetails);
                }
            }

            // Now that we are finished, we use the total number of locations examined to determine whether our results can be trusted.
            // I've seen cases (David Shelton, 01/23/2009) where his phone isn't turned on until the last few minutes of his day. We get
            // a lot of locations, but few during the work day.

            ReturnValue.LocationsExamined = LocationsExamined;
            double SecondsPerWorkingLocation = TotalSeconds / LocationsExamined;
            if (SecondsPerWorkingLocation > MinimumBreakTime.TotalSeconds)
                ReturnValue.Error |= DriverBreakDetectError.NotEnoughLocationsDuringWorkDay;

            return ReturnValue;
        }

        private static TimeSpan ComputeTimeDelta(DriverLocation[] Locations, int LocationOneIndex, int LocationTwoIndex)
        {
            DriverLocation L1 = Locations[LocationOneIndex];
            DriverLocation L2 = Locations[LocationTwoIndex];
            return L2.Timestamp - L1.Timestamp;
        }

        private static double ComputeDistanceDelta(DriverLocation[] Locations, int LocationOneIndex, int LocationTwoIndex)
        {
            DriverLocation L1 = Locations[LocationOneIndex];
            DriverLocation L2 = Locations[LocationTwoIndex];
            return GeocodingUtilities.ComputeSphericalDistance(L1.Latitude, L1.Longitude, L2.Latitude, L2.Longitude);
        }

        private static double ComputeDistanceDelta(DriverLocation L1, TargetLocation L2)
        {
            return GeocodingUtilities.ComputeSphericalDistance(L1.Latitude, L1.Longitude, L2.Latitude, L2.Longitude);
        }

        private Dictionary<DateTime, List<DriverPlanDetail>> GetPlansDateMap()
        {
            Dictionary<DateTime, List<DriverPlanDetail>> ReturnValue = new Dictionary<DateTime, List<DriverPlanDetail>>();

            for (int Index = 0; Index < _PlanCache.PlanDetails.Count; /* NB: The index is updated in the loop below */ )
            {
                bool Done = false;
                List<DriverPlanDetail> Plans = new List<DriverPlanDetail>();
                DateTime PlanDate = _PlanCache.PlanDetails[Index].PlanDate.Date;

                while (!Done)
                {
                    if (_PlanCache.PlanDetails.Count <= Index)
                        break;

                    if (PlanDate == _PlanCache.PlanDetails[Index].PlanDate.Date)
                        Plans.Add(_PlanCache.PlanDetails[Index++]);
                    else
                        Done = true;
                }

                ReturnValue.Add(PlanDate, Plans);
            }

            return ReturnValue;
        }
    }
}
