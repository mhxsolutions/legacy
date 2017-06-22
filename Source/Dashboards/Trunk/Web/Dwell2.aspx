<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Dwell2.aspx.cs" Inherits="Dwell2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<meta http-equiv="refresh" content="180" />

    <title>Dwell Today</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table style="width: 406px; background-color: black">
        <tr>
            <td style="border-left-color: black; border-bottom-color: black; width: 167px; border-top-style: groove;
                border-top-color: black; border-right-style: groove; border-left-style: groove;
                height: 165px; background-color: black; border-right-color: black; border-bottom-style: groove">
                
            </td>
            <td style="border-left-color: black; border-bottom-color: black; width: 147px; border-top-style: groove;
                border-top-color: black; border-right-style: groove; border-left-style: groove;
                height: 165px; background-color: black; border-right-color: black; border-bottom-style: groove">
                
            </td>
        </tr>
        <tr>
            <td style="border-left-color: black; border-bottom-color: black; width: 167px; border-top-style: groove;
                border-top-color: black; border-right-style: groove; border-left-style: groove;
                height: 153px; background-color: black; border-right-color: black; border-bottom-style: groove">
                
            </td>
            <td style="border-left-color: black; border-bottom-color: black; width: 147px; border-top-style: groove;
                border-top-color: black; border-right-style: groove; border-left-style: groove;
                height: 153px; background-color: black; border-right-color: black; border-bottom-style: groove">
                
            </td>
        </tr>
    </table>
        &nbsp;
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT * FROM [Gage dwell]"></asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
