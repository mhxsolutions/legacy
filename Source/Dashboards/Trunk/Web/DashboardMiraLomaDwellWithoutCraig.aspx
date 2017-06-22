<%@ Page Language="C#" MasterPageFile="~/Dashboards.master" AutoEventWireup="true" CodeFile="DashboardMiraLomaDwellWithoutCraig.aspx.cs" Inherits="DashboardMiraLomaDwellWithoutCraig" Title="Mira Loma Dwell" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        
    <asp:SqlDataSource ID="MiraLomaDwellWithoutCraig" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT Date, AVG(Dwell) AS Dwell FROM [Dwell at Mira Loma] WHERE (Drivers <> 'Messina, Craig') AND (Dwell > 6) GROUP BY Date ORDER BY Date">
    </asp:SqlDataSource>

</asp:Content>

