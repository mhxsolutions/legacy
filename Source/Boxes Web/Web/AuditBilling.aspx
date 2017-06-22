<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AuditBilling.aspx.vb" Inherits="AuditBilling" %>

<%@ Register Src="~/Controls/SaveLayout.ascx" TagPrefix="uc1" TagName="SaveLayout" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Audit Billing</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <h3>Audit Billing not on Invoice (<a href="index.aspx">home</a>)</h3>
            <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="MetropolisBlue">
                <SettingsContextMenu Enabled="True" EnableRowMenu="False">
                </SettingsContextMenu>
                <SettingsPager PageSize="20" Position="TopAndBottom">
                    <AllButton Visible="True">
                    </AllButton>
                    <PageSizeItemSettings ShowAllItem="True" Visible="True">
                    </PageSizeItemSettings>
                </SettingsPager>
                <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" />
                <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
                <SettingsSearchPanel Visible="True" />
                <Columns>
                    <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                    </dx:GridViewCommandColumn>
                    <dx:GridViewDataTextColumn FieldName="Billing Year" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                        <Settings AllowHeaderFilter="True" />
                        <SettingsHeaderFilter Mode="CheckedList">
                        </SettingsHeaderFilter>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Billing Month" GroupIndex="1" SortIndex="1" SortOrder="Ascending" VisibleIndex="2">
                        <Settings AllowHeaderFilter="True" />
                        <SettingsHeaderFilter Mode="CheckedList">
                        </SettingsHeaderFilter>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="NS_Office" SortIndex="2" SortOrder="Ascending" VisibleIndex="3">
                        <Settings AllowHeaderFilter="True" />
                        <SettingsHeaderFilter Mode="CheckedList">
                        </SettingsHeaderFilter>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="NS_ServiceLine" SortIndex="3" SortOrder="Ascending" VisibleIndex="4">
                        <Settings AllowHeaderFilter="True" />
                        <SettingsHeaderFilter Mode="CheckedList">
                        </SettingsHeaderFilter>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Item Total" VisibleIndex="5">
                        <PropertiesTextEdit DisplayFormatString="c">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Status" SortIndex="4" SortOrder="Ascending" VisibleIndex="7">
                        <Settings AllowHeaderFilter="True" />
                        <SettingsHeaderFilter Mode="CheckedList">
                        </SettingsHeaderFilter>
                    </dx:GridViewDataTextColumn>
                </Columns>
                <GroupSummary>
                    <dx:ASPxSummaryItem FieldName="Item Total" SummaryType="Sum" />
                </GroupSummary>
            </dx:ASPxGridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [RFS Billing without Invoicing] WHERE ([Company ID ref] = @Company_ID_ref)">
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
</body>
</html>
