using System;
using System.Collections.Generic;
using System.Web.Security;
using System.Web.UI.WebControls;

namespace Web_App.Administration
{
    public partial class BudwayUserDetails : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            rolesCheckboxlist.Items.Clear();
            var roleNames = Roles.GetAllRoles();
            foreach (var roleName in roleNames)
            {
                var newItem = new ListItem(roleName);
                rolesCheckboxlist.Items.Add(newItem);
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            var userId = Request.Params["userId"];
            if (string.IsNullOrEmpty(userId))
                Response.Redirect("BudwayUsers.aspx");

            var users = Membership.FindUsersByName(userId);
            if (users.Count != 1)
                return;
            var user = users[userId];
            if (user == null)
                return;

            var roles = Roles.GetRolesForUser(userId);
            idLabel.Text = user.UserName;
            emailLabel.Text = user.Email;

            foreach (ListItem item in rolesCheckboxlist.Items)
            {
                item.Selected = ((IList<string>)roles).Contains(item.Text);
            }
        }

        protected void updateButton_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            var userId = idLabel.Text;
            var userIdArray = new string[] { userId };

            var users = Membership.FindUsersByName(userId);
            if (users.Count != 1)
                return;
            var user = users[userId];
            if (user == null)
                return;
            var roles = Roles.GetRolesForUser(userId);

            // Update the roles using the membersihp provider first.

            foreach (ListItem item in rolesCheckboxlist.Items)
            {
                var userInRole = ((IList<string>)roles).Contains(item.Text);

                if (item.Selected && !userInRole)
                    Roles.AddUsersToRole(userIdArray, item.Text);
                if (!item.Selected && userInRole)
                    Roles.RemoveUserFromRole(userId, item.Text);
            }

            Response.Redirect("BudwayUsers.aspx");
        }

        protected void cancelButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("BudwayUsers.aspx");
        }
    }
}