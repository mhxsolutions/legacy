using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

public partial class DashboardKpiLoadCountAndRevenue : Page
{
    private const double _MinutesPerHour = 60.0;

    protected void Page_Load(object sender, EventArgs e)
    {
        string DbServer = ConfigurationManager.AppSettings["Db1Connection"];

        using (SqlConnection Connection = new SqlConnection(DbServer))
        {
            using (SqlCommand GetCurrentMonthData = new SqlCommand("KpiLoadCountAndRevenueForTimespan", Connection))
            {
                DateTime EndDate = DateTime.Now;
                DateTime BeginDate = new DateTime(EndDate.Year, EndDate.Month, 1);
                
                GetCurrentMonthData.CommandType = System.Data.CommandType.StoredProcedure;
                GetCurrentMonthData.Parameters.AddWithValue("@BeginDate", BeginDate);
                GetCurrentMonthData.Parameters.AddWithValue("@EndDate", EndDate);
                Connection.Open();

                using (SqlDataReader Reader = GetCurrentMonthData.ExecuteReader())
                {
                    if (Reader.Read())
                    {
                        double Revenue = Convert.ToDouble(Reader["Gross Revenue"]);
                        int LoadCount = Convert.ToInt32(Reader["Load Count"]);
                        int TransitMinutes = Convert.ToInt32(Reader["Total Transit Minutes"]);
                        int DetentionMinutes = Convert.ToInt32(Reader["Total Detention Minutes"]);
                        double TotalHours = (TransitMinutes + DetentionMinutes) / _MinutesPerHour;

                        GaugeContainer1.CircularGauges["Default"].Pointers["Default"].Value = Revenue / LoadCount;
                        GaugeContainer1.NumericIndicators["NumericIndicator1"].Value = Revenue;
                        GaugeContainer1.NumericIndicators["NumericIndicator2"].Value = LoadCount;
                        GaugeContainer3.CircularGauges["Default"].Pointers["Default"].Value = Revenue / TotalHours;
                        GaugeContainer3.NumericIndicators["NumericIndicator1"].Value = Revenue;
                        GaugeContainer3.NumericIndicators["NumericIndicator2"].Value = TotalHours;
                    }

                    Reader.Close();
                }

                Connection.Close();
            }
        }

        using (SqlConnection Connection = new SqlConnection(DbServer))
        {
            using (SqlCommand GetTrailingYearData = new SqlCommand("KpiLoadCountAndRevenueForTimespan", Connection))
            {
                DateTime EndDate = DateTime.Now;
                DateTime BeginDate = EndDate.AddDays(-365);

                GetTrailingYearData.CommandType = System.Data.CommandType.StoredProcedure;
                GetTrailingYearData.Parameters.AddWithValue("@BeginDate", BeginDate);
                GetTrailingYearData.Parameters.AddWithValue("@EndDate", EndDate);
                Connection.Open();

                using (SqlDataReader Reader = GetTrailingYearData.ExecuteReader())
                {
                    if (Reader.Read())
                    {
                        double Revenue = Convert.ToDouble(Reader["Gross Revenue"]);
                        int LoadCount = Convert.ToInt32(Reader["Load Count"]);
                        int TransitMinutes = Convert.ToInt32(Reader["Total Transit Minutes"]);
                        int DetentionMinutes = Convert.ToInt32(Reader["Total Detention Minutes"]);
                        double TotalHours = (TransitMinutes + DetentionMinutes) / _MinutesPerHour;

                        GaugeContainer2.CircularGauges["Default"].Pointers["Default"].Value = Revenue / LoadCount;
                        GaugeContainer2.NumericIndicators["NumericIndicator1"].Value = Revenue;
                        GaugeContainer2.NumericIndicators["NumericIndicator2"].Value = LoadCount;
                        GaugeContainer4.CircularGauges["Default"].Pointers["Default"].Value = Revenue / TotalHours;
                        GaugeContainer4.NumericIndicators["NumericIndicator1"].Value = Revenue;
                        GaugeContainer4.NumericIndicators["NumericIndicator2"].Value = TotalHours;
                    }

                    Reader.Close();
                }

                Connection.Close();
            }
        }
    }
}
