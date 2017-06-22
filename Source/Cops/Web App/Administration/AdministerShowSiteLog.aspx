<%@ Page Title="" Language="C#" MasterPageFile="~/CopsWeb.master" AutoEventWireup="true" CodeBehind="AdministerShowSiteLog.aspx.cs" Inherits="Web_App.Administration.AdministerShowSiteLog" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <h2>Web Site Log</h2>
    <%
        var iLines = 0;

        try
        {
            var logFileName = System.IO.Path.Combine(Request.PhysicalApplicationPath, "Customer Service Web.log");
            var logFile = System.IO.File.Open(logFileName, System.IO.FileMode.Open, System.IO.FileAccess.Read, System.IO.FileShare.Write);
            var logFileReader = new System.IO.StreamReader(logFile);
            string currentLine = null;

            while ((currentLine = logFileReader.ReadLine()) != null)
            {
                iLines++;
                Response.Write(currentLine);
                Response.Write("<br />");
            }

            logFileReader.Close();
            logFile.Close();
        }
        catch
        {
            // Do nothing; we just want to add a blank page without bugging the user.
        }
        finally
        {
            if (iLines == 0)
                Response.Write("<p>Log file is empty or nonexistant.</p><br />");
        }
    %>

</asp:Content>
