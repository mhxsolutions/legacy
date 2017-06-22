using System;
using System.Web.Security;

// ReSharper disable CheckNamespace
public partial class Administration_AdministerUsersPassword : System.Web.UI.Page
// ReSharper restore CheckNamespace
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        // Don't let anybody but an administrator use this page, and make sure we have a valid
        // user ID in the request parameters.

        string UserId = Request.Params["UserId"] ?? string.Empty;
        if (!User.IsInRole("Administrators") || (UserId == string.Empty))
            Response.Redirect("~/");

        if (IsPostBack) return;
        UserIdLabel.Text = UserId;
        NewPasswordTextbox.Focus();
    }

    protected void UpdateButton_Click(object Sender, EventArgs E)
    {
        try
        {
            MembershipUser Details = Membership.GetUser(UserIdLabel.Text);
            if (Details != null) 
                Details.ChangePassword(Details.ResetPassword(), NewPasswordTextbox.Text);
        }
        catch (Exception)
        {
            Response.Redirect("AdministrationError.aspx");
        }

        Response.Redirect("AdministerUsers.aspx");
    }
}
