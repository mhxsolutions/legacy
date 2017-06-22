<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Today.aspx.cs" Inherits="Today" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<meta http-equiv="refresh" content="180" />
    <title>Today's Performance</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table>
            <tr>
                <td colspan="2">
                    <h3 style="text-align: center">
                        Today's Operation Health</h3>
                    <h3 style="text-align: center">
                        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource4"
                            DataTextField="Fleet" DataValueField="Fleet">
                        </asp:DropDownList>&nbsp;</h3>
                </td>
            </tr>
            <tr>
                <td style="width: 194px; height: 21px">
                    <strong>Average Revenue/Truck</strong></td>
                <td style="width: 116px; height: 21px">
                    
                </td>
            </tr>
            <tr>
                <td style="width: 194px">
                    <strong><a href="http://budwaydirect.com/reports/projected_load_rev_detail.aspx">Planned Total Revenue</a></strong></td>
                <td style="width: 116px">
                    
                </td>
            </tr>
            <tr>
                <td style="width: 194px">
                    <strong>Loads without Revenue</strong></td>
                <td style="width: 116px">
                    
                </td>
            </tr>
            <tr>
                <td style="width: 194px">
                    <strong>Planned Minutes</strong></td>
                <td style="width: 116px">
                    
                </td>
            </tr>
            <tr>
                <td style="width: 194px">
                    <strong>Planned T/Min</strong></td>
                <td style="width: 116px">
                    
                </td>
            </tr>
            <tr>
                <td style="width: 194px; height: 26px;">
                    <strong>Planned Hrs/Driver</strong></td>
                <td style="width: 116px; height: 26px;">
                    
                </td>
            </tr>
            <tr>
                <td style="width: 194px">
                    <strong>Driver Count</strong></td>
                <td style="width: 116px">
                    
                </td>
            </tr>
            <tr>
                <td style="width: 194px">
                    <strong>Percent Loaded</strong></td>
                <td style="width: 116px">
                    
                </td>
            </tr>
            <tr>
                <td style="width: 194px">
                    <strong>P2P Minutes v. Plan</strong></td>
                <td style="width: 116px">
                    
                </td>
            </tr>
        </table>
    
    </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT * FROM [Gage today's revenue data] WHERE ([Fleet] = @Fleet)">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="Fleet" PropertyName="SelectedValue"
                    Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT * FROM [Gage Today's percent loaded] WHERE ([Fleet] = @Fleet)">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="Fleet" PropertyName="SelectedValue"
                    Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT * FROM [Gage P2P today fleet] WHERE ([Fleet] = @Fleet)">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="Fleet" PropertyName="SelectedValue"
                    Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT DISTINCT [Fleet] FROM [Gage today's revenue data] ORDER BY [Fleet]">
        </asp:SqlDataSource>
    </form>
</body>
</html>
