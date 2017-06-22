<%@ Page Language="C#" MasterPageFile="~/Dashboards.master" AutoEventWireup="true" CodeFile="DashboardHarborPlanLoadCountByDay.aspx.cs" Inherits="DashboardHarborPlanLoadCountByDay" Title="Harbor Count Projection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Harbor Project Planner Detail].Date, SUM([Harbor Project Planner Detail].[Load Ct]) AS Loads FROM [Harbor Project Planner] INNER JOIN [Harbor Project Planner Detail] ON [Harbor Project Planner].PPID = [Harbor Project Planner Detail].[PPID ref] GROUP BY [Harbor Project Planner Detail].Date HAVING ([Harbor Project Planner Detail].Date >= CONVERT (VARCHAR(15), GETDATE(), 1)) AND ([Harbor Project Planner Detail].Date < DATEADD(DAY, 14, GETDATE())) ORDER BY [Harbor Project Planner Detail].Date">
    </asp:SqlDataSource>

</asp:Content>

