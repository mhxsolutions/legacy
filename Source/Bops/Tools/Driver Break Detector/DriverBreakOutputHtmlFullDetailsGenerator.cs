using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using BopsUtilities;

namespace Driver_Break_Detector
{
    class DriverBreakOutputHtmlFullDetailsGenerator : IDriverBreakOutputGenerator
    {
        #region Helper Classes
        private class DriverComparer : IComparer<int>
        {
            private readonly DriverBreakOutputHtmlFullDetailsGenerator _OutputHtmlFullDetailsGenerator;

            public int Compare(int X, int Y)
            {
                DriverDetails DriverX = _OutputHtmlFullDetailsGenerator.DriverMap[X];
                DriverDetails DriverY = _OutputHtmlFullDetailsGenerator.DriverMap[Y];

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

            public DriverComparer(DriverBreakOutputHtmlFullDetailsGenerator OutputHtmlFullDetailsGenerator)
            {
                _OutputHtmlFullDetailsGenerator = OutputHtmlFullDetailsGenerator;
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

        public DriverBreakOutputHtmlFullDetailsGenerator(DateTime BeginTime, DateTime EndTime, Dictionary<int, DriverDetails> DriverMap, DriverPlanCache PlanCache, Dictionary<int, DriverLocationCache> LocationCacheMap, DriverBreakDetector BreakDetector)
        {
            _BeginTime = BeginTime;
            _EndTime = EndTime;
            _DriverMap = DriverMap;
            _PlanCache = PlanCache;
            _LocationCacheMap = LocationCacheMap;
            _BreakDetector = BreakDetector;
        }

        private void WriteIndexFileHeader(StreamWriter Stream)
        {
            Stream.WriteLine(@"<!DOCTYPE html PUBLIC ""-//W3C//DTD XHTML 1.0 Transitional//EN"" ""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"">");
            Stream.WriteLine(@"<html xmlns=""http://www.w3.org/1999/xhtml"">");
            Stream.WriteLine("<head>");
            Stream.WriteLine(@"<meta http-equiv=""Content-Type"" content=""text/html; charset=utf-8"" />");
            Stream.WriteLine(string.Format("<title>Driver Break Analysis: {0} to {1}</title>", _BeginTime.ToShortDateString(), EndTime.ToShortDateString()));
            Stream.WriteLine("</head>");
            Stream.WriteLine("");
            Stream.WriteLine("<body>");
            Stream.WriteLine(string.Format("\t<h1>Driver Break Analysis: {0} to {1}</h1>\n", _BeginTime.ToShortDateString(), EndTime.ToShortDateString()));
            Stream.WriteLine("<p>* Asterisk denotes suspect data; click the link for details.</p>");
            Stream.WriteLine("\t<table border=\"1\" cellpadding=\"4\">");
        }

        private static void WriteIndexFileFooter(StreamWriter Stream)
        {
            Stream.WriteLine("\t</table>");
            Stream.WriteLine("</body>");
            Stream.WriteLine("</html>");
        }

        private static void WriteDetailsFileHeader(StreamWriter Stream, DateTime PlanDate, DriverBreaks Dr)
        {
            Stream.WriteLine(@"<!DOCTYPE html PUBLIC ""-//W3C//DTD XHTML 1.0 Transitional//EN"" ""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"">");
            Stream.WriteLine(@"<html xmlns=""http://www.w3.org/1999/xhtml"">");
            Stream.WriteLine("<head>");
            Stream.WriteLine(@"<meta http-equiv=""Content-Type"" content=""text/html; charset=utf-8"" />");
            Stream.WriteLine(string.Format("<title>Details for {0} on {1}</title>", Dr.Driver.FullName, PlanDate.ToShortDateString()));
            Stream.WriteLine("</head>");
            Stream.WriteLine("");
            Stream.WriteLine("<body>");
            Stream.WriteLine(string.Format("\t<h1>Details for {0} on {1}</h1>\n", Dr.Driver.FullName, PlanDate.ToShortDateString()));
        }

        private static void WriteDetailsFileFooter(StreamWriter Stream)
        {
            Stream.WriteLine(@"</body>");
            Stream.WriteLine(@"</html>");
        }

        public void GenerateOutput(string OutputFolderName, IStatusDisplay StatusDisplay)
        {
            // TODO: double-check the folder doesn't exist or is empty.

            DateTime CurrentDate = _BeginTime.Date;
            int[] DriverIndices = GetSortedDriverIndices();

            //string OutputDetailsFolder = string.Format("{0}/details", OutputFolderName);
            string OutputDetailsFolder = "./details";
            string IndexFileName = string.Format("{0}/index.html", OutputFolderName);
            CreateFolderIfNeeded(OutputFolderName);
            CreateFolderIfNeeded(string.Format("{0}/details", OutputFolderName));

            using (StreamWriter Stream = new StreamWriter(IndexFileName, false))
            {
                WriteIndexFileHeader(Stream);
                WriteTableHeader(Stream, DriverIndices);

                while (CurrentDate < _EndTime.Date)
                {
                    StatusDisplay.PrimaryTaskDescription = string.Format("Processing {0}...", CurrentDate.ToShortDateString());

                    StringBuilder CurrentLine = new StringBuilder();

                    if (!_BreakDetector.Results.ContainsKey(CurrentDate))
                    {
                        CurrentLine.AppendFormat("\t\t<tr>\n\t\t\t<td>{0}</td>\n\t\t</tr>", CurrentDate.ToShortDateString());
                    }
                    else
                    {
                        CurrentLine.AppendFormat("\t\t<tr>\n\t\t<td>{0}</td>", CurrentDate.ToShortDateString());

                        DateDriverResults CurrentDateDriverResults = _BreakDetector.Results[CurrentDate];
                        for (int Index = 0; Index < DriverIndices.Length; Index++)
                        {
                            DriverBreaks Dr = CurrentDateDriverResults.GetDriverResult(DriverIndices[Index]);
                            if (Dr == null)
                            {
                                CurrentLine.Append("\n\t\t\t<td>-</td>");
                            }
                            else
                            {
                                int CustomLocationMatches = 0;
                                int PossibleLunchBreaks = 0;

                                foreach (BreakDetails Break in Dr.Breaks)
                                {
                                    if (Break.PossibleLunch)
                                        PossibleLunchBreaks++;
                                    if (Break.CustomLocation != null)
                                        CustomLocationMatches++;
                                }

                                GenerateDriverBreaksDetails(OutputFolderName, CurrentDate, Dr);

                                string LinkFileName = GenerateDriverBreaksDetailsFileName(null, CurrentDate, Dr);
                                if (Dr.Error == DriverBreakDetectError.None)
                                    CurrentLine.AppendFormat("\n\t\t\t<td><a href=\"{0}\">{1} of {2} ({3})</a></td>", LinkFileName, PossibleLunchBreaks, Dr.Breaks.Count, CustomLocationMatches);
                                else
                                    CurrentLine.AppendFormat("\n\t\t\t<td><a href=\"{0}\">{1} of {2} ({3}) *</a></td>", LinkFileName, PossibleLunchBreaks, Dr.Breaks.Count, CustomLocationMatches);
                                    //CurrentLine.AppendFormat("\n\t\t\t<td><a href=\"{0}\">Error</a></td>", LinkFileName);
                            }
                        }

                        CurrentLine.Append("\n\t\t</tr>");
                    }

                    Stream.WriteLine(CurrentLine.ToString());
                    CurrentDate = CurrentDate.AddDays(1);
                }

                WriteIndexFileFooter(Stream);
            }
        }

        private static void CreateFolderIfNeeded(string FolderName)
        {
            string ProperFolderName = FolderName.Replace('/', '\\');
            if (!Directory.Exists(ProperFolderName))
                Directory.CreateDirectory(ProperFolderName);
        }

        private static string GenerateDriverBreaksDetailsFileName(string OutputFolder, DateTime PlanDate, DriverBreaks Dr)
        {
            if (string.IsNullOrEmpty(OutputFolder))
                return string.Format("./details/{0:yyyy-MM-dd}.{1}.html", PlanDate, Dr.Driver.Id);
            else
                return string.Format("{0}/details/{1:yyyy-MM-dd}.{2}.html", OutputFolder, PlanDate, Dr.Driver.Id);
        }

        private void WriteTableHeader(StreamWriter Stream, int[] DriverIndices)
        {
            StringBuilder CurrentLine = new StringBuilder("\t\t<tr>\n\t\t\t<td>Date</td>\n");

            for (int Index = 0; Index < DriverIndices.Length; Index++)
            {
                DriverDetails Driver = _DriverMap[DriverIndices[Index]];
                CurrentLine.AppendFormat("\t\t\t<td>{0}</td>\n", Driver.FullName);
            }

            CurrentLine.Append("\t\t</tr>");
            Stream.WriteLine(CurrentLine);
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

        private static string GenerateDriverBreaksDetails(string OutputFolder, DateTime PlanDate, DriverBreaks Dr)
        {
            string DetailsFileName = GenerateDriverBreaksDetailsFileName(OutputFolder, PlanDate, Dr);

            using (StreamWriter Stream = new StreamWriter(DetailsFileName, false))
            {
                WriteDetailsFileHeader(Stream, PlanDate, Dr);

                Stream.WriteLine("\t<h2>Error Status</h2>");
                Stream.WriteLine(string.Format("\t<p>{0}</p>\n", Dr.Error));

                Stream.WriteLine("\t<h2>Breaks</h2>");
                if (Dr.Breaks == null || Dr.Breaks.Count == 0)
                    Stream.WriteLine("\t<p>(no breaks)</p>\n");
                else
                    WriteBreakData(Stream, Dr);

                Stream.WriteLine("\t<h2>Location Data Quality</h2>");
                if (Dr.Locations == null || Dr.Locations.Length < 1)
                    Stream.WriteLine("\t<p>(no location data)</p>\n");
                else
                    WriteLocationQualityData(Stream, Dr);

                Stream.WriteLine("\t<h2>Location Data</h2>");
                if (Dr.Locations == null || Dr.Locations.Length < 1)
                    Stream.WriteLine("\t<p>(no location data)</p>\n");
                else
                    WriteLocationData(Stream, Dr);

                WriteDetailsFileFooter(Stream);
            }

            return GenerateDriverBreaksDetailsFileName(OutputFolder, PlanDate, Dr);
        }

        private static void WriteBreakData(StreamWriter Stream, DriverBreaks Dr)
        {
            Stream.WriteLine("\t<table border=\"1\" cellpadding=\"4\">\n\t\t<tr>");
            Stream.WriteLine("\t\t\t<td>Break</td>\n\t\t\t<td>From</td>\n\t\t\t<td>To</td>\n\t\t\t<td>Interval</td>\n\t\t\t<td>Location</td>\n\t\t\t<td>Possible Lunch?</td>\n\t\t</tr>");

            for (int Index = 0; Index < Dr.Breaks.Count; Index++ )
            {
                DriverLocation L1 = Dr.Locations[Dr.Breaks[Index].BeginIndex];
                DriverLocation L2 = Dr.Locations[Dr.Breaks[Index].EndIndex];
                TimeSpan Interval = L2.Timestamp - L1.Timestamp;

                Stream.WriteLine(string.Format("\t\t<tr>\n\t\t\t<td>{0}</td>\n\t\t\t<td>{1}</td>\n\t\t\t<td>{2}</td>\n\t\t\t<td>{3}</td>\n\t\t\t<td>{4}</td>\n\t\t\t<td>{5}</td>\n\t\t</tr>",
                    Index + 1, L1.Timestamp.ToString("HH:mm:ss"), L2.Timestamp.ToString("HH:mm:ss"), Interval, 
                    Dr.Breaks[Index].CustomLocation != null ? Dr.Breaks[Index].CustomLocation.Name : string.Empty,
                    Dr.Breaks[Index].PossibleLunch ? "Yes" : "No"));
            }

            Stream.WriteLine("\t</table>\n");
        }

        private static void WriteLocationData(StreamWriter Stream, DriverBreaks Dr)
        {
            Stream.WriteLine("\t<table border=\"1\" cellpadding=\"4\">\n\t\t<tr>");
            Stream.WriteLine("\t\t\t<td>Time</td>\n\t\t\t<td>Break</td>\n\t\t\t<td>Latitude</td>\n\t\t\t<td>Longitude</td>\n\t\t\t<td>Interval</td>\n\t\t\t<td>Distance</td>\n\t\t</tr>");

            for (int Index = 0; Index < Dr.Locations.Length; Index++)
            {
                DriverLocation Location = Dr.Locations[Index];

                if (Index == 0)
                {
                    Stream.WriteLine(string.Format("\t\t<tr>\n\t\t\t<td>{0}</td>\n\t\t\t<td>{1}</td>\n\t\t\t<td>{2}</td>\n\t\t\t<td>{3}</td>\n\t\t\t<td>{4}</td>\n\t\t\t<td>{5}</td>\n\t\t</tr>",
                        Location.Timestamp.ToString("HH:mm:ss"), "-", Location.Latitude, Location.Longitude, "-", "-"));
                }
                else
                {
                    DriverLocation LastLocation = Dr.Locations[Index - 1];
                    TimeSpan Interval = Location.Timestamp - LastLocation.Timestamp;
                    double Distance = GeocodingUtilities.ComputeSphericalDistance(LastLocation.Latitude, LastLocation.Longitude, Location.Latitude, Location.Longitude);

                    int BreakIndex = -1;
                    for (int B = 0; B < Dr.Breaks.Count && BreakIndex == -1; B++)
                    {
                        if (Dr.Breaks[B].BeginIndex <= Index && Index <= Dr.Breaks[B].EndIndex)
                            BreakIndex = B + 1;
                    }

                    Stream.WriteLine(string.Format("\t\t<tr>\n\t\t\t<td>{0}</td>\n\t\t\t<td>{1}</td>\n\t\t\t<td>{2}</td>\n\t\t\t<td>{3}</td>\n\t\t\t<td>{4}</td>\n\t\t\t<td>{5:f4}</td>\n\t\t</tr>",
                        Dr.Locations[Index].Timestamp.ToString("HH:mm:ss"), BreakIndex == -1 ? "-" : BreakIndex.ToString(), Dr.Locations[Index].Latitude, 
                        Dr.Locations[Index].Longitude, Interval, Distance));
                }
            }

            Stream.WriteLine("\t</table>\n");
        }

        private static void WriteLocationQualityData(StreamWriter Stream, DriverBreaks Dr)
        {
            Stream.WriteLine("\t<table border=\"1\" cellpadding=\"4\">\n\t\t<tr>");
            Stream.WriteLine("\t\t\t<td>Metric</td>\n\t\t\t<td>Value</td>\n\t\t</tr>");

            double ShorterPercent = (double)Dr.LocationQualityMetrics.ShorterIntervals / (Dr.LocationQualityMetrics.TotalDataPoints - 1);
            double LongerPercent = (double)Dr.LocationQualityMetrics.LongerIntervals / (Dr.LocationQualityMetrics.TotalDataPoints - 1);

            Stream.WriteLine(string.Format("\t\t<tr>\n\t\t\t<td>{0}</td>\n\t\t\t<td>{1}</td>\n\t\t</tr>", "Total Locations:", Dr.LocationQualityMetrics.TotalDataPoints));
            Stream.WriteLine(string.Format("\t\t<tr>\n\t\t\t<td>{0}</td>\n\t\t\t<td>{1}</td>\n\t\t</tr>", "Potential Data Holes:", Dr.LocationQualityMetrics.PotentialDataHoles));
            Stream.WriteLine(string.Format("\t\t<tr>\n\t\t\t<td>{0}</td>\n\t\t\t<td>{1}</td>\n\t\t</tr>", "Minimum Interval:", Dr.LocationQualityMetrics.MinimumInterval));
            Stream.WriteLine(string.Format("\t\t<tr>\n\t\t\t<td>{0}</td>\n\t\t\t<td>{1}</td>\n\t\t</tr>", "Average Interval:", Dr.LocationQualityMetrics.AverageInterval));
            Stream.WriteLine(string.Format("\t\t<tr>\n\t\t\t<td>{0}</td>\n\t\t\t<td>{1}</td>\n\t\t</tr>", "Maximum Interval:", Dr.LocationQualityMetrics.MaximumInterval));
            Stream.WriteLine(string.Format("\t\t<tr>\n\t\t\t<td>{0}</td>\n\t\t\t<td>{1} ({2:p2})</td>\n\t\t</tr>", "Shorter than Average Intervals:", Dr.LocationQualityMetrics.ShorterIntervals, ShorterPercent));
            Stream.WriteLine(string.Format("\t\t<tr>\n\t\t\t<td>{0}</td>\n\t\t\t<td>{1} ({2:p2})</td>\n\t\t</tr>", "Longer than Average Intervals:", Dr.LocationQualityMetrics.LongerIntervals, LongerPercent));
            Stream.WriteLine(string.Format("\t\t<tr>\n\t\t\t<td>{0}</td>\n\t\t\t<td>{1}</td>\n\t\t</tr>", "First Location:", Dr.LocationQualityMetrics.BeginTime.ToString("HH:mm:ss")));
            Stream.WriteLine(string.Format("\t\t<tr>\n\t\t\t<td>{0}</td>\n\t\t\t<td>{1}</td>\n\t\t</tr>", "Last Location:", Dr.LocationQualityMetrics.EndTime.ToString("HH:mm:ss")));
            Stream.WriteLine(string.Format("\t\t<tr>\n\t\t\t<td>{0}</td>\n\t\t\t<td>{1}</td>\n\t\t</tr>", "Driver Start Time:", Dr.PlanDetail.StartTime.HasValue ? Dr.PlanDetail.StartTime.Value.ToString("HH:mm:ss") : "-"));
            Stream.WriteLine(string.Format("\t\t<tr>\n\t\t\t<td>{0}</td>\n\t\t\t<td>{1}</td>\n\t\t</tr>", "Driver End Time:", Dr.PlanDetail.EndTime.HasValue ? Dr.PlanDetail.EndTime.Value.ToString("HH:mm:ss") : "-"));
            Stream.WriteLine(string.Format("\t\t<tr>\n\t\t\t<td>{0}</td>\n\t\t\t<td>{1}</td>\n\t\t</tr>", "Minimum Distance Delta:", string.Format("{0:f2}", Dr.LocationQualityMetrics.MinimumDistance)));
            Stream.WriteLine(string.Format("\t\t<tr>\n\t\t\t<td>{0}</td>\n\t\t\t<td>{1}</td>\n\t\t</tr>", "Average Distance Delta:", string.Format("{0:f2}", Dr.LocationQualityMetrics.AverageDistance)));
            Stream.WriteLine(string.Format("\t\t<tr>\n\t\t\t<td>{0}</td>\n\t\t\t<td>{1}</td>\n\t\t</tr>", "Maximum Distance Delta:", string.Format("{0:f2}", Dr.LocationQualityMetrics.MaximumDistance)));

            Stream.WriteLine("\t</table>\n");
        }
    }
}
