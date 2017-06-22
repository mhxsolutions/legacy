<%@ Page Title="Cops | Power Users" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Web.Power_Users.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Power Users</h1>
    <p>The following functions are available for power users.</p>
    <p>
        <asp:HyperLink ID="ImpersonateClientLink" runat="server" NavigateUrl="~/Power Users/ImpersonateClient.aspx" Text="Impersonate Client" /><br />
    </p>    
</asp:Content>
