using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.Administration
{
    public partial class ManageUsers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["CompanyId"] == null)
            {
                FormsAuthentication.RedirectToLoginPage();
            }
            if (!IsPostBack)
            {
                string[] roles = System.Web.Security.Roles.GetRolesForUser(User.Identity.Name);
                if (roles.Length > 0)
                {
                    Session["Role"] = roles[0];
                }
            }

        }

        protected void gvManageUsers_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            try
            {
                var userName = Convert.ToString(e.NewValues["UserName"]);
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
            }
            catch (Exception)
            {
                throw;
            }
        }

        protected void gvManageUsers_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            string userId = Convert.ToString(e.Keys[gvManageUsers.KeyFieldName]);
            if (!string.IsNullOrWhiteSpace(userId))
            {
                try
                {
                    MembershipUser Details = Membership.GetUser(new Guid(userId), false);
                    UserCompany.DeleteClientUser(Details.UserName);
                    bool NoMember = Details == null || Membership.DeleteUser(Details.UserName, true);
                }
                catch { }
            }
        }


    }
}