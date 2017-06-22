<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="AddUser.aspx.cs" Inherits="AddUser" %>

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
    <script>
        function ConfirmedPassword_OnValidation(s, e) {
            if (txtPassword.GetValue() != txtConfirmedPassword.GetValue()) {
                e.isValid = false;
                e.errorText = "Passwords do not match";
            }
        }
    </script>

    <h2>Add New User</h2>
    <div class="row">
        <div class="col-12">
            <dx:ASPxLabel ID="lblMessage" runat="server" Text=""></dx:ASPxLabel>
        </div>
    </div>

    <div class="row">
        <div class="col-2">User Name: </div>
        <div class="col-10">
            <dx:ASPxTextBox ID="txtUserName" runat="server" Width="200px">
                <ValidationSettings SetFocusOnError="True" ErrorTextPosition="Right" ErrorDisplayMode="Text"
                    ValidateOnLeave="False" Display="Dynamic">
                    <RequiredField IsRequired="True" />
                </ValidationSettings>
            </dx:ASPxTextBox>
        </div>
    </div>
    <div class="row">
        <div class="col-2">Password: </div>
        <div class="col-10">

            <dx:ASPxTextBox ID="txtPassword" runat="server" Width="200px" Password="True" ClientInstanceName="txtPassword">
                <ValidationSettings SetFocusOnError="True" ErrorTextPosition="Right" ErrorDisplayMode="Text"
                    ValidateOnLeave="False" Display="Dynamic">
                    <RegularExpression ValidationExpression=".{6,}" ErrorText="Min. 6 characters" />
                    <RequiredField IsRequired="True" />
                </ValidationSettings>
            </dx:ASPxTextBox>
        </div>
    </div>
    <div class="row">
        <div class="col-2">Confirm Password: </div>
        <div class="col-10">
            <dx:ASPxTextBox ID="txtConfirmedPassword" ClientInstanceName="txtConfirmedPassword" runat="server" Password="True" Width="200px"
                OnValidation="txtConfirmedPassword_Validation">
                <ClientSideEvents Validation="ConfirmedPassword_OnValidation" />
                <ValidationSettings SetFocusOnError="True" EnableCustomValidation="True" ErrorTextPosition="Right"
                    ErrorDisplayMode="Text" ValidateOnLeave="False" Display="Dynamic">
                    <RequiredField IsRequired="True" />
                </ValidationSettings>
            </dx:ASPxTextBox>
        </div>
    </div>
    <div class="row">
        <div class="col-2">Approved: </div>
        <div class="col-10">
            <dx:ASPxCheckBox ID="chkApproved" Checked="true" runat="server"></dx:ASPxCheckBox>
        </div>
    </div>

    <div class="row">
        <div class="col-2">Role: </div>
        <div class="col-10">
            <dx:ASPxComboBox ID="cbRole" runat="server" DataSourceID="odsRoles" DropDownStyle="DropDownList" ValueType="System.String" Width="300">
                <ValidationSettings RequiredField-IsRequired="true" ErrorTextPosition="Right"></ValidationSettings>
            </dx:ASPxComboBox>
        </div>
    </div>
    <%--<div class="row">
        <div class="col-2">Company: </div>
        <div class="col-10">
            <dx:ASPxComboBox ID="cbCompany" DataSourceID="odsCompany" runat="server" TextField="CompanyName" ValueField="CompanyId" DropDownStyle="DropDownList" ValueType="System.Int32" Width="300" AutoPostBack="true">
                <ValidationSettings RequiredField-IsRequired="true" ErrorTextPosition="Right"></ValidationSettings>
            </dx:ASPxComboBox>
        </div>
    </div>--%>
    <div class="row">
        <div class="col-2">Client: </div>
        <div class="col-10">
            <dx:ASPxComboBox ID="cbClient" DataSourceID="odsClients" runat="server" TextField="Client" ValueField="ClientId" DropDownStyle="DropDownList" ValueType="System.Int32" Width="300">
                <ValidationSettings RequiredField-IsRequired="true" ErrorTextPosition="Right"></ValidationSettings>
            </dx:ASPxComboBox>
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
                    <RequiredField IsRequired="true" ErrorText="*" />
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
            <dx:ASPxButton ID="btnAddUser" runat="server" Text="Add User" OnClick="btnAddUser_Click"></dx:ASPxButton>
            <dx:ASPxButton ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click"></dx:ASPxButton>
        </div>
    </div>

    <asp:ObjectDataSource ID="odsRoles" runat="server" TypeName="UserCompany" SelectMethod="GetRoles"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsCompany" runat="server" TypeName="UserCompany" SelectMethod="GetCompanyList">
        <SelectParameters>
            <asp:SessionParameter Name="CompanyId" SessionField="CompanyId" DefaultValue="1" Type="String" />
            <asp:SessionParameter Name="Role" SessionField="Role" DefaultValue="Administrators" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsClients" runat="server" TypeName="UserCompany" SelectMethod="GetClientListByCompany">
        <SelectParameters>
            <%--<asp:ControlParameter ControlID="cbCompany" Name="CompanyId" DefaultValue="1" PropertyName="SelectedItem.Value" Type="Int32" />--%>
            <asp:SessionParameter Name="CompanyId" SessionField="CompanyId" DefaultValue="1" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>


</asp:Content>

