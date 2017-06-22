<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AP.aspx.cs" Inherits="AP_AP" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>AP Summary</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h3>
            AP</h3>
        <br />
        <table>
            <tr>
                <td style="width: 74px; height: 48px">
                    <strong><span style="font-size: 14pt">90</span></strong></td>
                <td style="width: 121px; height: 48px">
                    
                </td>
            </tr>
            <tr>
                <td style="width: 74px">
                    <strong><span style="font-size: 14pt">60</span></strong></td>
                <td style="width: 121px">
                </td>
            </tr>
            <tr>
                <td style="width: 74px">
                    <strong><span style="font-size: 14pt">45</span></strong></td>
                <td style="width: 121px">
                </td>
            </tr>
            <tr>
                <td style="width: 74px">
                    <strong><span style="font-size: 14pt">30</span></strong></td>
                <td style="width: 121px">
                </td>
            </tr>
            <tr>
                <td style="width: 74px">
                    <strong><span style="font-size: 14pt">Current</span></strong></td>
                <td style="width: 121px">
                </td>
            </tr>
            <tr>
                <td style="width: 74px; height: 90px">
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="AP ID"
                        DataSourceID="SqlDataSource1">
                        <Columns>
                            <asp:BoundField DataField="AP Date" DataFormatString="{0:d}" HeaderText="AP Date"
                                HtmlEncode="False" SortExpression="AP Date" />
                        </Columns>
                    </asp:GridView>
                </td>
                <td style="width: 121px; height: 90px">
                    &nbsp;
                </td>
            </tr>
        </table>
    
    </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ExecConnectionString %>"
            SelectCommand="SELECT * FROM [AP Current]"></asp:SqlDataSource>
        <br />
        Key:<br />
        Green AP: 550K-700K<br />
        90 day 3%<br />
        60 day 3%<br />
        45 day 5%<br />
        30 day 34%<br />
        current 55%
    </form>
</body>
</html>
