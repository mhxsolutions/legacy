<%@ Page Language="C#" MasterPageFile="~/Dashboards.master" AutoEventWireup="true"
    CodeFile="DashboardRealTimeDwellTimes.aspx.cs" Inherits="DashboardRealTimeDwellTimes"
    Title="Budway Dwell Times" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table cellpadding="2">
        <tr>
            <td style="width: 100px">
                
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
                
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
                
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
                
            </td>
        </tr>
    </table>
    <br />
    &nbsp;<br />
    <br />
    <br />
    <br />
    <br />
    <asp:SqlDataSource ID="BudwayTruckingDwell" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Client Name], Dwell FROM [Agilis Budway Dwell Summary v2] WHERE (CONVERT (DATETIME, Date) >= CONVERT (DATETIME, CONVERT (VARCHAR(10), GETDATE(), 1))) AND ([Client ID] = 166073081) GROUP BY [Client Name], Dwell">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="BudwayYardDwell" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Client Name], Dwell FROM [Agilis Budway Dwell Summary v2] WHERE (CONVERT (DATETIME, Date) >= CONVERT (DATETIME, CONVERT (VARCHAR(10), GETDATE(), 1))) AND ([Client ID] = 2145208628) GROUP BY [Client Name], Dwell">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="BudwayTrackFiveDwell" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Client Name], Dwell FROM [Agilis Budway Dwell Summary v2] WHERE (CONVERT (DATETIME, Date) >= CONVERT (DATETIME, CONVERT (VARCHAR(10), GETDATE(), 1))) AND ([Client ID] = 2145215059) GROUP BY [Client Name], Dwell">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="BudwayCompositeDwell" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT Date, Dwell FROM [Agilis Budway Dwell Summary] WHERE (CONVERT (DATETIME, Date) >= CONVERT (DATETIME, CONVERT (VARCHAR(10), GETDATE(), 1)))">
    </asp:SqlDataSource>
    <br />
</asp:Content>
