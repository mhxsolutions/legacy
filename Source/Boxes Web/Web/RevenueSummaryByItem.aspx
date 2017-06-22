<%@ Page Language="VB" AutoEventWireup="false" CodeFile="RevenueSummaryByItem.aspx.vb" Inherits="RevenueSummaryByItem" %>

<%@ Register Src="~/Controls/SaveLayout.ascx" TagPrefix="uc1" TagName="SaveLayout" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Revenue Summary</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <h3>Revenue Summary by Invoice Line Item (<a href="index.aspx">home</a>)</h3>
            <p>
                <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Expand All" Theme="MetropolisBlue">
                </dx:ASPxButton>
            </p>
            <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="MetropolisBlue">
                <SettingsContextMenu Enabled="True" EnableRowMenu="False">
                </SettingsContextMenu>
                <SettingsPager PageSize="20" Position="TopAndBottom">
                    <AllButton Visible="True">
                    </AllButton>
                    <PageSizeItemSettings ShowAllItem="True" Visible="True">
                    </PageSizeItemSettings>
                </SettingsPager>
                <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupFooter="VisibleAlways" ShowGroupPanel="True" />
                <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
                <SettingsSearchPanel Visible="True" />
                <Columns>
                    <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                    </dx:GridViewCommandColumn>
                    <dx:GridViewDataTextColumn FieldName="Item Year" GroupIndex="0" SortIndex="0" SortOrder="Descending" VisibleIndex="1">
                        <Settings AllowHeaderFilter="True" />
                        <SettingsHeaderFilter Mode="CheckedList">
                        </SettingsHeaderFilter>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Item Month" GroupIndex="1" SortIndex="1" SortOrder="Descending" VisibleIndex="2">
                        <Settings AllowHeaderFilter="True" />
                        <SettingsHeaderFilter Mode="CheckedList">
                        </SettingsHeaderFilter>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Invoice Month" VisibleIndex="4">
                        <Settings AllowHeaderFilter="True" />
                        <SettingsHeaderFilter Mode="CheckedList">
                        </SettingsHeaderFilter>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Item Total" VisibleIndex="5">
                        <PropertiesTextEdit DisplayFormatString="c">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="NS_ServiceLine" VisibleIndex="6">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="NS_Office" VisibleIndex="7">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Status" GroupIndex="2" SortIndex="2" SortOrder="Ascending" VisibleIndex="3">
                        <Settings AllowHeaderFilter="True" />
                        <SettingsHeaderFilter Mode="CheckedList">
                        </SettingsHeaderFilter>
                    </dx:GridViewDataTextColumn>
                </Columns>
                <GroupSummary>
                    <dx:ASPxSummaryItem FieldName="Item Total" ShowInGroupFooterColumn="Item Total" SummaryType="Sum" />
                </GroupSummary>
            </dx:ASPxGridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [RFS Invoice Revenue by Item Date] WHERE ([Company ID ref] = @Company_ID_ref)">
                <SelectParameters>
                    <asp:Parameter DefaultValue="9" Name="Company_ID_ref" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />

            <uc1:SaveLayout runat="server" ID="SaveLayout" GridViewID="ASPxGridView1" />
            <br />
            <br />
        </div>
    </form>
    <p>
        This report summarizes the invoiced revenue by item date. This allows the auditing of accruals for work performed in one month (item date) but invoiced in another (invoice date).
    </p>
    <p>
        Invoice date and status is provided for alternate analysis.
    </p>
</body>
</html>
