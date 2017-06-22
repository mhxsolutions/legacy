<%@ Page Language="C#" MasterPageFile="~/TubularTransport.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Administration_Default" 
    Title="Tubular Transport | Administration" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1>Administration</h1>
    <p>The following functions are available for administrators.</p>

    <p>
        <asp:HyperLink ID="AdministerUsersHyperlink" runat="server" NavigateUrl="~/Administration/AdministerUsers.aspx" Text="Administer Users" /><br />
    </p>    
</asp:Content>
