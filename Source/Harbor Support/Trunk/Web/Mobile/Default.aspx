<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Mobile_Default" %>
<%@ Register Assembly="FlashControl" Namespace="RunAtServer.Web.UI.WebControls" TagPrefix="RAS" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Harbor Web (Mobile)</title>
</head>
<body>
    <form id="form1" runat="server">
        <%--
    <div>
        <h2>Harbor Web (Mobile)</h2>
        <p>Welcome to the harbor web site. Use the links that follow.</p>
        <p>
            <a href="EnterDr.aspx">Enter DR</a> | <a href="EditDr.aspx">Edit DR</a> | 
            <a href="ReportTodayDr.aspx">Report Today</a> | <a href="ReportAllDr.aspx">Report All</a><br /><br />
        </p>                
    </div>
    --%>
        <ras:flashcontrol id="FlashControl1" runat="server" movieurl="~/Mobile/Harbor DR Entry.swf"
            usejavascriptmethod="False" width="240px" height="240px">
        </ras:flashcontrol>
    </form>
</body>
</html>
