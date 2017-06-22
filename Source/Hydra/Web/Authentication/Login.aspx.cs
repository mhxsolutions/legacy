using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Web.Authentication
{
    public partial class Login : System.Web.UI.Page
    {
        private const int _BudwayDestinationId = 166073081;
        private const string _ContextClientId = "CONTEXT_CLIENTID";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            _HydraLogin.Focus();
        }

        protected void _HydraLogin_LoggedIn(object sender, EventArgs e)
        {

            string destinationId = UserData.GetDestinationIdByUserName(_HydraLogin.UserName);
            if (!string.IsNullOrWhiteSpace(destinationId))
            {
                Session[_ContextClientId] = destinationId;
            }
            else
            {
                Session[_ContextClientId] = _BudwayDestinationId;
            }
            string companyId = UserData.GetCompanyIdByUserName(_HydraLogin.UserName);
            Session["CompanyId"] = companyId;
            Session["CURRENT_COMPANY_NAME"] = null;


        }
    }
}