using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Text;

namespace Driver_Break_Detector
{
    public class DriverPlanCache
    {
        #region Helper Classes

        private class PlanDetailComparer : IComparer<DriverPlanDetail>
        {
            public int Compare(DriverPlanDetail X, DriverPlanDetail Y)
            {
                if (X.PlanDate < Y.PlanDate) return -1;
                if (X.PlanDate > Y.PlanDate) return 1;

                int LastNameCompare = string.Compare(X.LastName, Y.LastName, true);
                if (LastNameCompare != 0) return LastNameCompare;

                int FirstNameCompare = string.Compare(X.FirstName, Y.FirstName, true);
                return FirstNameCompare;
            }
        }

        #endregion

        private readonly DateTime _BeginDate;
        private readonly DateTime _EndDate;
        private readonly int[] _DriverIds;
        private List<DriverPlanDetail> _PlanDetails;

        public DateTime BeginDate
        {
            get { return _BeginDate; }
        }

        public DateTime EndDate
        {
            get { return _EndDate; }
        }

        public List<DriverPlanDetail> PlanDetails
        {
            get { return _PlanDetails; }
        }

        public DriverPlanCache(DateTime BeginDate, DateTime EndDate, int[] DriverIds)
        {
            _BeginDate = BeginDate;
            _EndDate = EndDate;

            _DriverIds = new int[DriverIds.Length];
            for (int Index = 0; Index < DriverIds.Length; Index++)
                _DriverIds[Index] = DriverIds[Index];

            LoadPlanDetails();
        }

        private string GenerateSqlQueryString()
        {
            //const string QueryFormat =
            //    @"SELECT Planner.[Driver Ref] AS DriverId, tblDriverList.FirstName, tblDriverList.LastName, Planner.[Plan ID] AS PlanId, Planner.[Plan Date] AS PlanDate, Planner.[Start Time] AS StartTime, Planner.[Payroll Start] AS PayrollStart " +
            //    "FROM Planner INNER JOIN tblDriverList ON Planner.[Driver Ref] = tblDriverList.EmployeeID " +
            //    " WHERE (Planner.[Driver Ref] IN ({0})) AND ('{1}' <= Planner.[Plan Date]) AND (Planner.[Plan Date] < '{2}')";

            const string QueryFormat =
                @"SELECT Planner.[Driver Ref] AS DriverId, tblDriverList.FirstName, tblDriverList.LastName, Planner.[Plan ID] AS PlanId, Planner.[Plan Date] AS PlanDate, Planner.[Start Time] AS StartTime, Planner.[Payroll Start] AS PayrollStart, " +
                "MAX([Planner Detail].[Depart Destination]) AS EndTime FROM Planner INNER JOIN tblDriverList ON Planner.[Driver Ref] = tblDriverList.EmployeeID " +
                "LEFT OUTER JOIN [Planner Detail] ON Planner.[Plan ID] = [Planner Detail].[Planner Ref] GROUP BY Planner.[Driver Ref], tblDriverList.FirstName, " +
                "tblDriverList.LastName, Planner.[Plan ID], Planner.[Plan Date], Planner.[Start Time], Planner.[Payroll Start] " +
                "HAVING (Planner.[Driver Ref] IN ({0})) AND ('{1}' <= Planner.[Plan Date]) AND (Planner.[Plan Date] < '{2}')";

            StringBuilder Sb = new StringBuilder(_DriverIds[0].ToString());
            for (int Index = 1; Index < _DriverIds.Length; Index++)
                Sb.AppendFormat(", {0}", _DriverIds[Index]);

            return string.Format(QueryFormat, Sb, _BeginDate, _EndDate);
        }

        /// <summary>
        /// This is an ugly necessity of dealing with Microsoft Access. A time-only field in access will be a full, SQL DATETIME
        /// field in SQL Server, but its date will always be 1899-12-30. So this function takes an input value and checks if
        /// it appears to be a time only field. If so, then it takes the time offset and adds it to the date to substitute.
        /// </summary>
        /// <param name="DateToSubstitute">The date to substitute in case of a time-only field.</param>
        /// <param name="Input">The input date that may be a time-only field.</param>
        /// <returns>The proper date and time value.</returns>
        private static DateTime OffsetAccessTimeOnlyField(DateTime DateToSubstitute, DateTime Input)
        {
            DateTime AccessDate = new DateTime(1899, 12, 30);
            if (Input.Date != AccessDate)
                return Input;

            TimeSpan TimePortion = Input - AccessDate;
            return DateToSubstitute.Date + TimePortion;
        }

        private void LoadPlanDetails()
        {
            _PlanDetails = new List<DriverPlanDetail>();
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
                            DriverPlanDetail NewDetail = new DriverPlanDetail();
                            NewDetail.DriverId = Convert.ToInt32(Reader["DriverId"]);
                            NewDetail.FirstName = Reader["FirstName"].ToString();
                            NewDetail.LastName = Reader["LastName"].ToString();
                            NewDetail.PlanId = Convert.ToInt32(Reader["PlanId"]);
                            NewDetail.PlanDate = Convert.ToDateTime(Reader["PlanDate"]);

                            if (Reader["StartTime"] != DBNull.Value)
                            {
                                DateTime Temp = Convert.ToDateTime(Reader["StartTime"]);
                                NewDetail.StartTime = OffsetAccessTimeOnlyField(NewDetail.PlanDate, Temp);
                            }

                            if (Reader["PayrollStart"] != DBNull.Value)
                            {
                                DateTime Temp = Convert.ToDateTime(Reader["PayrollStart"]);
                                NewDetail.PayrollStart = OffsetAccessTimeOnlyField(NewDetail.PlanDate, Temp);
                            }

                            if (Reader["EndTime"] != DBNull.Value)
                            {
                                DateTime Temp = Convert.ToDateTime(Reader["EndTime"]);
                                NewDetail.EndTime = OffsetAccessTimeOnlyField(NewDetail.PlanDate, Temp);
                            }

                            _PlanDetails.Add(NewDetail);
                        }

                        Reader.Close();
                    }
                }

                Connection.Close();
            }

            _PlanDetails.Sort(new PlanDetailComparer());
        }
    }
}
