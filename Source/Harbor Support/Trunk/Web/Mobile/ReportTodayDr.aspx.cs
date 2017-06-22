using System;
using System.Web;

public partial class Mobile_ReportTodayDr : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
    }
}
