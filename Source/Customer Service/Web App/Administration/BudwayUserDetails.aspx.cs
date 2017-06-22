using System;
using System.Collections.Generic;
using System.Web.Security;
using System.Web.UI.WebControls;

// ReSharper disable CheckNamespace
public partial class Administration_BudwayUserDetails : System.Web.UI.Page
// ReSharper restore CheckNamespace
{
    protected override void OnInit(EventArgs e)
    {
        rolesCheckboxlist.Items.Clear();
        string[] roleNames = Roles.GetAllRoles();
        foreach (string roleName in roleNames)
        {
            ListItem newItem = new ListItem(roleName);
            rolesCheckboxlist.Items.Add(newItem);
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack) return;

        string userId = Request.Params["userId"];
        if (string.IsNullOrEmpty(userId))
            return;

        MembershipUserCollection users = Membership.FindUsersByName(userId);
        if (users.Count != 1)
            return;
        MembershipUser user = users[userId];
        if (user == null)
            return;

        string[] roles = Roles.GetRolesForUser(userId);
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

        string userId = idLabel.Text;
        string[] userIdArray = new string[1] { userId };

        MembershipUserCollection users = Membership.FindUsersByName(userId);
        if (users.Count != 1)
            return;
        MembershipUser user = users[userId];
        if (user == null)
            return;
        string[] roles = Roles.GetRolesForUser(userId);

        // Update the roles using the membersihp provider first.

        foreach (ListItem item in rolesCheckboxlist.Items)
        {
            bool userInRole = ((IList<string>)roles).Contains(item.Text);

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
