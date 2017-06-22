using System;
using System.Web.UI.WebControls;

public partial class Administration_BisEnableProductTypes : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        if (IsPostBack) return;
        _ProductGridview.Sort("Product_Type", SortDirection.Ascending);
    }
}
