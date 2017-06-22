using System;
using System.Web.Security;

namespace Web_App.Administration
{
    public partial class AdministerUsersPassword : System.Web.UI.Page
    {
        //private static readonly ILog _Log = LogManager.GetLogger(typeof(Administration_AdministerUsersPassword));

        protected void Page_Load(object sender, EventArgs e)
        {
            // Don't let anybody but an administrator use this page, and make sure we have a valid
            // user ID in the request parameters.

            var userId = Request.Params["UserId"] ?? string.Empty;
            if (!User.IsInRole("Administrators") || (userId == string.Empty))
                Response.Redirect("~/");

            if (!IsPostBack)
                UserIdLabel.Text = userId;
        }

        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            try
            {
                var details = Membership.GetUser(UserIdLabel.Text);
                details.ChangePassword(details.ResetPassword(), NewPasswordTextbox.Text);
                Response.Redirect("AdministerUsers.aspx");
            }
            catch (Exception ex)
            {
                // TODO: replace this when we have logging again
                //_Log.Error(ex);
            }

            Response.Redirect("AdministerError.aspx");
        }
    }
}