using System;
using System.Web.Security;
using System.Web.UI.WebControls;

namespace Web_App.Administration
{
    public partial class AdministerUsers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ServerValidateUserId(object sender, ServerValidateEventArgs e)
        {
            var details = Membership.GetUser(e.Value);
            e.IsValid = (details == null);
        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // First try to add the user to the authentication store.

                var newUserId = NewUserIdTextbox.Text;
                var newPassword = NewPasswordTextbox.Text;
                var newUser = Membership.CreateUser(newUserId, newPassword);

                if (newUser != null)
                {
                    var rolesToRemove = new[] { "Power Users", "Administrators" };
                    var rolesToAdd = new[] { "Users" };

                    foreach (var s in rolesToRemove)
                    {
                        if (Roles.RoleExists(s) && Roles.IsUserInRole(newUserId, s))
                            Roles.RemoveUserFromRole(newUserId, s);
                    }

                    foreach (var s in rolesToAdd)
                    {
                        if (Roles.RoleExists(s) && !Roles.IsUserInRole(newUserId, s))
                            Roles.AddUserToRole(newUserId, s);
                    }

                    CopsUsersDataSource.InsertParameters["UserId"].DefaultValue = NewUserIdTextbox.Text;
                    CopsUsersDataSource.InsertParameters["Client"].DefaultValue = NewUserClientDropdown.SelectedValue;
                    CopsUsersDataSource.Insert();
                }
            }
        }

    }
}