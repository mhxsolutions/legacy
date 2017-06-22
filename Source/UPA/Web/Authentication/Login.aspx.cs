using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Web.Authentication
{
    public partial class Login : System.Web.UI.Page
    {
        private const int _BudwayDestinationId = 2145401161;
        private const string _ContextClientId = "CONTEXT_CLIENTID";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            _HydraLogin.Focus();
        }

        protected void _HydraLogin_LoggedIn(object sender, EventArgs e)
        {
            var connectionSettings = ConfigurationManager.ConnectionStrings["UPA No Rep DataConnectionString"];
            using (var connection = new SqlConnection(connectionSettings.ConnectionString))
            {
                using (var command = connection.CreateCommand())
                {
                    connection.Open();

                    command.CommandText = "SELECT * FROM [UPA User Details] WHERE [User Id]=@UserId";
                    command.Parameters.Add("@UserId", SqlDbType.VarChar).Value = _HydraLogin.UserName;

                    var clientIdForSession = _BudwayDestinationId;

                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            clientIdForSession = Convert.ToInt32(reader["Client Filter Destination Ref"]);
                            break;
                        }

                        reader.Close();
                    }

                    Session[_ContextClientId] = clientIdForSession;
                    connection.Close();
                }
            }
            string companyId = UserCompany.GetCompanyIdByUserName(_HydraLogin.UserName);
            Session["CompanyId"] = companyId;

        }
    }
}