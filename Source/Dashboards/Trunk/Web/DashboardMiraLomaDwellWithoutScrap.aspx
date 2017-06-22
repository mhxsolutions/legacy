<%@ Page Language="C#" MasterPageFile="~/Dashboards.master" AutoEventWireup="true" CodeFile="DashboardMiraLomaDwellWithoutScrap.aspx.cs" 
    Inherits="DashboardMiraLomaDwellWithoutScrap" Title="Mira Loma Dwell" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT TOP (100) PERCENT CONVERT (varchar, Planner.[Plan Date], 101) AS Date, AVG(DATEDIFF(n, [Planner Detail].[Arrive Destination], [Planner Detail].[Depart Destination])) AS Dwell FROM Planner INNER JOIN [Planner Detail] ON Planner.[Plan ID] = [Planner Detail].[Planner Ref] INNER JOIN [Drivers on Staff] ON Planner.[Driver Ref] = [Drivers on Staff].EmployeeID WHERE (Planner.[Plan Date] > DATEADD(d, - 56, GETDATE())) AND ([Planner Detail].[Dest Ref] = 24) AND (LEFT ([Planner Detail].[Load Ref], 1) <> N'p') GROUP BY CONVERT (varchar, Planner.[Plan Date], 101) HAVING (AVG(DATEDIFF(n, [Planner Detail].[Arrive Destination], [Planner Detail].[Depart Destination])) > 6)">
    </asp:SqlDataSource>
</asp:Content>
