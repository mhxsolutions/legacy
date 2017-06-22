using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Security;

public partial class RootMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public string ShowRole()
    {
        string highestRole = string.Empty;
        if (HttpContext.Current.User.Identity.IsAuthenticated)
        {
            if (HttpContext.Current.User.IsInRole("Administrators"))
            {
                highestRole = "(Administrators)";
            }
            else if (HttpContext.Current.User.IsInRole("Power Users"))
            {
                highestRole = "(Power Users)";
            }
            else if (HttpContext.Current.User.IsInRole("Users"))
            {
                highestRole = "(Users)";
            }
        }
        return highestRole;
    }

    public string GetImpersonatedCompanyName()
    {
        if (Session["CONTEXT_CLIENTID"] == null)
        {
            FormsAuthentication.SignOut();
            Response.Redirect(FormsAuthentication.LoginUrl);
        }

        string company = string.Empty;
        if (Session["CONTEXT_IMPERSONATE"] != null)
        {
            company = Convert.ToString(Session["CONTEXT_IMPERSONATE"]);
        }
        else
        {
            if (Session["CURRENT_COMPANY_NAME"] == null)
            {
                string destinationId = Convert.ToString(Session["CONTEXT_CLIENTID"]);
                company = UserCompany.GetCompanyNameByDestinationId(destinationId);
                Session["CURRENT_COMPANY_NAME"] = company;
            }
            else
            {
                company = Convert.ToString(Session["CURRENT_COMPANY_NAME"]);
            }
        }
        return company;
    }
}