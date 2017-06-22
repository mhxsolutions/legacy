<%@ Page Title="test report" Language="C#" MasterPageFile="~/Hydra.master" AutoEventWireup="true" CodeBehind="test1.aspx.cs" Inherits="Web.Clients.test1" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Test Page - Client List</h3>
    <p>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" SelectCommand="SELECT [Company ID ref] AS Company_ID_ref, [Client], [Med Address] AS Med_Address, [Long Address] AS Long_Address, [Full Address] AS Full_Address FROM [Client full addresses] WHERE ([Company ID ref] = @Company_ID_ref)">
            <SelectParameters>
                <asp:Parameter DefaultValue="3" Name="Company_ID_ref" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server">
        </dx:ASPxGridView>
    </p>
    <p>
        &nbsp;</p>
</asp:Content>
