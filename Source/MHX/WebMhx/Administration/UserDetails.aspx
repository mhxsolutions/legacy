<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="UserDetails.aspx.cs" Inherits="Administration_UserDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">

    <style>
        .row::after {
            content: "";
            display: block;
        }

        [class*="col-"] {
            float: left;
            padding: 5px 10px 10px 20px;
        }

        .col-1 {
            width: 8.33%;
        }

        .col-2 {
            width: 10%;
            min-width: 80px;
            font-weight: bold;
        }

        .col-3 {
            width: 25%;
        }

        .col-4 {
            width: 33.33%;
        }

        .col-5 {
            width: 41.66%;
        }

        .col-6 {
            width: 50%;
        }

        .col-7 {
            width: 58.33%;
        }

        .col-8 {
            width: 66.66%;
        }

        .col-9 {
            width: 75%;
        }

        .col-10 {
            width: 80%;
        }

        .col-11 {
            width: 91.66%;
        }

        .col-12 {
            width: 90%;
        }
    </style>

    <h2>Users Details</h2>
        <div class="row">
            <div class="col-12">
                <dx:ASPxLabel ID="lblMessage" runat="server" Text=""></dx:ASPxLabel>
            </div>
        </div>

        <div class="row">
            <div class="col-2">User Name: </div>
            <div class="col-10">
                <dx:ASPxLabel ID="lblUserName" runat="server" Text=""></dx:ASPxLabel>
            </div>
        </div>
        <div class="row">
            <div class="col-2">Created On: </div>
            <div class="col-10">
                <dx:ASPxLabel ID="lblCreatedOn" runat="server" Text=""></dx:ASPxLabel>
            </div>
        </div>

        <div class="row">
            <div class="col-2">Last Login: </div>
            <div class="col-10">
                <dx:ASPxLabel ID="lblLastLogin" runat="server" Text=""></dx:ASPxLabel>
            </div>
        </div>

        <div class="row">
            <div class="col-2">Approved: </div>
            <div class="col-10">
                <dx:ASPxCheckBox ID="chkApproved" runat="server"></dx:ASPxCheckBox>
            </div>
        </div>

        <div class="row">
            <div class="col-2">Locked: </div>
            <div class="col-10">
                <dx:ASPxCheckBox ID="chkLocked" runat="server"></dx:ASPxCheckBox>
                &nbsp;<dx:ASPxLabel ID="lblLockedOn" runat="server" Text=""></dx:ASPxLabel>
            </div>
        </div>


        <div class="row">
            <div class="col-2">Role: </div>
            <div class="col-10">
                <dx:ASPxComboBox ID="cbRole" runat="server" DropDownStyle="DropDownList" ValueType="System.String" Width="300"></dx:ASPxComboBox>
            </div>
        </div>

        <div class="row">
            <div class="col-2">Client: </div>
            <div class="col-10">
                <dx:ASPxComboBox ID="cbClient" runat="server" DropDownStyle="DropDownList" ValueType="System.String" Width="300"></dx:ASPxComboBox>
            </div>
        </div>

        <div class="row">

            <div class="col-2">Email: </div>
            <div class="col-10">
                <dx:ASPxTextBox ID="txtEmail" runat="server" Width="300px">
                    <ValidationSettings EnableCustomValidation="True" ErrorDisplayMode="Text" ErrorTextPosition="Right" SetFocusOnError="true">
                        <ErrorFrameStyle Font-Size="Smaller" />
                        <RegularExpression ValidationExpression="^\w+([-+.'%]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$"
                            ErrorText="Invalid e-mail" />
                        <RequiredField IsRequired="false" ErrorText="E-mail is required" />
                    </ValidationSettings>
                </dx:ASPxTextBox>
            </div>
        </div>

        <div class="row">

            <div class="col-2">Mobile: </div>
            <div class="col-10">
                <dx:ASPxTextBox ID="txtMobile" runat="server" MaxLength="16" Width="300px"></dx:ASPxTextBox>
            </div>
        </div>


        <div class="row">
            <div class="col-2">Comment: </div>
            <div class="col-10">
                <dx:ASPxMemo ID="txtComment" runat="server" Height="100px" Width="300px"></dx:ASPxMemo>
            </div>
        </div>

        <div class="row">
            <div class="col-2"></div>
            <div class="col-10">
                <dx:ASPxButton ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click"></dx:ASPxButton>
                <dx:ASPxButton ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click"></dx:ASPxButton>
            </div>
        </div>



        <%--        <table>
            <tr>
                <td colspan="3">
                    <dx:ASPxLabel ID="lblMessage" runat="server" Text=""></dx:ASPxLabel>
                </td>
            </tr>
            <tr>
                <td>User Name</td>
                <td>:</td>
                <td>
                    <dx:ASPxLabel ID="lblUserName" runat="server" Font-Bold="true" Text=""></dx:ASPxLabel>
                </td>
            </tr>
            <tr>
                <td>Created On</td>
                <td>:</td>
                <td>
                    <dx:ASPxLabel ID="lblCreatedOn" runat="server" Text=""></dx:ASPxLabel>
                </td>
            </tr>
            <tr>
                <td>Last Login</td>
                <td>:</td>
                <td>
                    <dx:ASPxLabel ID="lblLastLogin" runat="server" Text=""></dx:ASPxLabel>
                </td>
            </tr>
            <tr>
                <td>Approved</td>
                <td>:</td>
                <td>
                    <dx:ASPxCheckBox ID="chkApproved" runat="server"></dx:ASPxCheckBox>
                </td>
            </tr>
            <tr>
                <td>Locked</td>
                <td>:</td>
                <td>
                    <dx:ASPxCheckBox ID="chkLocked" runat="server"></dx:ASPxCheckBox>
                    &nbsp;<dx:ASPxLabel ID="lblLockedOn" runat="server" Text=""></dx:ASPxLabel>
                </td>
            </tr>
            <tr>
                <td>Role</td>
                <td>:</td>
                <td>
                    <dx:ASPxComboBox ID="cbRole" runat="server" DropDownStyle="DropDownList" ValueType="System.String" Width="300"></dx:ASPxComboBox>
                </td>
            </tr>
            <tr>
                <td>Client</td>
                <td>:</td>
                <td>
                    <dx:ASPxComboBox ID="cbClient" runat="server" DropDownStyle="DropDownList" ValueType="System.String" Width="300"></dx:ASPxComboBox>
                </td>
            </tr>
            <tr>
                <td>Email</td>
                <td>:</td>
                <td>
                    <dx:ASPxTextBox ID="txtEmail" runat="server" Width="300px">
                        <ValidationSettings EnableCustomValidation="True" ErrorDisplayMode="Text" ErrorTextPosition="Right" SetFocusOnError="true">
                            <ErrorFrameStyle Font-Size="Smaller" />
                            <RegularExpression ValidationExpression="^\w+([-+.'%]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$"
                                ErrorText="Invalid e-mail" />
                            <RequiredField IsRequired="false" ErrorText="E-mail is required" />
                        </ValidationSettings>
                    </dx:ASPxTextBox>
                </td>
            </tr>
            <tr>
                <td>Mobile</td>
                <td>:</td>
                <td>
                    <dx:ASPxTextBox ID="txtMobile" runat="server" MaxLength="16" Width="300px"></dx:ASPxTextBox>
                </td>
            </tr>
            <tr>
                <td>Comment</td>
                <td>:</td>
                <td>
                    <dx:ASPxMemo ID="txtComment" runat="server" Height="100px" Width="300px"></dx:ASPxMemo>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td></td>
                <td>
                    <dx:ASPxButton ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click"></dx:ASPxButton>
                    <dx:ASPxButton ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click"></dx:ASPxButton>
                </td>
            </tr>
        </table>--%>
</asp:Content>

