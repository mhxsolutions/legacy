using DevExpress.Web;
using System;
using System.Web.Security;
using System.Web.UI.WebControls;
using System.Linq;

namespace Web.Administration
{
    public partial class AdministerUsers : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void grdUsers_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            string userId = Convert.ToString(e.Keys[grdUsers.KeyFieldName]);
            if (!string.IsNullOrWhiteSpace(userId))
            {
                try
                {
                    MembershipUser Details = Membership.GetUser(userId);
                    bool Deleted = Details == null || Membership.DeleteUser(userId, true);
                    if (!Deleted)
                    {
                        throw new Exception("User not delted for some reason");
                    }
                }
                catch
                {
                    throw;
                }
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
            else if (grdUsers.IsEditing && e.Column.Caption == "Password")
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
            else if (grdUsers.IsEditing && e.Column.FieldName == "Client")
            {
                ASPxComboBox ddlClient = (e.Editor as ASPxComboBox);
                if (ddlClient.Items.FindByText(ddlClient.Text) != null)
                {
                    ddlClient.Items.FindByText(ddlClient.Text).Selected = true;
                }
            }
        }

        protected void grdUsers_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            try
            {
                var userName = Convert.ToString(e.NewValues["UserId"]);
                var userRole = Convert.ToString(e.NewValues["UserRole"]);
                var password = Convert.ToString(e.NewValues["Password"]);
                var client = Convert.ToString(e.NewValues["Client"]);

                MembershipUser user = Membership.GetUser(userName);
                if (user == null)
                {
                    Membership.CreateUser(userName, password);
                    Roles.AddUserToRole(userName, userRole);
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

        protected void grdUsers_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            try
            {
                var userName = Convert.ToString(e.NewValues["UserId"]);
                var userRole = Convert.ToString(e.NewValues["UserRole"]);

                MembershipUser user = Membership.GetUser(userName);
                if (user != null)
                {
                    if (!Roles.IsUserInRole(userName, userRole))
                    {
                        if (Roles.GetRolesForUser(userName).Length > 0)
                        {
                            Roles.RemoveUserFromRoles(userName, Roles.GetRolesForUser(userName));
                        }
                        Roles.AddUserToRole(userName, userRole);
                    }
                }
                else
                {
                    user = Membership.CreateUser(userName, "password");
                    Roles.AddUserToRole(userName, "Users");
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