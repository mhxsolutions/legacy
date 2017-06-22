<%@ Page Title="Orders Delivered" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="AlcoaOrdersDelivered.aspx.cs" Inherits="Customers__Assigned_AlcoaOrdersDelivered" %>

<%@ Register Src="~/Controls/ExportControl.ascx" TagPrefix="uc1" TagName="ExportControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h2>Alcoa Orders Delivered - Open Orders</h2>
    <uc1:ExportControl runat="server" ID="ExportControl" GridViewID="ASPxGridView2" FileName="AlocaOrdersDelivered_OpenOrders" />
    <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" KeyFieldName="Order #" Width="98%" OnCustomUnboundColumnData="ASPxGridView2_CustomUnboundColumnData">
        <SettingsSearchPanel Visible="True">
        </SettingsSearchPanel>
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="true" ShowFooter="true" ShowGroupPanel="True">
        </Settings>
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" AllowEllipsisInText="True" ColumnResizeMode="NextColumn" />
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <SettingsPager PageSize="20">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <SettingsCommandButton>
            <ShowAdaptiveDetailButton ButtonType="Image">
            </ShowAdaptiveDetailButton>
            <HideAdaptiveDetailButton ButtonType="Image">
            </HideAdaptiveDetailButton>
        </SettingsCommandButton>
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" Visible="False" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Order #" ReadOnly="True" SortIndex="1" SortOrder="Ascending" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Mat#" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Size" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Tons Ordered" ReadOnly="True" VisibleIndex="5">
                <PropertiesTextEdit DisplayFormatString="n1">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Net Tons Delivered" VisibleIndex="6">
                <PropertiesTextEdit DisplayFormatString="n1">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Net Ton Balance to Deliver over/(short)" ReadOnly="True" VisibleIndex="7">
                <PropertiesTextEdit DisplayFormatString="n1">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Order Week" ReadOnly="True" VisibleIndex="16">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Net Tons Committed" VisibleIndex="13">
                <PropertiesTextEdit DisplayFormatString="n1">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="Deliver By Date" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Net Tons Inventory" VisibleIndex="14" Visible="False">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn UnboundType="Decimal" FieldName="InventryRunningBalance" Caption="Running Balance (w/Inventory at Budway)"  PropertiesTextEdit-DisplayFormatString="f2" VisibleIndex="15" Settings-AllowSort="False">
<PropertiesTextEdit DisplayFormatString="n1"></PropertiesTextEdit>

<Settings AllowSort="False"></Settings>
            </dx:GridViewDataTextColumn>
        </Columns>
        <TotalSummary>
            <dx:ASPxSummaryItem FieldName="Tons Ordered" SummaryType="Sum" />
            <dx:ASPxSummaryItem FieldName="Net Tons Delivered" SummaryType="Sum" />
            <dx:ASPxSummaryItem FieldName="Net Ton Balance to Deliver over/(short)" SummaryType="Sum" />
            <dx:ASPxSummaryItem FieldName="Net Tons Committed" SummaryType="Sum" />
        </TotalSummary>
        <Styles>
            <Header Wrap="True">
            </Header>
        </Styles>
    </dx:ASPxGridView>

    <%-- SELECT * FROM [ClientOrders_OpenDeliveredOrdered] WHERE ([ClientID] = @ClientID) --%>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [ClientOrders_OpenDeliveredOrdered] WHERE ([ClientID] = @ClientID)">
        <SelectParameters>
            <asp:Parameter DefaultValue="73" Name="ClientID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

