<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Financial History Chart.aspx.cs" Inherits="Financial_History_Chart" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h3>
            60 Day Financial History</h3>
        <br />
        <br />
        
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ExecConnectionString %>"
            SelectCommand="SELECT [Cash], [Money Market] AS Money_Market, [AR], [AP], [Working Capital] AS Working_Capital, [Created] FROM [Financials Sorted 60 days] ORDER BY [Created]">
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
