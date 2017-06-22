using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SCM
{
    public partial class _Default : BasePage
    {
        private const int _BudwayDestinationId = 166073081;
        private const string _ContextClientId = "CONTEXT_CLIENTID";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            SCMLogin.Focus();
        }

        protected void SCMLogin_LoggedIn(object sender, EventArgs e)
        {
            LoginHistory.AddToLoginHistory(Context, SCMLogin.UserName);

            string destinationId = UserCompany.GetDestinationIdByUserName(SCMLogin.UserName);
            if (!string.IsNullOrWhiteSpace(destinationId))
            {
                Session[_ContextClientId] = destinationId;
            }
            else
            {
                Session[_ContextClientId] = _BudwayDestinationId;
            }
            string companyId = UserCompany.GetCompanyIdByUserName(SCMLogin.UserName);
            Session["CompanyId"] = companyId;
            Session["CURRENT_COMPANY_NAME"] = null;
        }

    } 
}