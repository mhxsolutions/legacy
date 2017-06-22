<%@ Page Title="BudwayDirect | Planned Deliveries" Language="C#" MasterPageFile="~/CopsWeb.master" AutoEventWireup="true" CodeBehind="PlannedDeliveriesToday.aspx.cs" 
    Inherits="Web_App.Customers._All.PlannedDeliveriesToday" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>
        Current Load Plan</h3>
    <asp:SqlDataSource ID="PlannedDeliveriesDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Load], Origin, Action, Stop, [Sch Arrive], [Final Destination], Client, [Parent ref], [origin ref], [destination ref], [stop ref], [receiver ref] FROM COPSLoadPlan WHERE ([Parent ref] = @destination_ref) OR ([origin ref] = @destination_ref) OR ([destination ref] = @destination_ref) OR ([stop ref] = @destination_ref) OR ([receiver ref] = @destination_ref) ORDER BY [Sch Arrive]">
        <SelectParameters>
            <asp:SessionParameter Name="destination_ref" SessionField="context_clientid" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="PlannedDeliveriesDataSource" EnableTheming="True" Theme="Metropolis">
        <SettingsContextMenu Enabled="True" EnableRowMenu="True">
        </SettingsContextMenu>
        <SettingsPager PageSize="50">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" />
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
        <SettingsSearchPanel Visible="True" />
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
</asp:Content>
