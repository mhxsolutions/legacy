using System;
using System.Web.Security;
using System.Web.UI.HtmlControls;
using BopsDataConnector;

namespace Web_App
{
    public partial class BopsWeb : System.Web.UI.MasterPage
    {
        public HtmlGenericControl BodyControl
        {
            get { return MasterPageBody; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // This will ensure that the library is set never to prompt.
            BopsDataConnectorFactory.GetDataConnector(false);
        }

        protected void LogoutLinkButton_Click(object Sender, EventArgs E)
        {
            FormsAuthentication.SignOut();
            Response.Redirect("~/");
        }

        protected void ChangePasswordLinkButton_Click(object Sender, EventArgs E)
        {
            Response.Redirect("~/Authentication/ChangePassword.aspx");
        }

    }
}