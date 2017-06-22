<%@ Page Language="C#" MasterPageFile="~/Dashboards.master" AutoEventWireup="true" CodeFile="P2Ptoday.aspx.cs" Inherits="P2Ptoday" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [P2P today] AS P2P_today FROM [Gage P2P today]"></asp:SqlDataSource>
</asp:Content>

