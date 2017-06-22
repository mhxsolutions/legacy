<%@ Page Language="VB" AutoEventWireup="false" CodeFile="LoadBillingDetail.aspx.vb" Inherits="LoadBillingDetail" %>

<%@ Register Src="~/Controls/SaveLayout.ascx" TagPrefix="uc1" TagName="SaveLayout" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Load Billing</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <h3>Load Billing Detail (<a href="index.aspx">home</a>)<br />
                <br />
            </h3>
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
                <SettingsPopup>
                    <HeaderFilter MinHeight="300px" MinWidth="400px" />
                </SettingsPopup>
                <SettingsSearchPanel Visible="True" />
                <Columns>
                    <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                    </dx:GridViewCommandColumn>
                    <dx:GridViewDataDateColumn FieldName="Plan Date" SortIndex="0" SortOrder="Descending" VisibleIndex="1">
                        <Settings AllowHeaderFilter="True" />
                        <SettingsHeaderFilter Mode="DateRangeCalendar">
                        </SettingsHeaderFilter>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataTextColumn FieldName="Client" ReadOnly="True" SortIndex="1" SortOrder="Ascending" VisibleIndex="3">
                        <Settings AllowHeaderFilter="True" />
                        <SettingsHeaderFilter Mode="CheckedList">
                        </SettingsHeaderFilter>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Load Fleet" VisibleIndex="6">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Load" VisibleIndex="7">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="RFS" FieldName="RFS ref" VisibleIndex="8">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Billing" ReadOnly="True" VisibleIndex="9">
                        <PropertiesTextEdit DisplayFormatString="c0">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Invoice" VisibleIndex="10">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Item Total" VisibleIndex="11">
                        <PropertiesTextEdit DisplayFormatString="c0">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Destination" ReadOnly="True" VisibleIndex="5">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Origin" ReadOnly="True" VisibleIndex="4">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Private Rev" VisibleIndex="12">
                        <PropertiesTextEdit DisplayFormatString="c0">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Subhaul Pay" VisibleIndex="13">
                        <PropertiesTextEdit DisplayFormatString="c">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataCheckColumn FieldName="Will Call" VisibleIndex="14">
                    </dx:GridViewDataCheckColumn>
                    <dx:GridViewDataDateColumn FieldName="LoadDate" VisibleIndex="2">
                        <Settings AllowHeaderFilter="True" />
                        <SettingsHeaderFilter Mode="DateRangeCalendar">
                        </SettingsHeaderFilter>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataCheckColumn FieldName="POD" VisibleIndex="15">
                    </dx:GridViewDataCheckColumn>
                    <dx:GridViewDataTextColumn FieldName="Billing Status" VisibleIndex="16">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Sales" VisibleIndex="17">
                        <Settings AllowHeaderFilter="True" />
                        <SettingsHeaderFilter Mode="CheckedList">
                        </SettingsHeaderFilter>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="CEC" VisibleIndex="18">
                        <Settings AllowHeaderFilter="True" />
                        <SettingsHeaderFilter Mode="CheckedList">
                        </SettingsHeaderFilter>
                    </dx:GridViewDataTextColumn>
                </Columns>
                <TotalSummary>
                    <dx:ASPxSummaryItem FieldName="Item Total" ShowInColumn="Item Total" SummaryType="Sum" />
                    <dx:ASPxSummaryItem FieldName="Billing" ShowInColumn="Billing" SummaryType="Sum" />
                    <dx:ASPxSummaryItem FieldName="Private Rev" ShowInColumn="Private Rev" SummaryType="Sum" />
                    <dx:ASPxSummaryItem FieldName="Subhaul Pay" ShowInColumn="Subhaul Pay" SummaryType="Sum" />
                </TotalSummary>
                <GroupSummary>
                    <dx:ASPxSummaryItem FieldName="Billing" SummaryType="Sum" />
                    <dx:ASPxSummaryItem FieldName="Load" SummaryType="Count" />
                </GroupSummary>
            </dx:ASPxGridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Load Billing Status Detail] WHERE ([Company ID ref] = @Company_ID_ref)">
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
