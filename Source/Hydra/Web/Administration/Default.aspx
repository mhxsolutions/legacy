<%@ Page Title="" Language="C#" MasterPageFile="~/Hydra.master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Web.Administration.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Administration</h1>
    <p>The following functions are available for administrators.</p>
    <p>
        <asp:HyperLink ID="AdministerUsersHyperlink" runat="server" NavigateUrl="~/Administration/AdministerUsers.aspx" Text="Administer Users" /><br />
    </p>
</asp:Content>
