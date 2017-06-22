using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

// ReSharper disable CheckNamespace
public partial class Authentication_Login : System.Web.UI.Page
// ReSharper restore CheckNamespace
{
    private const int _BudwayDestinationId = 166073081;
    private const string _ContextClientId = "CONTEXT_CLIENTID";

    protected void Page_Load(object Sender, EventArgs E)
    {
        if (IsPostBack) return;

        _TubularTransportLogin.Focus();
    }

    protected void _TubularTransportLogin_LoggedIn(object Sender, EventArgs E)
    {
        ConnectionStringSettings ConnectionSettings = ConfigurationManager.ConnectionStrings["DWS No Rep DataConnectionString"];
        using (SqlConnection Connection = new SqlConnection(ConnectionSettings.ConnectionString))
        {
            using (SqlCommand Command = Connection.CreateCommand())
            {
                Connection.Open();

                Command.CommandText = "SELECT * FROM [TTL User Details] WHERE [User Id]=@UserId";
                Command.Parameters.Add("@UserId", SqlDbType.VarChar).Value = _TubularTransportLogin.UserName;

                int ClientIdForSession = _BudwayDestinationId;

                using (SqlDataReader Reader = Command.ExecuteReader())
                {
                    while (Reader.Read())
                    {
                        ClientIdForSession = Convert.ToInt32(Reader["Client Filter Destination Ref"]);
                        break;
                    }

                    Reader.Close();
                }

                Session[_ContextClientId] = ClientIdForSession;
                Connection.Close();
            }
        }
    }
}
