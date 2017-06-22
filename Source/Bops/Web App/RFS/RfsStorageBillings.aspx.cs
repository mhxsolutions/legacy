using System;

public partial class RFS_RfsStorageBillings : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        if (!IsPostBack)
        {
            _StorageBillingsGridview.Sort("Billing Id", System.Web.UI.WebControls.SortDirection.Ascending);
        }
    }
}
