<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Administration_AdministerShowSiteLog" 
    Title="BudwayDirect | Web Site Log" Codebehind="AdministerShowSiteLog.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Web Site Log</h2>
    <% 
        string LogFileName = System.IO.Path.Combine(Request.PhysicalApplicationPath, "Customer Service Web.log");
        System.IO.FileStream LogFile = System.IO.File.Open(LogFileName, System.IO.FileMode.Open, System.IO.FileAccess.Read, System.IO.FileShare.Write);
        System.IO.StreamReader LogFileReader = new System.IO.StreamReader(LogFile);
        string CurrentLine = null;
          
        while ((CurrentLine = LogFileReader.ReadLine()) != null)
        {
            Response.Write(CurrentLine);
            Response.Write("<br />");
        }
        
        LogFileReader.Close();
        LogFile.Close(); 
    %>
</asp:Content>

