using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;

namespace Driver_Break_Detector
{
    public class DriverLocationCache
    {
        #region Helper Classes

        private class LocationComparer : IComparer<DriverLocation>
        {
            public int Compare(DriverLocation X, DriverLocation Y)
            {
                if (X.Timestamp < Y.Timestamp) return -1;
                return X.Timestamp > Y.Timestamp ? 1 : 0;
            }
        }

        private class LocationDateIndices
        {
            private DateTime _Date;
            private int _FirstIndex;
            private int _LastIndex;

            public DateTime Date
            {
                get { return _Date; }
                set { _Date = value; }
            }

            public int FirstIndex
            {
                get { return _FirstIndex; }
                set { _FirstIndex = value; }
            }

            public int LastIndex
            {
                get { return _LastIndex; }
                set { _LastIndex = value; }
            }

            public LocationDateIndices(DateTime Date, int FirstIndex)
            {
                _Date = Date;
                _FirstIndex = _LastIndex = FirstIndex;
            }
        }

        #endregion

        private readonly DateTime _BeginDate;
        private readonly DateTime _EndDate;
        private readonly int _DriverId;
        private List<DriverLocation> _Locations;
        private Dictionary<DateTime, LocationDateIndices> _LocationDateMap;

        public DateTime BeginDate
        {
            get { return _BeginDate; }
        }

        public DateTime EndDate
        {
            get { return _EndDate; }
        }

        public int DriverId
        {
            get { return _DriverId; }
        }

        public List<DriverLocation> Locations
        {
            get { return _Locations; }
        }

        public DriverLocationCache(DateTime BeginDate, DateTime EndDate, int DriverId)
        {
            _BeginDate = BeginDate;
            _EndDate = EndDate;
            _DriverId = DriverId;

            LoadLocationDetails();
        }

        private string GenerateSqlQueryString()
        {
            const string QueryFormat =
                @"SELECT [Driver Position Id] AS [PositionId], [Timestamp], [Latitude], [Longitude] FROM [DWS No Rep Data].[dbo].[Agilis Imported Driver Position History] " + 
                "WHERE [Driver Ref] = {0} AND ('{1}' <= [Timestamp] AND [Timestamp] < '{2}') UNION " +
                "SELECT [Driver Position Id] AS [PositionId], [Timestamp], [Latitude], [Longitude] FROM [DWS Archives].[dbo].[Agilis Imported Driver Position History] " +
                "WHERE [Driver Ref] = {0} AND ('{1}' <= [Timestamp] AND [Timestamp] < '{2}')";

            return string.Format(QueryFormat, _DriverId, _BeginDate, _EndDate);
        }

        private void LoadLocationDetails()
        {
            _Locations = new List<DriverLocation>();
            string SqlQueryString = GenerateSqlQueryString();

            using (SqlConnection Connection = new SqlConnection(@"Data Source=SQL1;Initial Catalog=DWS No Rep Data;Integrated Security=True"))
            {
                Connection.Open();

                using (SqlCommand Command = new SqlCommand(SqlQueryString, Connection))
                {
                    using (SqlDataReader Reader = Command.ExecuteReader())
                    {
                        while (Reader.Read())
                        {
                            DriverLocation NewLocation = new DriverLocation();
                            NewLocation.Id = Convert.ToInt32(Reader["PositionId"]);
                            NewLocation.Latitude = Convert.ToDouble(Reader["Latitude"]);
                            NewLocation.Longitude = Convert.ToDouble(Reader["Longitude"]);
                            NewLocation.Timestamp = Convert.ToDateTime(Reader["Timestamp"]);
                            _Locations.Add(NewLocation);
                        }

                        Reader.Close();
                    }
                }

                Connection.Close();
            }

            _Locations.Sort(new LocationComparer());
            CreateLocationDateMap();
        }

        private void CreateLocationDateMap()
        {
            LocationDateIndices LastTracked = null;
            _LocationDateMap = new Dictionary<DateTime, LocationDateIndices>();

            for (int Index = 0; Index < _Locations.Count; Index++)
            {
                DriverLocation CurrentLocation = _Locations[Index];
                DateTime LocationDate = CurrentLocation.Timestamp.Date;
                if (_LocationDateMap.ContainsKey(LocationDate))
                {
                    Debug.Assert(LastTracked != null);
                    LastTracked.LastIndex = Index;
                    continue;
                }

                LocationDateIndices NewTrack = new LocationDateIndices(LocationDate, Index);
                _LocationDateMap.Add(LocationDate, NewTrack);
                LastTracked = NewTrack;
            }
        }

        public DriverLocation[] GetLocationsForDate(DateTime Date)
        {
            if (!_LocationDateMap.ContainsKey(Date.Date)) return null;

            LocationDateIndices Indices = _LocationDateMap[Date.Date];
            int LocationCount = Indices.LastIndex - Indices.FirstIndex + 1;
            DriverLocation[] ReturnValue = new DriverLocation[LocationCount];
            _Locations.CopyTo(Indices.FirstIndex, ReturnValue, 0, LocationCount);

            return ReturnValue;
        }
    }
}
