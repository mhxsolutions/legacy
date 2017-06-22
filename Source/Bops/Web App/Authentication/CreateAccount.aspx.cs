using System;
using System.Web.Security;

public partial class Authentication_CreateAccount : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    // Roles can persist in the database, based on a user's name, even after he is deleted. Thus,
    // we need to strip all roles but the "Users" role and make sure said user has that one.

    protected void CreateUserWizard1_CreatedUser(object sender, EventArgs e)
    {
        string[] RolesToRemove = new string[] {"Power Users", "Administrators"};
        string[] RolesToAdd = new string[] {"Users"};

        foreach (string s in RolesToRemove)
        {
            if (Roles.RoleExists(s) && Roles.IsUserInRole(CreateUserWizard1.UserName, s))
                Roles.RemoveUserFromRole(CreateUserWizard1.UserName, s);
        }

        foreach (string s in RolesToAdd)
        {
            if (Roles.RoleExists(s) && !Roles.IsUserInRole(CreateUserWizard1.UserName, s))
                Roles.AddUserToRole(CreateUserWizard1.UserName, s);
        }
    }
}
