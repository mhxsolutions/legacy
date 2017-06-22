<%@ Page AutoEventWireup="true" CodeFile="HarborDetailHistory.aspx.cs" Inherits="Customers__All_HarborDetailHistory" Language="C#" MasterPageFile="~/Main.master" Title="BudwayDirect - Harbor Detail History" %>

<%@ Register Src="~/Controls/ExportControl.ascx" TagPrefix="uc1" TagName="ExportControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h2>All Harbor History</h2>
    <uc1:ExportControl runat="server" ID="ExportControl" GridViewID="ASPxGridView1" FileName="HarborDetailHistory" />

    <dx:ASPxGridView ID="ASPxGridView1" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" Width="98%">
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="true" ShowFooter="true" ShowGroupPanel="True"></Settings>
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" AllowEllipsisInText="True" ColumnResizeMode="NextColumn" />
        <SettingsContextMenu Enabled="True" EnableRowMenu="False"></SettingsContextMenu>
        <SettingsPager PageSize="20">
            <AllButton Visible="True"></AllButton>
            <PageSizeItemSettings Visible="True"></PageSizeItemSettings>
        </SettingsPager>
        <SettingsSearchPanel Visible="True"></SettingsSearchPanel>

        <SettingsCommandButton>
            <ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>
            <HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
        </SettingsCommandButton>

        <SettingsDataSecurity AllowEdit="False" AllowInsert="False" AllowDelete="False"></SettingsDataSecurity>
        <Columns>
            <dx:GridViewDataTextColumn FieldName="Item_ID" Caption="Item ID" VisibleIndex="0"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Vessel" VisibleIndex="1"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Destination" VisibleIndex="2"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Client Ref" VisibleIndex="3"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Detail 1" VisibleIndex="4"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Detail 2" VisibleIndex="5"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Detail 3" VisibleIndex="6"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DR Ref" VisibleIndex="7" Caption="Gross"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Notes" VisibleIndex="8"></dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="Load Date" VisibleIndex="9" PropertiesDateEdit-DisplayFormatString="{0:d}">
                <PropertiesDateEdit DisplayFormatString="{0:d}"></PropertiesDateEdit>
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="DateRangePicker"></SettingsHeaderFilter>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataHyperLinkColumn FieldName="POD" VisibleIndex="10">
                <PropertiesHyperLinkEdit EncodeHtml="False">
                </PropertiesHyperLinkEdit>
            </dx:GridViewDataHyperLinkColumn>
        </Columns>
    </dx:ASPxGridView>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT * FROM [COPSHarborInventoryHistory] WHERE ([ShipperRef] = @ShipperRef) ORDER BY [Item_ID]">
        <SelectParameters>
            <asp:SessionParameter Name="ShipperRef" SessionField="CONTEXT_CLIENTID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

