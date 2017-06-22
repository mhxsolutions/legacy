<%@ Page Title="BudwayDirect | Planned Deliveries" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="PlannedDeliveriesToday.aspx.cs" Inherits="Customers__All_PlannedDeliveriesToday" %>

<%@ Register Src="~/Controls/ExportControl.ascx" TagPrefix="uc1" TagName="ExportControl" %>
<%@ Register Src="~/Controls/SaveLayoutControl.ascx" TagPrefix="uc1" TagName="SaveLayoutControl" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h2>Current Load Plan</h2>

    <uc1:ExportControl runat="server" ID="ExportControl" GridViewID="ASPxGridView1" FileName="PlannedDeliveriesToday" />


    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="PlannedDeliveriesDataSource" Width="98%">
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

        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Origin" ReadOnly="True" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Action" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Stop" ReadOnly="True" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="Sch Arrive" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                <PropertiesDateEdit DisplayFormatString="dddd h:mmt">
                </PropertiesDateEdit>
                <Settings AllowHeaderFilter="True" GroupInterval="Date" />
                <SettingsHeaderFilter Mode="DateRangePicker"></SettingsHeaderFilter>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Final Destination" ReadOnly="True" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Load" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
        </Columns>
        <Styles>
            <Cell Wrap="False">
            </Cell>
        </Styles>
    </dx:ASPxGridView>
    <br />
    (loads planned today and forward to stop at or deliver to current client)
    <br />
    <uc1:SaveLayoutControl runat="server" ID="SaveLayoutControl" GridViewID="ASPxGridView1" />
    <br />

    <asp:SqlDataSource ID="PlannedDeliveriesDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Load], Origin, Action, Stop, [Sch Arrive], [Final Destination], Client, [Parent ref], [origin ref], [destination ref], [stop ref], [receiver ref] FROM COPSLoadPlan WHERE ([Parent ref] = @destination_ref) OR ([origin ref] = @destination_ref) OR ([destination ref] = @destination_ref) OR ([stop ref] = @destination_ref) OR ([receiver ref] = @destination_ref) ORDER BY [Sch Arrive]">
        <SelectParameters>
            <asp:SessionParameter Name="destination_ref" SessionField="context_clientid" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

