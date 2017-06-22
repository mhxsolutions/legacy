using System;
using System.Web.UI.WebControls;

public partial class Customers_Metal_Container_MiraLoma_CurrentAndShipping : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack) return;
        _GridView1.Sort("Account", SortDirection.Ascending);
    }
}
