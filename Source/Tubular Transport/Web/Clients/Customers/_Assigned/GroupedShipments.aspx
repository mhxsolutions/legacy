<%@ Page Language="C#" MasterPageFile="~/TubularTransport.master" AutoEventWireup="true" CodeFile="GroupedShipments.aspx.cs" Inherits="Customers__Assigned_GroupedShipments" Title="Grouped Shipments" %>
<%@ Register assembly="DevExpress.Web.v15.1, Version=15.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
    Grouped Shipments<br />
    </h3>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT * FROM [TTL shipments by shipper number] WHERE ([Shipping Client Ref] = @Shipping_Client_Ref) ORDER BY [Shipment Date] DESC, [Shipper Number], [Extended Description]">
        <SelectParameters>
            <asp:SessionParameter Name="Shipping_Client_Ref" SessionField="context_clientID"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
        Text="Export to Excel" />
    <dx:ASPxGridViewExporter ID="GroupedShipExporter1" runat="server">
    </dx:ASPxGridViewExporter>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataDateColumn FieldName="Shipment Date" VisibleIndex="1">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Fleet" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Shipper Number" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Destination" FieldName="Name-city" 
                VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Extended Description" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Item Count" VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Shipping Client Ref" Visible="False" 
                VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="LNFT" VisibleIndex="7">
                <PropertiesTextEdit DisplayFormatString="{0:n1}">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsPager PageSize="30">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True" Items="10, 30, 50, 100, 200">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" />
        <Styles>
            <Cell Wrap="False">
            </Cell>
        </Styles>
    </dx:ASPxGridView>
</asp:Content>

