<%@ Page Language="C#" MasterPageFile="~/TubularTransport.master" AutoEventWireup="true" CodeFile="encana_receivers.aspx.cs" Inherits="Customers__Assigned_encana_encana_receivers" Title="Encana Receivers" %>
<%@ Register assembly="DevExpress.Web.v15.1, Version=15.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Encana Receivers<br />
    </h3>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Receiver_ID" 
        Theme="Office2003Silver">
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn Caption="Receiver" FieldName="Receiver_ID" 
                ReadOnly="True" VisibleIndex="1">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Type" FieldName="Receiver_Type" 
                VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="Data" FieldName="Date_Received" 
                VisibleIndex="3">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn Caption="PO" FieldName="Client_PO" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsPager PageSize="30">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Items="10, 30, 50, 100, 200" ShowAllItem="True" 
                Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" />
        <Styles>
            <Cell Wrap="True">
            </Cell>
        </Styles>
    </dx:ASPxGridView>
    <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1" runat="server">
    </dx:ASPxGridViewExporter>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Receiver ID] AS Receiver_ID, [Receiver Type] AS Receiver_Type, [Date Received] AS Date_Received, [Client PO] AS Client_PO FROM [Receivers S] WHERE ([Receiving Client Ref] = @Receiving_Client_Ref) ORDER BY [Receiver ID]">
        <SelectParameters>
            <asp:SessionParameter Name="Receiving_Client_Ref" SessionField="context_clientID"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

