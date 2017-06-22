<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Staging.aspx.cs" Inherits="Staging" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Stage History</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <br />
        
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep 2008 %>"
            SelectCommand="SELECT [LogOutDate], [Percent Staged] AS Percent_Staged FROM [Coils Shipped v Staged Percent]">
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
