using System;

public partial class RFS_RfsStorageBillingEvents : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        if (!IsPostBack)
        {
            _EventsGridview.Sort("Time", System.Web.UI.WebControls.SortDirection.Descending);
        }
    }
}
