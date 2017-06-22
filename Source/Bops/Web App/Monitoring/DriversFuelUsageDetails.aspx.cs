using System;
using System.Web;
using System.Web.UI.WebControls;

public partial class Monitoring_DriversFuelUsageDetails : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        if (IsPostBack) return;

        DateTime DateValue = DateTime.Now.Date.AddDays(1);
        EndDateTextbox.Text = DateValue.ToString("d");
        BeginDateTextbox.Text = DateValue.AddDays(-30).ToString("d");

        DriverFuelUsageGridview.Sort("Timestamp", SortDirection.Descending);
    }
}
