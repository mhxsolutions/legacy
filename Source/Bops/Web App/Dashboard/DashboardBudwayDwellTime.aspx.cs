using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

public partial class Dashboard_DashboardBudwayDwellTime : Page
{
    private const string _Today = "SELECT AVG([Dwell]) FROM [Agilis Budway Dwell] WHERE '{0}' <= [ARV Time]";
    private const string _Month = "SELECT AVG([Dwell]) FROM [Agilis Budway Dwell] WHERE '{0}' <= [ARV Time] AND [ARV Time] < '{1}'";

    protected void Page_Load(object sender, EventArgs e)
    {
        double TodayDwell = 0, TrailingDwell = 0;
        string DbServer = ConfigurationManager.AppSettings["Db1Connection"];

        using (SqlConnection Connection = new SqlConnection(DbServer))
        {
            string TodayCmd = string.Format(_Today, DateTime.Now.Date.ToString("d"));
            string MonthCmd = string.Format(_Month, DateTime.Now.AddDays(-30).Date.ToString("d"), DateTime.Now.Date.AddDays(1).ToString("d"));

            Connection.Open();

            using (SqlCommand Select = new SqlCommand(TodayCmd, Connection))
            {
                using (SqlDataReader Reader = Select.ExecuteReader())
                {
                    if (Reader.Read() && !Reader.IsDBNull(0))
                        TodayDwell = Convert.ToDouble(Reader[0]);
                    Reader.Close();
                }
            }

            using (SqlCommand Select = new SqlCommand(MonthCmd, Connection))
            {
                using (SqlDataReader Reader = Select.ExecuteReader())
                {
                    if (Reader.Read() && !Reader.IsDBNull(0))
                        TrailingDwell = Convert.ToDouble(Reader[0]);
                    Reader.Close();
                }
            }

            Connection.Close();

        }

        GaugeContainer1.CircularGauges["Default"].Pointers["Default"].Value = TodayDwell;
        GaugeContainer1.CircularGauges["Default"].Pointers["TrailingMonth"].Value = TrailingDwell;
    }
}
