<%@ Page Title="" Language="C#" MasterPageFile="~/Hydra.master" AutoEventWireup="true" CodeBehind="ForgetPassword.aspx.cs" Inherits="Web.ForgetPassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <style>
        table {
        }
        td {
            padding: 3px;
        }
    </style>
    <h2>Forget Password</h2>
    <div class="contentDiv" style="text-align: center">
        <br /><br />
        <asp:PasswordRecovery ID="PasswordRecovery1" runat="server">
            <MailDefinition From="info@sc-man.com" Subject="HYDRA Forget Password" BodyFileName="EmailTemplates/PasswordRecover.txt" >
            </MailDefinition>
            <UserNameTemplate>
                <table cellspacing="0" cellpadding="1" style="border-collapse: collapse;">
                    <tr>
                        <td>
                            <table cellspacing="5"  cellpadding="3">
                                <tr>
                                    <td align="left" colspan="2">Forgot Your Password?</td>
                                </tr>
                                <tr>
                                    <td align="left" colspan="2">Enter your User Name to receive new your password on your email.</td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:Label runat="server" AssociatedControlID="UserName" ID="UserNameLabel">User Name:</asp:Label></td>
                                    <td>
                                        <asp:TextBox runat="server" ID="UserName"></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ValidationGroup="PasswordRecovery1" ToolTip="User Name is required." ID="UserNameRequired">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" colspan="2" style="color: Red;">
                                        <asp:Literal runat="server" ID="FailureText" EnableViewState="False"></asp:Literal>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" colspan="2">
                                        <asp:Button runat="server" CommandName="Submit" Text="Submit" ValidationGroup="PasswordRecovery1" ID="SubmitButton"></asp:Button>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </UserNameTemplate>
        </asp:PasswordRecovery>

    </div>




</asp:Content>
