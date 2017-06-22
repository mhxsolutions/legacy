using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

public partial class Dashboard_DashboardKpiThroughputDwellAndRevenue : Page
{
    private const string _Month = "SELECT AVG([Dwell]) FROM [Agilis Budway Dwell] WHERE '{0}' <= [ARV Time] AND [ARV Time] < '{1}'";

    protected void Page_Load(object sender, EventArgs e)
    {
        double TrailingDwell = 0;
        string DbServer = ConfigurationManager.AppSettings["Db1Connection"];

        using (SqlConnection Connection = new SqlConnection(DbServer))
        {
            string MonthCmd = string.Format(_Month, DateTime.Now.AddDays(-30).Date.ToString("d"), DateTime.Now.Date.AddDays(1).ToString("d"));

            Connection.Open();

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

        GaugeContainer2.CircularGauges["Default"].Pointers["Trailing"].Value = TrailingDwell;
    }
}
