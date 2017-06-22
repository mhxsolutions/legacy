using System;
using System.Web;
using System.Web.UI.WebControls;

public partial class Mobile_ReportAllDr : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);

        if (!IsPostBack)
            GridView1.Sort("Last Update Time", SortDirection.Descending);
    }
}
