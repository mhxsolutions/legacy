<%@ Page Language="C#" MasterPageFile="~/TubularTransport.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Power_Users_Default" 
    Title="Tubular Transport | Power Users" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1>Power Users</h1>
    <p>The following functions are available for power users.</p>

    <p>
        <asp:HyperLink ID="ImpersonateClientLink" runat="server" NavigateUrl="~/Power Users/ImpersonateClient.aspx" Text="Impersonate Client" /><br />
    </p>    
</asp:Content>

