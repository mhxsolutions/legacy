using DevExpress.Web;
using Microsoft.ApplicationBlocks.Data;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.Controls
{
    public partial class SaveLayout : System.Web.UI.UserControl
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
                grid.LoadClientLayout(GetUserGridSettings(grid.ID, cmbLayout.Text));
            }
        }
        protected void btnSaveLayout_Click(object sender, EventArgs e)
        {
            ASPxGridView grid = GetGridView();
            if (grid != null)
            {
                SaveUserGridSettings(grid.ID, cmbLayout.Text, grid.SaveClientLayout());
                BindSettingNames();
            }
        }
        private void BindSettingNames()
        {
            ASPxGridView grid = GetGridView();
            if (grid != null)
            {
                DataSet ds = GetUserGridSettingNames(grid.ID);
                cmbLayout.DataSource = ds;
                cmbLayout.TextField = cmbLayout.ValueField = "SettingName";
                cmbLayout.DataBind();
            }
        }

        private ASPxGridView GetGridView()
        {
            return (ASPxGridView)this.Parent.FindControl(GridViewID);
        }

        #region UserGridSettingsData

        private void SaveUserGridSettings(string gridName, string settingName, string setting)
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
        private string GetUserGridSettings(string gridName, string settingName)
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

        private DataSet GetUserGridSettingNames(string gridName)
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

        #endregion

    }
}