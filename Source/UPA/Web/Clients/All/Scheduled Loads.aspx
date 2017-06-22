<%@ Page Title="Scheduled Loads" Language="C#" MasterPageFile="~/UPA.master" AutoEventWireup="true" CodeBehind="Scheduled Loads.aspx.cs" Inherits="Web.Clients.All.Scheduled_Loads" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Scheduled Load Count Review</h3>
    <p>
        <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export to XLSX" Theme="Office2010Blue">
        </dx:ASPxButton>
    </p>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2010Blue">
            <Columns>
                <dx:GridViewDataDateColumn FieldName="Schedule Date" SortIndex="0" SortOrder="Descending" VisibleIndex="0" GroupIndex="0">
                    <Settings AutoFilterCondition="GreaterOrEqual" ShowInFilterControl="True" AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="DateRangePicker">
                    </SettingsHeaderFilter>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Delivery" SortIndex="1" SortOrder="Ascending" VisibleIndex="1" GroupIndex="1">
                    <Settings ShowInFilterControl="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Fleet" VisibleIndex="2" SortIndex="2" SortOrder="Ascending">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Load" VisibleIndex="3" SortIndex="3" SortOrder="Ascending">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsContextMenu Enabled="True">
            </SettingsContextMenu>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterBar="Visible" ShowFilterRowMenu="True" ShowGroupedColumns="True" />
            <SettingsBehavior EnableRowHotTrack="True" />

<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>

            <SettingsPopup>
                <HeaderFilter MinHeight="300px" />
            </SettingsPopup>

            <SettingsSearchPanel Visible="True" />
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="Count" SummaryType="Sum" />
            </TotalSummary>
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="Load" SummaryType="Count" />
            </GroupSummary>

<Styles AdaptiveDetailButtonWidth="22"></Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [COPSLoadsScheduledDetail] WHERE ([Parent Ref] = @Parent_Ref)">
            <SelectParameters>
                <asp:SessionParameter Name="Parent_Ref" SessionField="CONTEXT_CLIENTID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Scheduled Load Count" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    </p>
    <p>
        (90 day look back)</p>
</asp:Content>
