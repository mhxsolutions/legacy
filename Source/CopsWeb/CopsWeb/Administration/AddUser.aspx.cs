using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;


public partial class AddUser : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnAddUser_Click(object sender, EventArgs e)
    {
        try
        {
            MembershipUser user = Membership.GetUser(txtUserName.Text.Trim());
            if (user == null)
            {
                user = Membership.CreateUser(txtUserName.Text.Trim(), txtPassword.Text, txtEmail.Text);
                user.IsApproved = true;
                user.Comment = txtComment.Text;

                Membership.UpdateUser(user);
                Roles.AddUserToRole(user.UserName, cbRole.SelectedItem.Value.ToString());
                UserCompany.SaveClient(user.UserName, cbClient.SelectedItem.Value.ToString());
                UserCompany.SaveMobileNo(user.UserName, txtMobile.Text.Trim());

                Response.Redirect("ManageUsers.aspx");
            }
            else
            {
                lblMessage.Text = "Username already exists. Please try with different username.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }
        catch (Exception ex)
        {
            lblMessage.Text = ex.Message;
            lblMessage.ForeColor = System.Drawing.Color.Red;
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {

    }

    protected void txtConfirmedPassword_Validation(object sender, DevExpress.Web.ValidationEventArgs e)
    {
        if (e.IsValid && txtPassword.Text != txtConfirmedPassword.Text)
        {
            e.ErrorText = "Passwords do not match";
            e.IsValid = false;
        }
    }

    private void BindCompanies()
    {

    }

    private void BindClients()
    {

    }
}