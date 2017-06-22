using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Web_App.Authentication
{
    public partial class Login : System.Web.UI.Page
    {
        private const int BudwayDestinationId = 166073081;
        private const string ContextClientId = "CONTEXT_CLIENTID";
        private const string ContextLoginId = "CONTEXT_LOGINID";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            Login1.Focus();
        }

        protected void Login1_OnLoggedIn(object sender, EventArgs e)
        {
            var connectionSettings = ConfigurationManager.ConnectionStrings["DWS No Rep DataConnectionString"];
            using (var connection = new SqlConnection(connectionSettings.ConnectionString))
            {
                using (var command = connection.CreateCommand())
                {
                    connection.Open();

                    command.CommandText = "SELECT * FROM [Cops User Details] WHERE [User Id]=@UserId";
                    command.Parameters.Add("@UserId", SqlDbType.VarChar).Value = Login1.UserName;

                    var clientIdForSession = BudwayDestinationId;

                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            clientIdForSession = Convert.ToInt32(reader["Client Filter Destination Ref"]);
                            break;
                        }

                        reader.Close();
                    }

                    Session[ContextClientId] = clientIdForSession;
                    Session[ContextLoginId] = Login1.UserName;
                    connection.Close();
                }
            }
        }
    }
}