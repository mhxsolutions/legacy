<%@ Page Title="" Language="C#" MasterPageFile="~/CopsWeb.master" AutoEventWireup="true" 
    CodeBehind="AdministerUsersPassword.aspx.cs" Inherits="Web_App.Administration.AdministerUsersPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <h2>Change Password</h2>

    <p>
        To reset the user's password, enter the new password in the field below and click the update button.
    </p>

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
