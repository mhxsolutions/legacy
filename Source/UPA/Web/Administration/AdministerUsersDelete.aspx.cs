using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Security;

// ReSharper disable CheckNamespace
public partial class Administration_AdministerUsersDelete : System.Web.UI.Page
// ReSharper restore CheckNamespace
{
    protected void Page_Load(object Sender, EventArgs E)
    {
        // Don't let anybody but an administrator use this page.

        if (!User.IsInRole("Administrators"))
            Response.Redirect("~/");

        string UserId = Request.Params["UserId"] ?? string.Empty;

        if (UserId != string.Empty)
        {
            MembershipUser Details = Membership.GetUser(UserId);
            bool NoMember = Details == null || Membership.DeleteUser(UserId, true);

            if (NoMember)
            {
                ConnectionStringSettings ConnectionSettings = ConfigurationManager.ConnectionStrings["UPA No Rep DataConnectionString"];
                using (SqlConnection Connection = new SqlConnection(ConnectionSettings.ConnectionString))
                {
                    using (SqlCommand Command = Connection.CreateCommand())
                    {
                        Connection.Open();

                        Command.CommandText = "DELETE FROM [UPA User Details] WHERE [User Id]=@UserId";
                        Command.Parameters.Add("@UserId", SqlDbType.VarChar).Value = UserId;
                        Command.ExecuteNonQuery();

                        Connection.Close();
                    }
                }
            }
        }

        Response.Redirect("AdministerUsers.aspx");
    }
}
