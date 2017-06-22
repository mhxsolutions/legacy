using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;

/// <summary>
/// Summary description for BasePage
/// </summary>
public class BasePage : System.Web.UI.Page
{
    private void Page_Error(object sender, EventArgs e)
    {
        Exception ex = Server.GetLastError();

        if (ex is SqlException && ex.Message.ToLower().Contains("timeout"))
        {
            Server.ClearError();
            Server.Transfer("~/Errors/TimeOutError.aspx");
        }

        // Handle specific exception.
        if (ex is HttpUnhandledException)
        {

            // Clear the error from the server.
            Server.ClearError();
        }
    }


}