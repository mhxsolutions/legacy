using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using log4net;

public partial class Planning_HarborProjectPlannerConfigureProject : Page
{
    private static readonly ILog _Log = LogManager.GetLogger(typeof(Planning_HarborProjectPlannerConfigureProject));
    
    private void ConfigureControls(int PPID)
    {
        // Add the planning status items to the radio button list manually to avoid 
        // parsing complaints in the markup.

        PlanningStatus.Items.Add(new ListItem("<img src='./Images/Planning Status 0.gif'> In Development", "0", true));
        PlanningStatus.Items.Add(new ListItem("<img src='./Images/Planning Status 1.gif'> Not Yet Cleared", "1", true));
        PlanningStatus.Items.Add(new ListItem("<img src='./Images/Planning Status 2.gif'> Cleared", "2", true));

        string DbServer = ConfigurationManager.AppSettings["Db1Connection"];
        _Log.DebugFormat("ConfigureControls: using connection string: {0}", DbServer);

        using (SqlConnection Connection = new SqlConnection(DbServer))
        {
            string Query = string.Format("SELECT * FROM [Harbor Project Planner] WHERE PPID = {0}", PPID);
            SqlCommand Select = new SqlCommand(Query, Connection);
            Connection.Open();
            
            using (SqlDataReader Reader = Select.ExecuteReader())

            {
                if (Reader.Read())
                {
                    int PlanningStatusValue = Convert.ToInt32(Reader["Planning Status"]);

                    if (-1 < PlanningStatusValue && PlanningStatusValue < 3)
                    {
                        _Log.DebugFormat("ConfigureControls: Setting initial planning status to {0}", PlanningStatusValue);
                        PlanningStatus.SelectedIndex = PlanningStatusValue;
                    }
                    else
                    {
                        _Log.Warn("ConfigureControls: Invalid planning status value; leaving default selection.");
                    }
                }
                else
                {
                    _Log.WarnFormat("ConfigureControls: Could not retrieve data for PPID = {0}.", PPID);
                }

                Reader.Close();
            }
            Connection.Close();
        }
    }
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.Params["PPID"] != null)
            {
                int PPID = Convert.ToInt32(Request.Params["PPID"]);
                if (PPID > 0)
                    ConfigureControls(PPID);
            }
            else
            {
                _Log.Warn("Page_Load: No PPID in request parameters; returning to main page.");
                string RedirectPage = "~/Planning/HarborProjectPlanner.aspx";
                _Log.DebugFormat("Page_Load: redirecting to {0}.", RedirectPage);
                Context.Response.Redirect(RedirectPage);
            }
        }
    }

    protected void SaveChanges_Click(object sender, EventArgs e)
    {
        string DbServer = ConfigurationManager.AppSettings["Db1Connection"];
        _Log.DebugFormat("SaveChanges_Click: using connection string: {0}", DbServer);
        int PPID = Convert.ToInt32(Request.Params["PPID"]);

        using (SqlConnection Connection = new SqlConnection(DbServer))
        {
            string Sql = string.Format("UPDATE [Harbor Project Planner] SET [Planning Status] = '{1}', [Hidden] = '{2}' WHERE PPID = {0}", 
                                          PPID, PlanningStatus.SelectedItem.Value, HideProject.Checked ? 1 : 0);
            SqlCommand Update = new SqlCommand(Sql, Connection);
            Connection.Open();
            Update.ExecuteNonQuery();
            Connection.Close();
        }
        
        string RedirectPage = "~/Planning/HarborProjectPlanner.aspx";
        _Log.DebugFormat("ApplyFilter_Click redirecting to: {0}", RedirectPage);
        Context.Response.Redirect(RedirectPage);
    }
}
