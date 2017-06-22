using System;
using System.Web.UI.WebControls;

public partial class ReportTodayDr : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            GridView1.Sort("Last Update Time", SortDirection.Descending);
    }
}
