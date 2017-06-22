using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using log4net;

public partial class Planning_HarborProjectPlannerNextPlannerStatus : Page
{
    private static readonly ILog _Log = LogManager.GetLogger(typeof(Planning_HarborProjectPlannerNextPlannerStatus));
    
    #region String Constants
    private const string UPDATE_PLANNER_STATUS =
        "UPDATE [Harbor Project Planner] SET [Planning Status] = ([Planning Status] + 1) % 3 WHERE PPID = '{0}'";
    #endregion        
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Params["PPID"] != null)
        {
            int PPID = Convert.ToInt32(Request.Params["PPID"]);

            if (PPID > 0)
            {
                _Log.InfoFormat("Page_Load: transitioning project with PPID {0} to next status.", PPID);
                
                string DbServer = ConfigurationManager.AppSettings["Db1Connection"];
                string Sql = string.Format(UPDATE_PLANNER_STATUS, PPID);

                using (SqlConnection Connection = new SqlConnection(DbServer))
                {
                    Connection.Open();
                    SqlCommand Select = new SqlCommand(Sql, Connection);
                    Select.ExecuteNonQuery();
                    Connection.Close();
                }
            }
        }

        string RedirectPage = "~/Planning/HarborProjectPlanner.aspx";
        _Log.DebugFormat("Page_Load: redirecting to {0}.", RedirectPage);
        Context.Response.Redirect(RedirectPage);
    }
}
