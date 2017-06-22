<%@ Page Title="" Language="C#" MasterPageFile="~/UPA.master" AutoEventWireup="true" CodeBehind="DEBUG.aspx.cs" Inherits="Web.Clients.All.DEBUG" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [RECEIVERSCANTEST] WHERE ([client] = @client)">
        <SelectParameters>
            <asp:SessionParameter Name="client" SessionField="context_clientid" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Receiver ID" Theme="Metropolis">
        <Columns>
            <dx:GridViewDataTextColumn FieldName="client" VisibleIndex="0">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DOC Type Ref" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Receiver ID" ReadOnly="True" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
        </Columns>
    </dx:ASPxGridView>
</asp:Content>
