<%@ Page AutoEventWireup="true" CodeFile="InventoryConsignedDetail.aspx.cs" Inherits="Customers__All_InventoryConsignedDetail" Language="C#" MasterPageFile="~/Main.master" Title="Consigned Inventory" %>

<%@ Register Src="~/Controls/ExportControl.ascx" TagPrefix="uc1" TagName="ExportControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h2>Consigned Inventory (detail)</h2>
    <div class="contentDiv">
        <p>
            (held by other Clients for current User)
        </p>
    </div>
    <uc1:ExportControl runat="server" ID="ExportControl" GridViewID="ASPxGridView2" FileName="InventoryConsignedDetail" />

    <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" Width="98%">
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="true" ShowFooter="true" ShowGroupPanel="True"></Settings>
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" AllowEllipsisInText="True" ColumnResizeMode="NextColumn" />
        <SettingsContextMenu Enabled="True" EnableRowMenu="False"></SettingsContextMenu>
        <SettingsPager PageSize="20">
            <AllButton Visible="True"></AllButton>
            <PageSizeItemSettings Visible="True"></PageSizeItemSettings>
        </SettingsPager>
        <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Inventory" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Terminal" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Profile" FieldName="Product Profile Description" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Description" FieldName="Ext" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Group 1" FieldName="Product Group 1" VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Group 2" FieldName="Product Group 2" VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Group 3" FieldName="Product Group 3" VisibleIndex="9">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Wt" FieldName="weight" VisibleIndex="11">
                <PropertiesTextEdit DisplayFormatString="n0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Pcs" VisibleIndex="12">
                <PropertiesTextEdit DisplayFormatString="n0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Item ID" FieldName="Item_ID" VisibleIndex="10">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="Date Received" VisibleIndex="5">
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="DateRangePicker"></SettingsHeaderFilter>
            </dx:GridViewDataDateColumn>
        </Columns>
    </dx:ASPxGridView>


    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT Inventory, [Auth ref], Terminal, [Product Profile Description], Ext, [Product Group 1], [Product Group 2], [Product Group 3], weight, Pcs, [Parent ref], [Net Weight], [Linear Ft], Item_ID, [Date Received] FROM COPSauthViewerDetail WHERE ([Auth ref] = @Auth_ref) ORDER BY Inventory, Terminal, Ext">
        <SelectParameters>
            <asp:SessionParameter Name="Auth_ref" SessionField="context_clientID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

