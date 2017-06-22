using System;
using System.Web;
using System.Web.UI.WebControls;

public partial class Planning_ContainerProjectsSummary : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        if (IsPostBack) return;

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        _ProjectsGridview.Sort("Project Id", SortDirection.Ascending);
    }
}
