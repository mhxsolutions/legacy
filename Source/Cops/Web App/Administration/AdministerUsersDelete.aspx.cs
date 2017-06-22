using System;
using System.Web.Security;

namespace Web_App.Administration
{
    public partial class AdministerUsersDelete : System.Web.UI.Page
    {
        private const string _DwsNoRepData = "NHibernateDwsNoRepData.xml.config";

        protected void Page_Load(object sender, EventArgs e)
        {
            // Don't let anybody but an administrator use this page.

            if (!User.IsInRole("Administrators"))
                Response.Redirect("~/");

            var userId = Request.Params["UserId"] ?? string.Empty;

            if (userId != string.Empty)
            {
                bool noMember;
                var details = Membership.GetUser(userId);
                if (details != null)
                    noMember = Membership.DeleteUser(userId, true);
                else
                    noMember = true;

                if (noMember)
                {
                    try
                    {
                        // The user ID will come in as a string, but that's easy because 
                        // the PK in the underlying table is also a string.

                        var rfsDataContext = TemporaryKernel.GetRfsDataContext();
                        rfsDataContext.RemoveCopsUserDetails(userId);
                    }
                    finally
                    {
                        // TODO: free the RFS data context
                    }
                }
            }

            Response.Redirect("AdministerUsers.aspx");

        }
    }
}