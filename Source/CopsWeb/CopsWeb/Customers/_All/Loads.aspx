<%@ Page Title="Loads Delivered" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Loads.aspx.cs" Inherits="Customers__All_Loads" %>

<%@ Register Src="~/Controls/ExportControl.ascx" TagPrefix="uc1" TagName="ExportControl" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

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
                <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" KeyFieldName="Load" OnBeforePerformDataSelect="ASPxGridView2_BeforePerformDataSelect">
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="Load" ReadOnly="True" Visible="False" VisibleIndex="0">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Item ID" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Company ID ref" Visible="False" VisibleIndex="5">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn FieldName="LogOutDate" Visible="False" VisibleIndex="6">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataDateColumn FieldName="POD Date" Visible="False" VisibleIndex="7">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn Caption="Group 1" FieldName="Product Group 1" SortIndex="1" SortOrder="Ascending" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Group 2" FieldName="Product Group 2" VisibleIndex="3">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Group 3" FieldName="Product Group 3" VisibleIndex="4">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Ct in Pkg" FieldName="Count In Package" VisibleIndex="8">
                        </dx:GridViewDataTextColumn>
                    </Columns>
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

