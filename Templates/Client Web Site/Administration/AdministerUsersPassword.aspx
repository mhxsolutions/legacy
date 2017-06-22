<%@ Page Language="C#" MasterPageFile="~/<%= this.WebSiteShortName %>.master" AutoEventWireup="true" CodeBehind="AdministerUsersPassword.aspx.cs" 
    Inherits="Administration_AdministerUsersPassword" Title="<%= this.WebSiteShortName %> | Change Password" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <h2>Change Password</h2>
    <p>To reset the user's password, enter the new password in the field below and click the update button.</p>
    <table>
        <tr>
            <td>
                User ID:
            </td>
            <td>
                <asp:Label ID="UserIdLabel" runat="server" Text="(unknown)" />
            </td>
        </tr>
        <tr>
            <td>
                Password:
            </td>
            <td>
                <asp:TextBox ID="NewPasswordTextbox" runat="server" TextMode="Password"/>
                <asp:RequiredFieldValidator ID="NewPasswordRequiredValidator" runat="server" ControlToValidate="NewPasswordTextbox"
                    ErrorMessage="New password is required" Display="Dynamic"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Button ID="UpdateButton" runat="server" Text="Update" OnClick="UpdateButton_Click" />
            </td>
        </tr>
    </table>


</asp:Content>

