using System;

public partial class RFS_RfsStorageBillingDetails : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        if (!IsPostBack)
        {
            _StorageBillingDetailsGridview.Sort("Billing Detail Id", System.Web.UI.WebControls.SortDirection.Ascending);
        }
    }
}
