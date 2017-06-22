using System;
using System.Web.UI.WebControls;

public partial class RFS_RfsStorageBillingRates : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        if (!IsPostBack)
        {
            StorageRatesGridview.Sort("RateId", SortDirection.Ascending);
        }
    }
}
