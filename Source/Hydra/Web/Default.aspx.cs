using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Web
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsCallback && Session["CONTEXT_CLIENTID"] == null)
            {
                Response.Redirect("~/Default.aspx");
            }

            if (!IsPostBack)
            {
                lblRoles.Text = GetRoleNames();
                lblImpersonatedCompany.Text = GetImpersonatedCompanyName();
            }
        }


        private string GetRoleNames()
        {
            string roles = string.Empty;
            if (User.Identity.IsAuthenticated)
            {
                string[] currentUserRoles = System.Web.Security.Roles.GetRolesForUser();

                foreach (var item in currentUserRoles)
                {
                    roles += item + ", ";
                }
            }
            return roles.TrimEnd(' ', ',');
        }

        public string GetImpersonatedCompanyName()
        {
            string company = string.Empty;
            if (Session["CONTEXT_IMPERSONATE"] != null)
            {
                company = Convert.ToString(Session["CONTEXT_IMPERSONATE"]);
            }
            else
            {
                if (Session["CURRENT_COMPANY_NAME"] == null)
                {
                    var connectionSettings = ConfigurationManager.ConnectionStrings["DWS No Rep DataConnectionString"];
                    using (var connection = new SqlConnection(connectionSettings.ConnectionString))
                    {
                        using (var command = connection.CreateCommand())
                        {
                            connection.Open();

                            command.CommandText = "select top 1 tbldestinationList.[Destination id] as DestinationId, [DWS Rep Data].dbo.tbldestinationList.Destination + ': ' + [DWS Rep Data].dbo.tbldestinationList.City + ', ' + ISNULL([DWS Rep Data].dbo.tbldestinationList.State, '') AS Company from [DWS Rep Data].dbo.tbldestinationList where [DWS Rep Data].dbo.tbldestinationList.[Destination id] = @destinationId";
                            command.Parameters.Add("@destinationId", SqlDbType.VarChar).Value = Convert.ToString(Session["CONTEXT_CLIENTID"]);


                            using (var reader = command.ExecuteReader())
                            {
                                while (reader.Read())
                                {
                                    company = Convert.ToString(reader["Company"]);
                                    break;
                                }
                                reader.Close();
                            }

                            Session["CURRENT_COMPANY_NAME"] = company;
                            connection.Close();
                        }
                    }
                }
                else
                {
                    company = Convert.ToString(Session["CURRENT_COMPANY_NAME"]);
                }
            }
            return company;
        }
    }
}