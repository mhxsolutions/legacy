using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace Driver_Break_Detector
{
    class DriverBreakOutputCsvBreaksOnly : IDriverBreakOutputGenerator
    {
        #region Helper Classes
        private class DriverComparer : IComparer<int>
        {
            private readonly DriverBreakOutputCsvBreaksOnly _Generator;

            public int Compare(int X, int Y)
            {
                DriverDetails DriverX = _Generator.DriverMap[X];
                DriverDetails DriverY = _Generator.DriverMap[Y];

                int LastNameCompare = string.Compare(DriverX.LastName, DriverY.LastName);
                if (LastNameCompare < 0)
                    return -1;
                if (LastNameCompare > 0)
                    return 1;

                int FirstNameCompare = string.Compare(DriverX.FirstName, DriverY.FirstName);
                if (FirstNameCompare < 0)
                    return -1;
                if (LastNameCompare > 0)
                    return 1;

                return 0;
            }

            public DriverComparer(DriverBreakOutputCsvBreaksOnly Generator)
            {
                _Generator = Generator;
            }
        }
        #endregion

        private DateTime _BeginTime;
        private DateTime _EndTime;
        private Dictionary<int, DriverDetails> _DriverMap;
        private DriverPlanCache _PlanCache;
        private Dictionary<int, DriverLocationCache> _LocationCacheMap;
        private DriverBreakDetector _BreakDetector;

        #region Properties
        public DateTime BeginTime
        {
            get { return _BeginTime; }
            set { _BeginTime = value; }
        }

        public DateTime EndTime
        {
            get { return _EndTime; }
            set { _EndTime = value; }
        }

        public Dictionary<int, DriverDetails> DriverMap
        {
            get { return _DriverMap; }
            set { _DriverMap = value; }
        }

        public DriverPlanCache PlanCache
        {
            get { return _PlanCache; }
            set { _PlanCache = value; }
        }

        public Dictionary<int, DriverLocationCache> LocationCacheMap
        {
            get { return _LocationCacheMap; }
            set { _LocationCacheMap = value; }
        }

        public DriverBreakDetector BreakDetector
        {
            get { return _BreakDetector; }
            set { _BreakDetector = value; }
        }
        #endregion

        public DriverBreakOutputCsvBreaksOnly(DateTime BeginTime, DateTime EndTime, Dictionary<int, DriverDetails> DriverMap, DriverPlanCache PlanCache, Dictionary<int, DriverLocationCache> LocationCacheMap, DriverBreakDetector BreakDetector)
        {
            _BeginTime = BeginTime;
            _EndTime = EndTime;
            _DriverMap = DriverMap;
            _PlanCache = PlanCache;
            _LocationCacheMap = LocationCacheMap;
            _BreakDetector = BreakDetector;
        }

        private int[] GetSortedDriverIndices()
        {
            int Index = 0;
            int[] ReturnValue = new int[_DriverMap.Count];
            foreach (KeyValuePair<int, DriverDetails> Pair in _DriverMap)
            {
                ReturnValue[Index++] = Pair.Key;
            }
            Array.Sort(ReturnValue, new DriverComparer(this));
            return ReturnValue;
        }

        private static void CreateFolderIfNeeded(string FolderName)
        {
            string ProperFolderName = FolderName.Replace('/', '\\');
            if (!Directory.Exists(ProperFolderName))
                Directory.CreateDirectory(ProperFolderName);
        }

        public void GenerateOutput(string OutputFolderName, IStatusDisplay StatusDisplay)
        {
            // TODO: double-check the folder doesn't exist or is empty.

            DateTime CurrentDate = _BeginTime.Date;
            int[] DriverIndices = GetSortedDriverIndices();
            CreateFolderIfNeeded(OutputFolderName);
            string OutputFileName = Path.Combine(OutputFolderName,
                                                 string.Format("Driver Break Analysis {0:yyyy-MM-dd HH-mm-ss}.csv",
                                                               DateTime.Now));

            using (StreamWriter Stream = new StreamWriter(OutputFileName, false))
            {
                Stream.WriteLine("Date,Last Name,First Name,Break Begin,Break End,Break Length,Location,Suspect Data");

                while (CurrentDate < _EndTime.Date)
                {
                    StatusDisplay.PrimaryTaskDescription = string.Format("Processing {0}...", CurrentDate.ToShortDateString());

                    if (_BreakDetector.Results.ContainsKey(CurrentDate))
                    {
                        DateDriverResults CurrentDateDriverResults = _BreakDetector.Results[CurrentDate];
                        for (int Index = 0; Index < DriverIndices.Length; Index++)
                        {
                            DriverBreaks Dr = CurrentDateDriverResults.GetDriverResult(DriverIndices[Index]);

                            if (Dr != null)
                            {
                                DriverLocationCache Lc = _LocationCacheMap[Dr.Driver.Id];

                                foreach (BreakDetails Break in Dr.Breaks)
                                {
                                    if (Break.PossibleLunch)
                                    {
                                        // I don't know why this was producing bad output; I'm guessing I got the wrong location map from above.
                                        // I don't know why that would be happening, but changing the BreakDetails class to include direct
                                        // references to the locations fixed the output issues.

                                        //DriverLocation L1 = Lc.Locations[Break.BeginIndex];
                                        //DriverLocation L2 = Lc.Locations[Break.EndIndex];

                                        DriverLocation L1 = Break.BeginLocation;
                                        DriverLocation L2 = Break.EndLocation;
                                        TimeSpan Interval = L2.Timestamp - L1.Timestamp;

                                        string Line = string.Format("{0},{1},{2},{3},{4},{5},{6},{7}",
                                                                    CurrentDate.ToShortDateString(),
                                                                    Dr.Driver.LastName, 
                                                                    Dr.Driver.FirstName,
                                                                    L1.Timestamp.ToShortTimeString(),
                                                                    L2.Timestamp.ToShortTimeString(), 
                                                                    Interval,
                                                                    Break.CustomLocation == null ? string.Empty : Break.CustomLocation.Name,
                                                                    Dr.Error != DriverBreakDetectError.None ? "Yes" : "No");

                                        Stream.WriteLine(Line);
                                    }
                                }
                            }
                        }
                    }

                    CurrentDate = CurrentDate.AddDays(1);
                }
            }
        }
    }
}
