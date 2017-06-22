<%@ Page Title="" Language="C#" MasterPageFile="~/UPA.master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="Web.ChangePassword" %>

<%@ Register Assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h2>Change Password</h2>
    <br />
    <br />
    <div class="contentDiv">
        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" ShowCollapseButton="false" HeaderText="Change Password" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">
                    <table style="width: 100%; border-collapse: separate; border-spacing: 8px;">
                        <tr>
                            <td colspan="2" style="text-align: center">
                                <dx:ASPxLabel ID="lbl" runat="server" Font-Bold="true"></dx:ASPxLabel>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 120px">User: </td>
                            <td>
                                <dx:ASPxTextBox ID="txtUserName" runat="server" Width="170px" ReadOnly="true">
                                </dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Old Password: </td>
                            <td>
                                <dx:ASPxTextBox ID="txtOldPassword" runat="server" Width="170px" Password="true">
                                    <ValidationSettings Display="Dynamic" ErrorText="Required.">
                                        <RequiredField IsRequired="True" ErrorText="" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>New Password: </td>
                            <td>
                                <dx:ASPxTextBox ID="txtNewPassword" runat="server" Width="170px" Password="true" MaxLength="25">
                                    <ValidationSettings Display="Dynamic" ErrorText="Required.">
                                        <RequiredField IsRequired="True" ErrorText="" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </td>
                        </tr>
                        <%--<tr>
                        <td>Confirm Password: </td>
                        <td>
                            <dx:ASPxTextBox ID="txtConfirmPassword" runat="server" Width="170px" Password="true" ValidationSettings-RequiredField-IsRequired="true">
                                <ValidationSettings Display="Dynamic" ErrorText="Confirm Password is required.">
                                    <RequiredField IsRequired="True" ErrorText="" />
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                        </td>
                    </tr>--%>
                        <tr>
                            <td></td>
                            <td>
                                <br />
                                <dx:ASPxButton ID="btnChangePassword" runat="server" Text="Change Password" OnClick="btnChangePassword_Click"></dx:ASPxButton>
                                <%--<dx:ASPxButton ID="btnClear" runat="server" Text="Clear" OnClientClick="ASPxClientEdit.ClearEditorsInContainer(null);" ></dx:ASPxButton>--%>
                            </td>
                        </tr>
                    </table>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>
    </div>



</asp:Content>
