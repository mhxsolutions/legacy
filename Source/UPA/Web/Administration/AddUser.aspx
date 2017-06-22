<%@ Page Title="" Language="C#" MasterPageFile="~/UPA.master" AutoEventWireup="true" CodeBehind="AddUser.aspx.cs" Inherits="Web.Administration.AddUser" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
            <dx:aspxlabel id="lblMessage" runat="server" text=""></dx:aspxlabel>
        </div>
    </div>

    <div class="row">
        <div class="col-2">User Name: </div>
        <div class="col-10">
            <dx:aspxtextbox id="txtUserName" runat="server" width="200px">
                <ValidationSettings SetFocusOnError="True" ErrorTextPosition="Right" ErrorDisplayMode="Text"
                    ValidateOnLeave="False" Display="Dynamic">
                    <RequiredField IsRequired="True" />
                </ValidationSettings>
            </dx:aspxtextbox>
        </div>
    </div>
    <div class="row">
        <div class="col-2">Password: </div>
        <div class="col-10">

            <dx:aspxtextbox id="txtPassword" runat="server" width="200px" password="True" clientinstancename="txtPassword">
                <ValidationSettings SetFocusOnError="True" ErrorTextPosition="Right" ErrorDisplayMode="Text"
                    ValidateOnLeave="False" Display="Dynamic">
                    <RegularExpression ValidationExpression=".{6,}" ErrorText="Min. 6 characters" />
                    <RequiredField IsRequired="True" />
                </ValidationSettings>
            </dx:aspxtextbox>
        </div>
    </div>
    <div class="row">
        <div class="col-2">Confirm Password: </div>
        <div class="col-10">
            <dx:aspxtextbox id="txtConfirmedPassword" clientinstancename="txtConfirmedPassword" runat="server" password="True" width="200px"
                onvalidation="txtConfirmedPassword_Validation">
                <ClientSideEvents Validation="ConfirmedPassword_OnValidation" />
                <ValidationSettings SetFocusOnError="True" EnableCustomValidation="True" ErrorTextPosition="Right"
                    ErrorDisplayMode="Text" ValidateOnLeave="False" Display="Dynamic">
                    <RequiredField IsRequired="True" />
                </ValidationSettings>
            </dx:aspxtextbox>
        </div>
    </div>
    <div class="row">
        <div class="col-2">Approved: </div>
        <div class="col-10">
            <dx:aspxcheckbox id="chkApproved" checked="true" runat="server"></dx:aspxcheckbox>
        </div>
    </div>

    <div class="row">
        <div class="col-2">Role: </div>
        <div class="col-10">
            <dx:aspxcombobox id="cbRole" runat="server" datasourceid="odsRoles" dropdownstyle="DropDownList" valuetype="System.String" width="300">
                <ValidationSettings RequiredField-IsRequired="true" ErrorTextPosition="Right"></ValidationSettings>
            </dx:aspxcombobox>
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
            <dx:aspxcombobox id="cbClient" datasourceid="odsClients" runat="server" textfield="Client" valuefield="ClientId" dropdownstyle="DropDownList" valuetype="System.Int32" width="300">
                <ValidationSettings RequiredField-IsRequired="true" ErrorTextPosition="Right"></ValidationSettings>
            </dx:aspxcombobox>
        </div>
    </div>

    <div class="row">

        <div class="col-2">Email: </div>
        <div class="col-10">
            <dx:aspxtextbox id="txtEmail" runat="server" width="300px">
                <ValidationSettings EnableCustomValidation="True" ErrorDisplayMode="Text" ErrorTextPosition="Right" SetFocusOnError="true">
                    <ErrorFrameStyle Font-Size="Smaller" />
                    <RegularExpression ValidationExpression="^\w+([-+.'%]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$"
                        ErrorText="Invalid e-mail" />
                    <RequiredField IsRequired="true" ErrorText="*" />
                </ValidationSettings>
            </dx:aspxtextbox>
        </div>
    </div>

    <div class="row">

        <div class="col-2">Mobile: </div>
        <div class="col-10">
            <dx:aspxtextbox id="txtMobile" runat="server" maxlength="16" width="300px"></dx:aspxtextbox>
        </div>
    </div>


    <div class="row">
        <div class="col-2">Comment: </div>
        <div class="col-10">
            <dx:aspxmemo id="txtComment" runat="server" height="100px" width="300px"></dx:aspxmemo>
        </div>
    </div>

    <div class="row">
        <div class="col-2"></div>
        <div class="col-10">
            <dx:aspxbutton id="btnAddUser" runat="server" text="Add User" onclick="btnAddUser_Click"></dx:aspxbutton>
            <dx:aspxbutton id="btnCancel" runat="server" text="Cancel" onclick="btnCancel_Click"></dx:aspxbutton>
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
