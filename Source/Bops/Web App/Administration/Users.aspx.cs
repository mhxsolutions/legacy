using System;
using System.Web.Security;

// ReSharper disable CheckNamespace
public partial class Administration_Users : System.Web.UI.Page
// ReSharper restore CheckNamespace
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack) return;

        UsersGridview.DataSource = Membership.GetAllUsers();
        UsersGridview.DataBind();
    }
}
