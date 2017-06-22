using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Security;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.Authentication
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                txtUserName.Text = User.Identity.Name;
            }
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            if (txtNewPassword.Text.Trim().Length < Membership.MinRequiredPasswordLength)
            {
                lbl.Text = string.Format("Password lenth must be at least {0} character long.", Membership.MinRequiredPasswordLength);
                lbl.ForeColor = System.Drawing.Color.Red;
                return;
            }

            try
            {
                MembershipUser user = Membership.GetUser(User.Identity.Name);
                if (user != null)
                {
                    bool updated = user.ChangePassword(txtOldPassword.Text, txtNewPassword.Text.Trim());
                    if (updated)
                    {
                        lbl.Text = "Password Changed Successfully!";
                        lbl.ForeColor = System.Drawing.Color.Green;
                    }
                    else
                    {
                        lbl.Text = "Old Password is Incorrect!";
                        lbl.ForeColor = System.Drawing.Color.Red;
                    }
                }
            }
            catch (Exception ex)
            {
                lbl.Text = "Error Occured: " + ex.Message;
                lbl.ForeColor = System.Drawing.Color.Red;
            }
        }

        private void CreateRole()
        {
            if (!System.Web.Security.Roles.GetAllRoles().Contains("Power Users"))
            {
                Roles.CreateRole("Power Users");
            }
            MembershipUser user = Membership.CreateUser("puser1", "puser1@123");
            Roles.AddUserToRole("puser1", "Power Users");
        }

    }
}