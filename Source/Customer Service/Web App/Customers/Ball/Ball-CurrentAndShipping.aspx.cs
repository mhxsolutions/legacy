using System;
using System.Web.UI.WebControls;

public partial class Customers_Ball_Ball_CurrentAndShipping : System.Web.UI.Page
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        if (IsPostBack) return;
        _GridView1.Sort("Account", SortDirection.Ascending);
    }
}
