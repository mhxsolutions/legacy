<%@ Page Language="C#" AutoEventWireup="true" CodeFile="workingcp.aspx.cs" Inherits="workingcp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h3>
            Working Capital<br />
        </h3>
        <table>
            <tr>
                <td style="width: 134px">
                    <strong>Cash &amp; Cash Eq</strong></td>
                <td style="width: 101px">
                    
                </td>
            </tr>
            <tr>
                <td style="width: 134px">
                    <strong>AR</strong></td>
                <td style="width: 101px">
                    
                </td>
            </tr>
            <tr>
                <td style="width: 134px">
                    <strong>AP</strong></td>
                <td style="width: 101px">
                    
                </td>
            </tr>
            <tr>
                <td style="width: 134px">
                    <strong>Working Capital</strong></td>
                <td style="width: 101px">
                    
                </td>
            </tr>
        </table>
    
    </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ExecConnectionString2 %>"
            SelectCommand="SELECT Cash, [Money Market], AR, AP, Created, Cash + [Money Market] AS CashEQ, Cash + [Money Market] + AR - AP AS WC FROM [Financials Current]">
        </asp:SqlDataSource>
        <br />
        Breaks:<br />
        <br />
        Cash and Cash EQ:
        <br />
        <ul>
            <li>Green 151k-400k&nbsp;</li>
            <li>Yellow 50k-150k</li>
        </ul>
        AR<br />
        <ul>
            <li>Yellow 901k-1200k</li>
            <li>Green 500k-900k</li>
        </ul>
        <p>
            AP</p>
        <ul>
            <li>Yellow 401k-550k</li>
            <li>Green 551k-700k</li>
            <li>Orange 701k-900k</li>
        </ul>
        <p>
            WC</p>
        <ul>
            <li>Yellow 501k-700k</li>
            <li>Green 200k-500k</li>
        </ul>
    </form>
</body>
</html>
