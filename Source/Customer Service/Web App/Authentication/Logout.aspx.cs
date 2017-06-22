using System;
using System.Web.Security;

public partial class Authentication_Logout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        Response.Redirect("~/");
    }
}
