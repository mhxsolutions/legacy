using System;
using System.Web.Security;
using log4net;

public partial class Administration_AdministerUsersPassword : System.Web.UI.Page
{
    private static readonly ILog _Log = LogManager.GetLogger(typeof(Administration_AdministerUsersPassword));

    protected void Page_Load(object sender, EventArgs e)
    {
        // Don't let anybody but an administrator use this page, and make sure we have a valid
        // user ID in the request parameters.

        string UserId = Request.Params["UserId"] ?? string.Empty;
        if (!User.IsInRole("Administrators") || (UserId == string.Empty))
            Response.Redirect("~/");

        if (!IsPostBack)
            UserIdLabel.Text = UserId;
    }

    protected void UpdateButton_Click(object sender, EventArgs e)
    {
        try
        {
            MembershipUser Details = Membership.GetUser(UserIdLabel.Text);
            Details.ChangePassword(Details.ResetPassword(), NewPasswordTextbox.Text);
            Response.Redirect("AdministerUsers.aspx");
        }
        catch (Exception ex)
        {
            _Log.Error(ex);
        }

        Response.Redirect("AdministerError.aspx");
    }
}
