using System;
using System.Web.Security;
using System.Web.UI.WebControls;

// ReSharper disable CheckNamespace
public partial class Administration_AdministerUsers : System.Web.UI.Page
// ReSharper restore CheckNamespace
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        NewUserIdTextbox.Focus();
    }

    protected void ServerValidateUserId(object Sender, ServerValidateEventArgs E)
    {
        MembershipUser Details = Membership.GetUser(E.Value);
        E.IsValid = (Details == null);
    }

    protected void AddUserButton_Click(object Sender, EventArgs E)
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

                TTLUsersDataSource.InsertParameters["UserId"].DefaultValue = NewUserIdTextbox.Text;
                TTLUsersDataSource.InsertParameters["Client"].DefaultValue = NewUserClientDropdown.SelectedValue;
                TTLUsersDataSource.Insert();
            }
        }
    }
}
