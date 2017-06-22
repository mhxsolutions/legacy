using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using System.Data.SqlClient;
using System.Configuration;
using Microsoft.ApplicationBlocks.Data;
using System.ComponentModel;

public partial class SaveLayoutControl : System.Web.UI.UserControl
{
    public string GridViewID { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindSettingNames();
        }
    }
    protected void btnLoadLayout_Click(object sender, EventArgs e)
    {
        ASPxGridView grid = GetGridView();
        if (grid != null)
        {
            grid.LoadClientLayout(UserGridSettingsData.GetUserGridSettings(grid.ID, cmbLayout.Text));
        }
    }
    protected void btnSaveLayout_Click(object sender, EventArgs e)
    {
        ASPxGridView grid = GetGridView();
        if (grid != null)
        {
            UserGridSettingsData.SaveUserGridSettings(grid.ID, cmbLayout.Text, grid.SaveClientLayout());
            BindSettingNames();
        }
    }
    private void BindSettingNames()
    {
        ASPxGridView grid = GetGridView();
        if (grid != null)
        {
            DataSet ds = UserGridSettingsData.GetUserGridSettingNames(grid.ID);
            cmbLayout.DataSource = ds;
            cmbLayout.TextField = cmbLayout.ValueField = "SettingName";
            cmbLayout.DataBind();
        }
    }

    private ASPxGridView GetGridView()
    {
        return (ASPxGridView)this.Parent.FindControl(GridViewID);
    }
}


/// <summary>
/// Summary description for UserGridSettingsData
/// </summary>
public class UserGridSettingsData
{
    private UserGridSettingsData()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static void SaveUserGridSettings(string gridName, string settingName, string setting)
    {
        if (HttpContext.Current.User.Identity.IsAuthenticated)
        {
            try
            {
                string page = HttpContext.Current.Request.Url.LocalPath;

                string sql = @"IF NOT EXISTS(SELECT 1 FROM UserGridSetting 
                                WHERE ApplicationName = @ApplicationName AND UserName = @UserName AND Page = @Page AND GridName = @GridName AND SettingName = @SettingName)

                                INSERT INTO UserGridSetting 
                                (ApplicationName, UserName, Page, GridName, SettingName, Setting)
                                VALUES
                                (@ApplicationName, @UserName, @Page, @GridName, @SettingName, @Setting)

                                ELSE

                                UPDATE UserGridSetting SET
                                Setting = @Setting
                                WHERE ApplicationName = @ApplicationName AND UserName = @UserName AND Page = @Page AND GridName = @GridName AND SettingName = @SettingName";

                List<SqlParameter> sqlParams = new List<SqlParameter>();
                sqlParams.Add(new SqlParameter("@ApplicationName", System.Web.Security.Membership.ApplicationName));
                sqlParams.Add(new SqlParameter("@UserName", HttpContext.Current.User.Identity.Name));
                sqlParams.Add(new SqlParameter("@Page", page));
                sqlParams.Add(new SqlParameter("@GridName", gridName));
                sqlParams.Add(new SqlParameter("@SettingName", settingName));
                sqlParams.Add(new SqlParameter("@Setting", setting));


                string connectionString = ConfigurationManager.ConnectionStrings["DWS No Rep DataConnectionString"].ConnectionString;

                int recordsEffected = SqlHelper.ExecuteNonQuery(connectionString, System.Data.CommandType.Text, sql, sqlParams.ToArray());
            }
            catch (Exception ex)
            {

            }
        }
    }
    public static string GetUserGridSettings(string gridName, string settingName)
    {
        string setting = string.Empty;

        if (HttpContext.Current.User.Identity.IsAuthenticated)
        {
            try
            {
                string page = HttpContext.Current.Request.Url.LocalPath;

                string sql = string.Format(@"SELECT Setting FROM UserGridSetting 
                            WHERE ApplicationName = '{0}' AND UserName = '{1}' AND Page = '{2}' AND GridName = '{3}' AND SettingName = '{4}'",
                                System.Web.Security.Membership.ApplicationName, HttpContext.Current.User.Identity.Name, page, gridName, settingName);

                string connectionString = ConfigurationManager.ConnectionStrings["DWS No Rep DataConnectionString"].ConnectionString;

                setting = Convert.ToString(SqlHelper.ExecuteScalar(connectionString, System.Data.CommandType.Text, sql));
            }
            catch (Exception ex)
            { }
        }
        return setting;
    }

    public static DataSet GetUserGridSettingNames(string gridName)
    {
        DataSet ds = new DataSet();

        if (HttpContext.Current.User.Identity.IsAuthenticated)
        {
            try
            {
                string page = HttpContext.Current.Request.Url.LocalPath;

                string sql = string.Format(@"SELECT SettingName FROM UserGridSetting 
                            WHERE ApplicationName = '{0}' AND UserName = '{1}' AND Page = '{2}' AND GridName = '{3}'",
                                System.Web.Security.Membership.ApplicationName, HttpContext.Current.User.Identity.Name, page, gridName);

                string connectionString = ConfigurationManager.ConnectionStrings["DWS No Rep DataConnectionString"].ConnectionString;

                ds = SqlHelper.ExecuteDataset(connectionString, System.Data.CommandType.Text, sql);
            }
            catch (Exception ex)
            { }
        }
        return ds;
    }

}