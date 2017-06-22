using System;
using System.Web.Security;
using System.Web.UI.WebControls;

public partial class Administration_AdministerUsers : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void ServerValidateUserId(object sender, ServerValidateEventArgs e)
    {
        MembershipUser Details = Membership.GetUser(e.Value);
        e.IsValid = (Details == null);
    }

    protected void SaveButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            // First try to add the user to the authentication store.

            string NewUserId = NewUserIdTextbox.Text;
            string NewPassword = NewPasswordTextbox.Text;
            MembershipUser NewUser = Membership.CreateUser(NewUserId, NewPassword);

            if (NewUser != null)
            {
                string[] RolesToRemove = new string[] { "Power Users", "Administrators" };
                string[] RolesToAdd = new string[] { "Users" };

                foreach (string s in RolesToRemove)
                {
                    if (Roles.RoleExists(s) && Roles.IsUserInRole(NewUserId, s))
                        Roles.RemoveUserFromRole(NewUserId, s);
                }

                foreach (string s in RolesToAdd)
                {
                    if (Roles.RoleExists(s) && !Roles.IsUserInRole(NewUserId, s))
                        Roles.AddUserToRole(NewUserId, s);
                }

                CopsUsersDataSource.InsertParameters["UserId"].DefaultValue = NewUserIdTextbox.Text;
                CopsUsersDataSource.InsertParameters["Client"].DefaultValue = NewUserClientDropdown.SelectedValue;
                CopsUsersDataSource.Insert();
            }
        }
    }
}
