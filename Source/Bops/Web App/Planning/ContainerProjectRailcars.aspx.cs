using System;
using System.Web;
using System.Web.UI.WebControls;

public partial class Planning_ContainerProjectRailcars : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        if (IsPostBack) return;
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        _AssignedGridview.Sort("Id", SortDirection.Ascending);
        _AvailableGridview.Sort("Car Number", SortDirection.Ascending);
    }

    protected void _AssignedGridview_RowDeleted(object Sender, GridViewDeletedEventArgs E)
    {
        _AvailableGridview.DataBind();
    }
}
