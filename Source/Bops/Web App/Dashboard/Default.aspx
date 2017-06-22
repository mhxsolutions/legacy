<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true"
    Inherits="Dashboard_Default" Title="BOPS | Dashboards" Codebehind="Default.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <p>
        <a href="DashboardBudwayDwellTime.aspx">Budway Dwell Time</a><br />
        <a href="DashboardKpiLoadCountAndRevenue.aspx">Revenue Per Load and Hour, Month and Year to Date</a><br />
        <a href="DashboardKpiThroughputDwellAndRevenue.aspx">Revenue Per Minute, Dwell, and Load KPIs</a>
    </p>
</asp:Content>
