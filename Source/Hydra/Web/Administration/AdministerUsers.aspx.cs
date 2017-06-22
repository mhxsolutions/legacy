using System;
using System.Web.Security;
using System.Web.UI.WebControls;

namespace Web.Administration
{
    public partial class AdministerUsers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var admin = User.IsInRole("Administrators");
            AddUserButton.Enabled = admin;
        }

        protected void ServerValidateUserId(object Sender, ServerValidateEventArgs E)
        {
            MembershipUser Details = Membership.GetUser(E.Value);
            E.IsValid = (Details == null);
        }

        protected void EnsureRolesExist()
        {
            var roles = new[] {"Users", "Power Users", "Administrators"};
            foreach (var role in roles)
            {
                if (Roles.RoleExists(role))
                    continue;
                Roles.CreateRole(role);
            }
        }

        protected void AddUserButton_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            // Create the roles if they don't already exist.

            EnsureRolesExist();

            // First try to add the user to the authentication store.

            var newUserId = NewUserIdTextbox.Text;
            var newPassword = NewPasswordTextbox.Text;
            var newUser = Membership.CreateUser(newUserId, newPassword);

            if (newUser != null)
            {
                var rolesToRemove = new[] {"Power Users", "Administrators"};
                var rolesToAdd = new[] {"Users"};

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

                UsersDataSource.InsertParameters["UserId"].DefaultValue = NewUserIdTextbox.Text;
                UsersDataSource.InsertParameters["Client"].DefaultValue = NewUserClientDropdown.SelectedValue;
                UsersDataSource.Insert();
            }

        }
    }
}