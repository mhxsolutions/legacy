using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.ApplicationBlocks.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

/// <summary>
/// Summary description for LoginHistory
/// </summary>
public class LoginHistory
{
    public LoginHistory()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static void AddToLoginHistory(HttpContext context, string userName)
    {
        string appliationName = System.Web.Security.Membership.ApplicationName;
        //string userName = context.User.Identity.Name;
        string userRole = System.Web.Security.Roles.GetRolesForUser(userName).FirstOrDefault();
        DateTime loginDateTime = DateTime.Now;
        string ipAddress = context.Request.UserHostAddress;
        string browser = context.Request.Browser.Browser != null ? context.Request.Browser.Browser : string.Empty;
        string otherInfo = context.Request.UserAgent;
        bool isMobile = context.Request.Browser.IsMobileDevice;

        InsertIntoTableLoginHistory(userName, userRole, loginDateTime, ipAddress, browser, otherInfo, isMobile);
    }

    private static void InsertIntoTableLoginHistory(string userName, string userRole, DateTime loginDateTime, string ipAddress, string browser, string otherInfo, bool isMobile)
    {
        string sqlText = "INSERT INTO [LoginHistory]([UserName],[UserRole],[LoginDateTime],[IPAddressLogin],[Browser],[OtherInfo],[ThroughMobile]) " +
         " VALUES (@UserName,@UserRole,@LoginDateTime,@IPAddressLogin,@Browser,@OtherInfo,@ThroughMobile)";
        string connectionString = ConfigurationManager.ConnectionStrings["DWS No Rep DataConnectionString"].ConnectionString;

        try
        {
            SqlHelper.ExecuteNonQuery(connectionString, System.Data.CommandType.Text, sqlText,
                new SqlParameter("@UserName", userName), new SqlParameter("@UserRole", userRole), new SqlParameter("@LoginDateTime", loginDateTime), new SqlParameter("@IPAddressLogin", ipAddress),
                new SqlParameter("@Browser", browser), new SqlParameter("@OtherInfo", otherInfo), new SqlParameter("@ThroughMobile", isMobile));
        }
        catch (Exception ex)
        {
            throw;
        }
    }



}