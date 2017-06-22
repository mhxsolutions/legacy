<%@ Page Language="C#" AutoEventWireup="true" CodeFile="P2P.aspx.cs" Inherits="P2P" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>P2P minutes Today</title>
    <meta http-equiv="refresh" content="180" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT [P2P today] AS P2P_today FROM [Gage P2P today]"></asp:SqlDataSource>
        <br />
        <a href="http://budwaydirect.com/reports/driver_performance.aspx">Driver Summaries</a></div>
    </form>
</body>
</html>
