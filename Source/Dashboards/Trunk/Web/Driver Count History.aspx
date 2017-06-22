<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Driver Count History.aspx.cs" Inherits="Driver_Count_History" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Driver Count History</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h3>
            Driver Count 30 Day History<br />
        </h3>
        
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep 2008 %>"
            SelectCommand="SELECT Date, [Driver Ct] AS Driver_Ct, Fleet FROM [Driver Count 30 day history] WHERE (Fleet = N'Fontana') ORDER BY Date">
        </asp:SqlDataSource>
        <br />
        
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep 2008 %>"
            SelectCommand="SELECT Date, [Driver Ct] AS Driver_Ct, Fleet FROM [Driver Count 30 day history] WHERE (Fleet = N'Pittsburg') ORDER BY Date">
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
