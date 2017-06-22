using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.ApplicationBlocks.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

/// <summary>
/// Summary description for UserCompany
/// </summary>
public class UserCompany
{
    public UserCompany()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static string GetCompanyNameByUser(string userName)
    {
        string sqlText = "select top 1 D.Destination + ': ' + D.City + ', ' + ISNULL(D.State, '') AS Company from [UPA Rep Data].dbo.tbldestinationList D JOIN [UPA No Rep Data].dbo.[UPA User Details] U ON U.[Client Filter Destination Ref] = D.[Destination id] WHERE U.[User Id] = @UserName";
        string connectionString = ConfigurationManager.ConnectionStrings["UPA No Rep DataConnectionString"].ConnectionString;
        string company = string.Empty;
        try
        {
            company = Convert.ToString(SqlHelper.ExecuteScalar(connectionString, System.Data.CommandType.Text, sqlText, new SqlParameter("@UserName", userName)));
        }
        catch (Exception)
        {
            throw;
        }
        return company;
    }

    public static string GetCompanyNameByDestinationId(string destinationId)
    {
        string sqlText = "select top 1 D.Destination + ': ' + D.City + ', ' + ISNULL(D.State, '') AS Company from [UPA Rep Data].dbo.tbldestinationList D where D.[Destination id] = @DestinationId";
        string connectionString = ConfigurationManager.ConnectionStrings["UPA No Rep DataConnectionString"].ConnectionString;
        string company = string.Empty;
        try
        {
            company = Convert.ToString(SqlHelper.ExecuteScalar(connectionString, System.Data.CommandType.Text, sqlText, new SqlParameter("@DestinationId", destinationId)));
        }
        catch (Exception)
        {
            throw;
        }
        return company;
    }

    public static string GetDestinationIdByUserName(string userName)
    {
        string sqlText = "SELECT TOP 1 U.[Client Filter Destination Ref] AS DestinationId FROM [UPA No Rep Data].dbo.[UPA User Details] U WHERE U.[User Id]= @UserName";
        string connectionString = ConfigurationManager.ConnectionStrings["UPA No Rep DataConnectionString"].ConnectionString;
        string destinationId = string.Empty;
        try
        {
            destinationId = Convert.ToString(SqlHelper.ExecuteScalar(connectionString, System.Data.CommandType.Text, sqlText, new SqlParameter("@UserName", userName)));
        }
        catch (Exception)
        {
            throw;
        }
        return destinationId;
    }

    public static string GetCompanyIdByUserName(string userName)
    {
        string sqlText = @"
            SELECT CL.[Company ID Ref] AS CompanyId
            FROM [UPA No Rep Data].dbo.[UPA User Details] D
               LEFT JOIN [UPA Rep Data].[dbo].[tbldestinationList] CL ON CL.[Destination Id] = D.[Client Filter Destination Ref]
            WHERE D.[User Id]= @UserName";

        string connectionString = ConfigurationManager.ConnectionStrings["UPA No Rep DataConnectionString"].ConnectionString;
        string companyId = string.Empty;
        try
        {
            companyId = Convert.ToString(SqlHelper.ExecuteScalar(connectionString, System.Data.CommandType.Text, sqlText, new SqlParameter("@UserName", userName)));
        }
        catch (Exception)
        {
            throw;
        }
        return companyId;
    }

    public static DataTable GetClientList()
    {
        string sqlText = "SELECT DISTINCT C.[Destination id] as ClientId, C.Destination + ': ' + C.City + ', ' + ISNULL(C.State, '') as Client FROM [UPA No Rep Data].dbo.[UPA User Details] U INNER JOIN [UPA Rep Data].dbo.tbldestinationList C ON U.[Client Filter Destination Ref] = C.[Destination id] ";
        string connectionString = ConfigurationManager.ConnectionStrings["UPA No Rep DataConnectionString"].ConnectionString;
        DataSet ds = new DataSet();
        try
        {
            ds = SqlHelper.ExecuteDataset(connectionString, System.Data.CommandType.Text, sqlText);
        }
        catch (Exception)
        {
            throw;
        }
        return ds.Tables.Count > 0 ? ds.Tables[0] : null;
    }
    public static DataTable GetClientListByCompany(string companyId)
    {
        string sqlText = "SELECT DISTINCT C.[Destination id] as ClientId, C.Destination + ': ' + C.City + ', ' + ISNULL(C.State, '') as Client FROM [UPA No Rep Data].dbo.[UPA User Details] U INNER JOIN [UPA Rep Data].dbo.tbldestinationList C ON U.[Client Filter Destination Ref] = C.[Destination id] WHERE C.[Company ID Ref] = " + companyId;
        string connectionString = ConfigurationManager.ConnectionStrings["UPA No Rep DataConnectionString"].ConnectionString;
        DataSet ds = new DataSet();
        try
        {
            ds = SqlHelper.ExecuteDataset(connectionString, System.Data.CommandType.Text, sqlText);
        }
        catch (Exception)
        {
            throw;
        }
        return ds.Tables.Count > 0 ? ds.Tables[0] : null;
    }
    public static bool DeleteClientUser(string userName)
    {
        string sqlText = "DELETE [UPA No Rep Data].dbo.[UPA User Details] WHERE [User Id] = @UserName";
        string connectionString = ConfigurationManager.ConnectionStrings["UPA No Rep DataConnectionString"].ConnectionString;
        int recordEffected = 0;
        try
        {
            recordEffected = SqlHelper.ExecuteNonQuery(connectionString, System.Data.CommandType.Text, sqlText, new SqlParameter("@UserName", userName));
        }
        catch (Exception)
        {
            throw;
        }
        return recordEffected > 0 ? true : false;
    }

    public static string GetMobileNo(string userName)
    {
        string sqlText = "SELECT MobileAlias FROM [aspnetdb].[dbo].[aspnet_Users] U JOIN [aspnetdb].[dbo].[aspnet_Applications] A ON U.ApplicationId = A.ApplicationId AND A.ApplicationName = @ApplicationName AND U.UserName = @UserName";
        string connectionString = ConfigurationManager.ConnectionStrings["UPA No Rep DataConnectionString"].ConnectionString;
        string mobileNo = string.Empty;
        try
        {
            mobileNo = Convert.ToString(SqlHelper.ExecuteScalar(connectionString, System.Data.CommandType.Text, sqlText, new SqlParameter("@ApplicationName", System.Web.Security.Membership.ApplicationName), new SqlParameter("@UserName", userName)));
        }
        catch (Exception)
        {
            throw;
        }
        return mobileNo;
    }
    public static string[] GetRoles()
    {
        return System.Web.Security.Roles.GetRolesForUser().Contains("Administrators") ? System.Web.Security.Roles.GetAllRoles() : new string[] { "Users" };
    }

    public static DataTable GetCompanyList(string companyId, string role)
    {
        string sqlText = "SELECT [Company ID] AS CompanyId, [Company Name] + ' - ' + [Company City] AS CompanyName FROM [UPA No Rep Data].dbo.[Company] ";
        string connectionString = ConfigurationManager.ConnectionStrings["UPA No Rep DataConnectionString"].ConnectionString;
        DataSet ds = new DataSet();
        DataTable dt = new DataTable();
        try
        {
            ds = SqlHelper.ExecuteDataset(connectionString, System.Data.CommandType.Text, sqlText);
            if (ds != null && ds.Tables.Count > 0)
            {
                dt = ds.Tables[0];
                if (!role.Contains("Administrators"))
                {
                    DataView dv = ds.Tables[0].DefaultView;
                    dv.RowFilter = "CompanyId = " + companyId;
                    dt = dv.ToTable();
                }
            }
        }
        catch (Exception)
        {
            throw;
        }
        return dt;

    }

    public static void SaveMobileNo(string userName, string mobileNo)
    {
        string sqlText = @"UPDATE U 
	                            SET U.MobileAlias = @MobileNo
                            FROM [aspnetdb].[dbo].[aspnet_Users] U
	                            JOIN [aspnetdb].[dbo].[aspnet_Applications] A ON U.ApplicationId = A.ApplicationId
		                        AND A.ApplicationName = @ApplicationName AND U.UserName = @UserName";

        string connectionString = ConfigurationManager.ConnectionStrings["UPA No Rep DataConnectionString"].ConnectionString;
        try
        {
            SqlHelper.ExecuteNonQuery(connectionString, System.Data.CommandType.Text, sqlText, new SqlParameter("@ApplicationName", System.Web.Security.Membership.ApplicationName), new SqlParameter("@UserName", userName), new SqlParameter("@MobileNo", mobileNo));
        }
        catch (Exception)
        {
            throw;
        }
    }
    public static void SaveClient(string userName, string clientId)
    {
        string sqlText = @"IF NOT EXISTS(SELECT 1 FROM [UPA No Rep Data].dbo.[UPA User Details] U WHERE U.[User Id] = @UserName)
                            BEGIN INSERT INTO [UPA No Rep Data].dbo.[UPA User Details] VALUES (@UserName, @ClientId) END 
                            ELSE BEGIN UPDATE U SET U.[Client Filter Destination Ref] = @ClientId
                            FROM [UPA No Rep Data].dbo.[UPA User Details] U WHERE U.[User Id] = @UserName END";

        string connectionString = ConfigurationManager.ConnectionStrings["UPA No Rep DataConnectionString"].ConnectionString;
        try
        {
            SqlHelper.ExecuteNonQuery(connectionString, System.Data.CommandType.Text, sqlText, new SqlParameter("@UserName", userName), new SqlParameter("@ClientId", clientId));
        }
        catch (Exception)
        {
            throw;
        }
    }


}