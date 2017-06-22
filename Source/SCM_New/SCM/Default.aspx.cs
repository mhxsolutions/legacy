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
    public partial class _Default : System.Web.UI.Page
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

            //var connectionSettings = ConfigurationManager.ConnectionStrings["DWS No Rep DataConnectionString"];
            //using (var connection = new SqlConnection(connectionSettings.ConnectionString))
            //{
            //    using (var command = connection.CreateCommand())
            //    {
            //        connection.Open();

            //        command.CommandText = "SELECT * FROM [SCM User Details] WHERE [User Id]=@UserId";
            //        command.Parameters.Add("@UserId", SqlDbType.VarChar).Value = SCMLogin.UserName;

            //        var clientIdForSession = _BudwayDestinationId;

            //        using (var reader = command.ExecuteReader())
            //        {
            //            while (reader.Read())
            //            {
            //                clientIdForSession = Convert.ToInt32(reader["Client Filter Destination Ref"]);
            //                break;
            //            }

            //            reader.Close();
            //        }

            //        Session[_ContextClientId] = clientIdForSession;
            //        connection.Close();
            //    }
            //}

            Session["CURRENT_COMPANY_NAME"] = null;
        }

    } 
}