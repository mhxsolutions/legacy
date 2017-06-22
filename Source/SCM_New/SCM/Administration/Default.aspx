<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Web.Administration.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Administration</h1>
    <p>The following functions are available for administrators.</p>
    <p>
        <asp:HyperLink ID="AdministerUsersHyperlink" runat="server" NavigateUrl="~/Administration/AdministerUsers.aspx" Text="Administer Users" /><br />
    </p>
</asp:Content>
