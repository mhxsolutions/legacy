<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" Inherits="Administration_UserDetail" Title="Untitled Page" Codebehind="UserDetail.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>User Detail</h2>
    <p>
        To edit the user, make the desired changes and click the "Update User" button.
    </p>
    <table cellpadding="4" border="1">
        <tr>
            <td>ID:</td>
            <td>
                <asp:Label ID="idLabel" runat="server" Text="(unknown)" />
            </td>
        </tr>
        <tr>
            <td>Email:</td>
            <td>
                <asp:Label ID="emailLabel" runat="server" Text="(unknown)"/>
            </td>
        </tr>
        <tr>
            <td valign="top">Roles:</td>
            <td valign="top">
                <asp:CheckBoxList ID="rolesCheckboxlist" runat="server" />
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <asp:Button ID="updateButton" runat="server" Text="Update User" OnClick="updateButton_Click" />
                <span></span>
                <asp:Button ID="cancelButton" runat="server" Text="Cancel" OnClick="cancelButton_Click" />
            </td>
        </tr>
    </table>
</asp:Content>
