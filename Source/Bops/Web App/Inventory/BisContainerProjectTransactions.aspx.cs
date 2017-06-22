using System;
using System.Web.UI.WebControls;

public partial class Inventory_BisContainerProjectTransactions : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        if (IsPostBack) return;
        _TxGridview.Sort("Tx Id", SortDirection.Ascending);
    }
}
