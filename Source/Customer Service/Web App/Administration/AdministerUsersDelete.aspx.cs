using System;
using System.IO;
using System.Web.Security;
using BopsDataAccess;
using NHibernate;
using NHibernateUtilities;

public partial class Administration_AdministerUsersDelete : System.Web.UI.Page
{
    private const string _DwsNoRepData = "NHibernateDwsNoRepData.xml.config";

    protected void Page_Load(object sender, EventArgs e)
    {
        // Don't let anybody but an administrator use this page.

        if (!User.IsInRole("Administrators"))
            Response.Redirect("~/");

        string UserId = Request.Params["UserId"] ?? string.Empty;

        if (UserId != string.Empty)
        {
            bool NoMember;
            MembershipUser Details = Membership.GetUser(UserId);
            if (Details != null)
                NoMember = Membership.DeleteUser(UserId, true);
            else
                NoMember = true;

            if (NoMember)
            {
                SessionManager<string> Mgr = new SessionManager<string>();
                string ConfigurationFileName = Path.Combine(Request.PhysicalApplicationPath, _DwsNoRepData);
                ISession DwsNoRepData = Mgr.AddSession(_DwsNoRepData, ConfigurationFileName);
                Mgr.BeginTransaction(_DwsNoRepData);
                CopsUserDetails UserDetails = DwsNoRepData.Get<CopsUserDetails>(UserId);
                if (UserDetails != null)
                    DwsNoRepData.Delete(UserDetails);
                Mgr.RemoveAllSessions(true);
            }
        }

        Response.Redirect("AdministerUsers.aspx");
    }
}
