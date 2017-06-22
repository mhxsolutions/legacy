<%@ Page Language="C#" MasterPageFile="~/Dashboards.master" AutoEventWireup="true" 
    CodeFile="DashboardKpiThroughputDwellAndRevenue.aspx.cs" 
    Inherits="DashboardKpiThroughputDwellAndRevenue" Title="Dashboards: Throughput, Dwell, and Revenue" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table>
        <tr align="center">
            <td>
                Estimated Revenue / Planned Minute</td>
            <td style="width: 283px">
                Estimated Revenue / Actual Minute History</td>
        </tr>
        <tr align="center">
            <td>
                
                <asp:SqlDataSource ID="PlannedRevenuePerMinuteToday" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                    SelectCommand="BopsPlannedRevenuePerMinuteToday" SelectCommandType="StoredProcedure">
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="ThroughputToday" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                    SelectCommand="SELECT LogOutDate, SUM([Man Rev]) / SUM([Transit Minutes] + [Dwell Minutes]) AS Throughput FROM [Load Rev] GROUP BY LogOutDate HAVING (LogOutDate > DATEADD(d, - 15, GETDATE())) ORDER BY LogOutDate DESC">
                </asp:SqlDataSource>
            </td>
            <td style="width: 283px">
                
                <asp:SqlDataSource ID="ThroughputHistory" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                    SelectCommand="SELECT LogOutDate, SUM([Man Rev]) / SUM([Transit Minutes] + [Dwell Minutes]) AS Throughput FROM [Load Rev] GROUP BY LogOutDate HAVING (LogOutDate > DATEADD(DAY, - 30, GETDATE())) AND (LogOutDate < CONVERT (VARCHAR(15), GETDATE(), 1)) ORDER BY LogOutDate">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr align="center">
            <td>
                Budway Dwell</td>
            <td style="width: 283px">
                Budway Dwell History</td>
        </tr>
        <tr align="center">
            <td>
                
                <asp:SqlDataSource ID="BudwayDwellToday" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                    SelectCommand="SELECT Date, Dwell FROM [Agilis Budway Dwell Summary] WHERE (Date >= CONVERT (VARCHAR(30), GETDATE(), 1)) ORDER BY Date">
                </asp:SqlDataSource>
            </td>
            <td style="width: 283px">
                
                <asp:SqlDataSource ID="BudwayDwellHistory" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                    SelectCommand="SELECT Date, Dwell FROM [Agilis Budway Dwell Summary] WHERE (Date >= CONVERT (VARCHAR(30), DATEADD(DAY, - 30, GETDATE()), 1)) ORDER BY Date">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr align="center">
            <td>
                MTD and Trailing Year<br />
                Estimated Revenue / Load</td>
            <td style="width: 283px">
                MTD and Trailing Year<br />
                Estimated Revenue / Minute</td>
        </tr>
        <tr align="center">
            <td>
                
                <asp:SqlDataSource ID="RevenuePerLoadMonthToDate" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                    SelectCommand="SELECT ISNULL(SUM([Man Rev]), 0) AS Revenue, ISNULL(COUNT([Load]), 0) AS Loads, ISNULL(SUM([Man Rev]) / COUNT([Load]), 0) AS [Revenue Per Load] FROM [Load Rev] WHERE (LogOutDate >= CAST(MONTH(GETDATE()) AS VARCHAR(5)) + '/1/' + CAST(YEAR(GETDATE()) AS VARCHAR(5)))">
                </asp:SqlDataSource>
                
                <asp:SqlDataSource ID="RevenuePerLoadTrailingYear" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                    SelectCommand="SELECT ISNULL(SUM([Man Rev]), 0) AS Revenue, ISNULL(COUNT([Load]), 0) AS Loads, ISNULL(SUM([Man Rev]) / COUNT([Load]), 0) AS [Revenue Per Load] FROM [Load Rev] WHERE (LogOutDate >= DATEADD(DAY, - 365, GETDATE()))">
                </asp:SqlDataSource>
            </td>
            <td style="width: 283px">
                
                <asp:SqlDataSource ID="RevenuePerMinuteMonthToDate" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                    SelectCommand="SELECT ISNULL(SUM([Man Rev]), 0) AS Revenue, ISNULL(SUM([Transit Minutes] + [Dwell Minutes]), 0) AS Minutes, CASE ISNULL(SUM([Transit Minutes] + [Dwell Minutes]) , 0) WHEN 0 THEN 0 ELSE ISNULL(SUM([Man Rev]) , 0) / ISNULL(SUM([Transit Minutes] + [Dwell Minutes]) , 0) END AS [Revenue Per Minute] FROM [Load Rev] WHERE (LogOutDate >= CAST(MONTH(GETDATE()) AS VARCHAR(2)) + '/01/' + CAST(YEAR(GETDATE()) AS VARCHAR(4)))">
                </asp:SqlDataSource>
                
                <asp:SqlDataSource ID="RevenuePerMinuteTrailingYear" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                    SelectCommand="SELECT ISNULL(SUM([Man Rev]), 0) AS Revenue, ISNULL(SUM([Transit Minutes] + [Dwell Minutes]), 0) AS Minutes, CASE ISNULL(SUM([Transit Minutes] + [Dwell Minutes]) , 0) WHEN 0 THEN 0 ELSE ISNULL(SUM([Man Rev]) , 0) / ISNULL(SUM([Transit Minutes] + [Dwell Minutes]) , 0) END AS [Revenue Per Minute] FROM [Load Rev] WHERE (LogOutDate >= DATEADD(DAY, - 365, GETDATE()))">
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
</asp:Content>

