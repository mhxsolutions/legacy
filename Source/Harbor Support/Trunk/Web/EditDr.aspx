<%@ Page Language="C#" MasterPageFile="~/HarborWeb.master" AutoEventWireup="true" CodeFile="EditDr.aspx.cs" Inherits="EditDr" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>
        Edit DR</h2>
    <p>
        Specify the DR number in the field below and click the edit button.</p>
    <asp:TextBox ID="DrTextbox" runat="server" />
    <asp:Button ID="EditButton" runat="server" Text="Edit" OnClick="EditButton_Click" />
    <asp:RequiredFieldValidator ID="DrRequiredValidator" runat="server" Display="Dynamic"
        ControlToValidate="DrTextbox" ErrorMessage="DR number is required"></asp:RequiredFieldValidator>
    <asp:CustomValidator ID="DrCustomValidator" runat="server" ControlToValidate="DrTextbox"
        Display="Dynamic" OnServerValidate="ServerValidateDrId" ErrorMessage="DR doesn't exist"></asp:CustomValidator>
    <br />
</asp:Content>

