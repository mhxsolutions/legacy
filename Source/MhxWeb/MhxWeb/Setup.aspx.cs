using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Text;

public partial class Setup : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblMessage.Text = string.Empty;

        try
        {
            StringBuilder sb = new StringBuilder();

            sb.AppendFormat("Setup for application: {0}.{1}", Membership.ApplicationName, "<br />");

            if (!Roles.RoleExists("Administrators"))
            {
                Roles.CreateRole("Administrators");
                sb.AppendFormat("Role Created: {0}.{1}", "Administrators", "<br />");
            }
            else
            {
                sb.AppendFormat("Administrators Role already exists.{0}", "<br />");
            }

            if (!Roles.RoleExists("Power Users"))
            {
                Roles.CreateRole("Power Users");
                sb.AppendFormat("Role Created: {0}.{1}", "Power Users", "<br />");
            }
            else
            {
                sb.AppendFormat("Power Users Role already exists.{0}", "<br />");
            }

            if (!Roles.RoleExists("Users"))
            {
                Roles.CreateRole("Users");
                sb.AppendFormat("Role Created: {0}.{1}", "Users", "<br />");
            }
            else
            {
                sb.AppendFormat("Users Role already exists.{0}", "<br />");
            }

            if (System.Web.Security.Membership.FindUsersByName("DanH").Count > 0)
            {
                sb.AppendFormat("Already DanH user exists..{0}", "<br />");
            }
            else
            {
                MembershipUser newUser = System.Web.Security.Membership.CreateUser("DanH", "royalflu");
                if (newUser != null)
                {
                    sb.AppendFormat("User Created: DanH {0}", "<br />");
                    if (!Roles.IsUserInRole(newUser.UserName, "Administrators"))
                    {
                        Roles.AddUserToRole(newUser.UserName, "Administrators");
                        sb.AppendFormat("User DanH assigned to role Administrators", "<br />");
                    }
                }
            }
            lblMessage.Text = sb.ToString();
        }
        catch (Exception ex)
        {
            throw;
        }
    }
}