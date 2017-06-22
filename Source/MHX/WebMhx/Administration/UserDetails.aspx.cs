using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Administration_UserDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!User.IsInRole("Administrators"))
        {
            lblMessage.Text = "You don't have sufficient access this page.";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        if (!IsPostBack)
        {
            try
            {
                BindRoles();
                BindClients();
                BindPage();
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveChanges();
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("ManageUsers.aspx");
    }

    private void BindPage()
    {
        string userName = Request["UserName"] != null ? Request["UserName"] : string.Empty;
        if (!string.IsNullOrWhiteSpace(userName))
        {
            MembershipUser user = Membership.GetUser(userName);
            if (user != null)
            {
                lblUserName.Text = user.UserName;
                lblCreatedOn.Text = user.CreationDate.ToString();
                lblLockedOn.Text = user.LastLockoutDate.Year > 2000 ? "(Locked on: " + user.LastLockoutDate.ToString() + ")" : string.Empty;
                lblLastLogin.Text = user.LastLoginDate.ToString();
                chkApproved.Checked = user.IsApproved;
                chkLocked.Checked = user.IsLockedOut;
                chkLocked.Enabled = chkLocked.Checked;
                txtEmail.Text = user.Email;
                txtComment.Text = user.Comment;

                txtMobile.Text = UserCompany.GetMobileNo(user.UserName);


                string[] roles = Roles.GetRolesForUser(user.UserName);

                if (roles.Length > 0)
                {
                    cbRole.SelectedItem = cbRole.Items.FindByText(roles[0]);
                }
                string clientId = UserCompany.GetDestinationIdByUserName(user.UserName);
                if (cbClient.Items.FindByValue(clientId) != null)
                {
                    cbClient.SelectedItem = cbClient.Items.FindByValue(clientId);
                }
            }
            else
            {
                lblMessage.Text = "There is no such user available in database!";
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }
    }

    private void BindRoles()
    {
        cbRole.DataSource = Roles.GetAllRoles();
        cbRole.DataBind();
    }

    private void BindClients()
    {
        cbClient.DataSource = UserCompany.GetClientList();
        cbClient.ValueField = "ClientId";
        cbClient.TextField = "Client";
        cbClient.DataBind();
    }

    private void SaveChanges()
    {
        if (!User.IsInRole("Administrators"))
        {
            lblMessage.Text = "You don't have sufficient access this page.";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        string userName = lblUserName.Text;
        if (!string.IsNullOrWhiteSpace(userName))
        {
            MembershipUser user = Membership.GetUser(userName);
            if (user != null)
            {
                user.IsApproved = chkApproved.Checked;

                // Unlock
                if (user.IsLockedOut && !chkLocked.Checked)
                {
                    user.UnlockUser();
                }

                // Update Role
                if (!Roles.IsUserInRole(userName, cbRole.SelectedItem.Text))
                {
                    if (Roles.GetRolesForUser(userName).Length > 0)
                    {
                        Roles.RemoveUserFromRoles(userName, Roles.GetRolesForUser(userName));
                    }
                    Roles.AddUserToRole(userName, cbRole.SelectedItem.Text);
                }

                user.Email = txtEmail.Text.Trim();
                user.Comment = txtComment.Text.Trim();

                UserCompany.SaveMobileNo(userName, txtMobile.Text.Trim());
                UserCompany.SaveClient(userName, cbClient.SelectedItem.Value.ToString());

                Membership.UpdateUser(user);

                Response.Redirect("ManageUsers.aspx");
            }
        }
    }


}