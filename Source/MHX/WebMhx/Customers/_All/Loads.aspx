<%@ Page Title="Loads Delivered" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Loads.aspx.cs" Inherits="Customers__All_Loads" %>

<%@ Register Src="~/Controls/ExportControl.ascx" TagPrefix="uc1" TagName="ExportControl" %>
<%@ Register Src="~/Controls/SaveLayoutControl.ascx" TagPrefix="uc1" TagName="SaveLayoutControl" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h2>Dispatch History</h2>
    <uc1:ExportControl runat="server" ID="ExportControl" GridViewID="ASPxGridView1" FileName="DispatchHistory" />
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" KeyFieldName="Load" Width="98%">
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="true" ShowFooter="true" ShowGroupPanel="True"></Settings>
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" AllowEllipsisInText="True" ColumnResizeMode="NextColumn" />
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <SettingsPager PageSize="20">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
        <SettingsCommandButton>
            <ShowAdaptiveDetailButton ButtonType="Image">
            </ShowAdaptiveDetailButton>
            <HideAdaptiveDetailButton ButtonType="Image">
            </HideAdaptiveDetailButton>
        </SettingsCommandButton>
        <Columns>
            <dx:GridViewCommandColumn SelectAllCheckboxMode="Page" ShowClearFilterButton="True" ShowSelectCheckbox="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Load" ReadOnly="True" SortIndex="1" SortOrder="Ascending" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="BOL" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="LoadDate" VisibleIndex="1" SortIndex="0" SortOrder="Descending">
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="DateRangePicker">
                </SettingsHeaderFilter>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="GrossWeight" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="LogOutDate" VisibleIndex="5">
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="DateRangePicker">
                </SettingsHeaderFilter>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataDateColumn FieldName="POD Date" VisibleIndex="6">
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="DateRangePicker">
                </SettingsHeaderFilter>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Shipper" ReadOnly="True" VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Origin Terminal" ReadOnly="True" VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Destination" ReadOnly="True" VisibleIndex="9">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Fleet" VisibleIndex="12">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataHyperLinkColumn Caption="Link" FieldName="PDF File Name" VisibleIndex="11">
                <PropertiesHyperLinkEdit NavigateUrlFormatString="http//budwaydirect.com/pods/indexed pods/{0}" TextField="PDF File" EncodeHtml="False">
                </PropertiesHyperLinkEdit>
            </dx:GridViewDataHyperLinkColumn>
            <dx:GridViewDataCheckColumn FieldName="Will Call" VisibleIndex="13">
            </dx:GridViewDataCheckColumn>
        </Columns>
        <Templates>
            <DetailRow>
                <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="true" DataSourceID="SqlDataSource2" KeyFieldName="Load" OnBeforePerformDataSelect="ASPxGridView2_BeforePerformDataSelect">
                </dx:ASPxGridView>
            </DetailRow>
        </Templates>
        <SettingsDetail ShowDetailRow="true" AllowOnlyOneMasterRowExpanded="true" />
        <Styles AdaptiveDetailButtonWidth="22">
            <Cell Wrap="False">
            </Cell>
        </Styles>
    </dx:ASPxGridView>
    <div class="contentDiv">
        <p>
            Trucking only - does not include rail shipments
        </p>
    </div>
    <br />
    <uc1:SaveLayoutControl runat="server" ID="SaveLayoutControl" GridViewID="ASPxGridView1" />
    <br />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Load], BOL, LoadDate, GrossWeight, LogOutDate, [POD Date], [Client ID], Shipper, [Origin Terminal], Destination, [PDF File], [PDF File Name], [Fleet ref], Fleet, [Company ID ref], [Dest Client ref], [Will Call] FROM [All Loads with Scanned POD] WHERE ([Company ID ref] = @Company_ID_ref) AND ([Client ID] = @Client_ID) OR ([Company ID ref] = @Company_ID_ref) AND ([Dest Client ref] = @Client_ID)">
        <SelectParameters>
            <asp:Parameter DefaultValue="1" Name="Company_ID_ref" Type="Int32" />
            <asp:SessionParameter Name="Client_ID" SessionField="context_clientID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Loads with coils or serial ID stock] WHERE Load = @Load">
        <SelectParameters>
            <asp:SessionParameter Name="Load" SessionField="Load" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>

