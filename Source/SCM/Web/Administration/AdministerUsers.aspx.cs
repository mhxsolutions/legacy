using DevExpress.Web;
using System;
using System.Web.Security;
using System.Web.UI.WebControls;
using System.Linq;

namespace Web.Administration
{
    public partial class AdministerUsers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var admin = User.IsInRole("Administrators");
            //AddUserButton.Enabled = admin;
        }

        //protected void ServerValidateUserId(object Sender, ServerValidateEventArgs E)
        //{
        //    MembershipUser Details = Membership.GetUser(E.Value);
        //    E.IsValid = (Details == null);
        //}

        //protected void EnsureRolesExist()
        //{
        //    var roles = new[] { "Users", "Power Users", "Administrators" };
        //    foreach (var role in roles)
        //    {
        //        if (Roles.RoleExists(role))
        //            continue;
        //        Roles.CreateRole(role);
        //    }
        //}

        //protected void AddUserButton_Click(object sender, EventArgs e)
        //{
        //    if (!Page.IsValid)
        //        return;

        //    // Create the roles if they don't already exist.

        //    EnsureRolesExist();

        //    // First try to add the user to the authentication store.

        //    var newUserId = NewUserIdTextbox.Text;
        //    var newPassword = NewPasswordTextbox.Text;
        //    var newUser = Membership.CreateUser(newUserId, newPassword);

        //    if (newUser != null)
        //    {
        //        var rolesToRemove = new[] { "Power Users", "Administrators" };
        //        var rolesToAdd = new[] { "Users" };

        //        foreach (var s in rolesToRemove)
        //        {
        //            if (Roles.RoleExists(s) && Roles.IsUserInRole(newUserId, s))
        //                Roles.RemoveUserFromRole(newUserId, s);
        //        }

        //        foreach (var s in rolesToAdd)
        //        {
        //            if (Roles.RoleExists(s) && !Roles.IsUserInRole(newUserId, s))
        //                Roles.AddUserToRole(newUserId, s);
        //        }

        //        UsersDataSource.InsertParameters["UserId"].DefaultValue = NewUserIdTextbox.Text;
        //        UsersDataSource.InsertParameters["Client"].DefaultValue = NewUserClientDropdown.SelectedValue;
        //        UsersDataSource.Insert();
        //    }

        //}

        protected void grdUsers_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            string userId = Convert.ToString(e.Keys[grdUsers.KeyFieldName]);
            if (!string.IsNullOrWhiteSpace(userId))
            {
                try
                {
                    MembershipUser Details = Membership.GetUser(userId);
                    bool NoMember = Details == null || Membership.DeleteUser(userId, true);
                }
                catch { }
            }
        }

        protected void grdUsers_CellEditorInitialize(object sender, ASPxGridViewEditorEventArgs e)
        {
            if (grdUsers.IsEditing && e.Column.FieldName == "UserId")
            {
                ASPxTextBox txtUserId = (e.Editor as ASPxTextBox);
                if (grdUsers.IsNewRowEditing)
                {
                    txtUserId.ReadOnly = false;
                }
                else
                {
                    txtUserId.ReadOnly = true;
                }
            }
            if (grdUsers.IsEditing && e.Column.Caption == "Password")
            {
                ASPxTextBox txtPassword = (e.Editor as ASPxTextBox);
                txtPassword.Password = true;
                if (grdUsers.IsNewRowEditing)
                {
                    txtPassword.Enabled = true;
                    txtPassword.Text = string.Empty;
                    txtPassword.ValidationSettings.RequiredField.IsRequired = true;
                }
                else
                {
                    txtPassword.Enabled = false;
                    txtPassword.BackColor = System.Drawing.Color.FromArgb(179, 231, 255);
                    //(grdUsers.Columns["Password"] as GridViewDataTextColumn).EditFormSettings.Caption = "Testing";
                    txtPassword.ValidationSettings.RequiredField.IsRequired = false;
                }
            }
        }

        protected void grdUsers_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            try
            {
                var userName = Convert.ToString(e.NewValues["UserId"]);
                var password = Convert.ToString(e.NewValues["Password"]);
                var client = Convert.ToString(e.NewValues["Client"]);

                MembershipUser user = Membership.GetUser(userName);
                if (user == null)
                {
                    Membership.CreateUser(userName, password);
                    string[] roles = Roles.GetAllRoles();
                    if (!roles.Contains("Users"))
                    {
                        Roles.CreateRole("Users");
                    }
                    Roles.AddUserToRole(userName, "Users");
                }
                else
                {
                    e.Cancel = true;
                    throw new Exception("User Id already exists. Please try with different Id.");
                }
            }
            catch (Exception)
            {
                throw;
            }
        }

        protected void grdUsers_CustomButtonInitialize(object sender, ASPxGridViewCustomButtonEventArgs e)
        {

        }

        protected void grdUsers_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            try
            {
                string parameters = e.Parameters;
                if (parameters.Contains("|"))
                {
                    string userName = parameters.Substring(0, parameters.IndexOf('|'));
                    string newPassword = parameters.Substring(parameters.IndexOf('|') + 1);
                    if (newPassword.Trim().Length < Membership.MinRequiredPasswordLength)
                    {
                        throw new Exception(string.Format("Password lenth must be at least {0} character long.", Membership.MinRequiredPasswordLength));
                    }
                    MembershipUser user = Membership.GetUser(userName);
                    if (user != null)
                    {
                        user.ChangePassword(user.ResetPassword(), newPassword);
                    }
                }
            }
            catch (Exception ex)
            {
                throw;
            }
        }
    }
}