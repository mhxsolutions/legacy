using System;
using System.Web.Security;

namespace Web_App.Authentication
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Response.Redirect("~/");
        }
    }
}