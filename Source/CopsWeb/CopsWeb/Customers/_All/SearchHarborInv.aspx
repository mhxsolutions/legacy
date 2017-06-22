<%@ Page Title="BudwayDirect | Search Harbor Inventory" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="SearchHarborInv.aspx.cs" Inherits="Customers__All_SearchHarborInv" %>

<%@ Register Src="~/Controls/ExportControl.ascx" TagPrefix="uc1" TagName="ExportControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h2>Harbor Inventory Detail History</h2>

    <div class="contentDiv">
        Search Item ID:
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <asp:Button ID="Button1" runat="server" PostBackUrl="~/Customers/_All/SearchHarborInv.aspx"
            Text="Search" />
    </div>
    <uc1:ExportControl runat="server" ID="ExportControl" GridViewID="ASPxGridView1" FileName="SearchHarborInv" />

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
            <dx:GridViewDataTextColumn FieldName="Notes" VisibleIndex="7"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DR Ref" VisibleIndex="8"></dx:GridViewDataTextColumn>
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
        SelectCommand="SELECT Shipper, Vessel, Destination, [Client Ref], Item_ID, [Detail 1], [Detail 2], [Detail 3], [DR Ref], Notes, [Load Date], POD, ShipperRef, ReceiverRef, DestinationRef FROM COPSHarborInventoryHistory WHERE (ShipperRef = @ShipperRef) AND (Item_ID LIKE N'%' + @Item_ID + N'%') OR (Item_ID LIKE N'%' + @Item_ID + N'%') AND (ReceiverRef = @ReceiverRef) OR (Item_ID LIKE N'%' + @Item_ID + N'%') AND (DestinationRef = @DestinationRef)">
        <SelectParameters>
            <asp:SessionParameter Name="ShipperRef" SessionField="context_clientID" Type="Int32" />
            <asp:ControlParameter ControlID="TextBox1" DefaultValue="" Name="Item_ID" PropertyName="Text" />
            <asp:SessionParameter Name="ReceiverRef" SessionField="context_clientID" Type="Int32" />
            <asp:SessionParameter Name="DestinationRef" SessionField="context_clientID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

