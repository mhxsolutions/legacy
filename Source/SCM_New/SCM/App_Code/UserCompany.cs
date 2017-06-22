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
        string sqlText = "select top 1 D.Destination + ': ' + D.City + ', ' + ISNULL(D.State, '') AS Company from [DWS Rep Data].dbo.tbldestinationList D JOIN [DWS No Rep Data].dbo.[SCM User Details] U ON U.[Client Filter Destination Ref] = D.[Destination id] WHERE U.[User Id] = @UserName";
        string connectionString = ConfigurationManager.ConnectionStrings["DWS No Rep DataConnectionString"].ConnectionString;
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
        string sqlText = "select top 1 D.Destination + ': ' + D.City + ', ' + ISNULL(D.State, '') AS Company from [DWS Rep Data].dbo.tbldestinationList D where D.[Destination id] = @DestinationId";
        string connectionString = ConfigurationManager.ConnectionStrings["DWS No Rep DataConnectionString"].ConnectionString;
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
        string sqlText = "SELECT TOP 1 U.[Client Filter Destination Ref] AS DestinationId FROM [DWS No Rep Data].dbo.[SCM User Details] U WHERE U.[User Id]= @UserName";
        string connectionString = ConfigurationManager.ConnectionStrings["DWS No Rep DataConnectionString"].ConnectionString;
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
}