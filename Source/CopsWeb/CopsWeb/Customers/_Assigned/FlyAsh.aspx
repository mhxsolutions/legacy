<%@ Page Title="FlyAsh" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="FlyAsh.aspx.cs" Inherits="Customers__Assigned_FlyAsh" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h2>Fly Ash Traffic</h2>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" Width="98%">
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <SettingsPager PageSize="20">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" />
        <SettingsBehavior AllowEllipsisInText="True" ColumnResizeMode="Control" EnableCustomizationWindow="True" EnableRowHotTrack="True" />
        <SettingsCommandButton>
            <ShowAdaptiveDetailButton ButtonType="Image">
            </ShowAdaptiveDetailButton>
            <HideAdaptiveDetailButton ButtonType="Image">
            </HideAdaptiveDetailButton>
        </SettingsCommandButton>
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataDateColumn FieldName="Date" GroupIndex="0" ReadOnly="True" SortIndex="0" SortOrder="Descending" VisibleIndex="1">
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="DateRangePicker">
                </SettingsHeaderFilter>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Pre Scale Time" ReadOnly="True" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Scale Time" ReadOnly="True" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Total Time" ReadOnly="True" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Carrier" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Product" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Destination" VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Lot" VisibleIndex="9">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Ticket" VisibleIndex="10">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="Arrive" SortIndex="1" SortOrder="Ascending" VisibleIndex="13">
                <PropertiesDateEdit DisplayFormatString="t" EditFormat="Time">
                </PropertiesDateEdit>
                <Settings ShowFilterRowMenu="False" />
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataDateColumn FieldName="Scale" VisibleIndex="14">
                <PropertiesDateEdit DisplayFormatString="t" EditFormat="Time">
                </PropertiesDateEdit>
                <Settings ShowFilterRowMenu="False" />
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataDateColumn FieldName="Depart" VisibleIndex="15">
                <PropertiesDateEdit DisplayFormatString="t" EditFormat="Time">
                </PropertiesDateEdit>
                <Settings ShowFilterRowMenu="False" />
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Note" VisibleIndex="16">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Customer" VisibleIndex="7">
            </dx:GridViewDataTextColumn>
        </Columns>
        <TotalSummary>
            <dx:ASPxSummaryItem FieldName="Pre Scale Time" ShowInColumn="Pre Scale Time" SummaryType="Count" />
            <dx:ASPxSummaryItem FieldName="Pre Scale Time" ShowInColumn="Pre Scale Time" SummaryType="Average" />
            <dx:ASPxSummaryItem FieldName="Scale Time" ShowInColumn="Scale Time" SummaryType="Average" />
            <dx:ASPxSummaryItem FieldName="Total Time" ShowInColumn="Total Time" SummaryType="Average" />
        </TotalSummary>
        <GroupSummary>
            <dx:ASPxSummaryItem FieldName="Pre Scale Time" SummaryType="Count" />
            <dx:ASPxSummaryItem DisplayFormat="pre-scale avg = {0:n0}" FieldName="Pre Scale Time" SummaryType="Average" />
            <dx:ASPxSummaryItem DisplayFormat="scale avg = {0:n0}" FieldName="Scale Time" SummaryType="Average" />
            <dx:ASPxSummaryItem DisplayFormat="total avg = {0:n0}" FieldName="Total Time" SummaryType="Average" />
        </GroupSummary>
        <Styles>
            <Header Wrap="True">
            </Header>
        </Styles>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [fly ash time calcs] ORDER BY [Arrive] DESC"></asp:SqlDataSource>
</asp:Content>

