<%@ Page Language="VB" AutoEventWireup="false" CodeFile="P2P.aspx.vb" Inherits="P2P" %>

<%@ Register Src="~/Controls/SaveLayout.ascx" TagPrefix="uc1" TagName="SaveLayout" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Performance to Plan</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <h3>Performance to Plan (<a href="index.aspx">home</a>)<br />
                <br />
            </h3>
            <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" KeyFieldName="Plan Date" EnableTheming="True" Theme="Metropolis" Width="98%">
                <SettingsContextMenu Enabled="True" EnableRowMenu="True">
                </SettingsContextMenu>
                <SettingsPager PageSize="20">
                    <AllButton Visible="True">
                    </AllButton>
                    <PageSizeItemSettings Visible="True">
                    </PageSizeItemSettings>
                </SettingsPager>
                <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" />
                <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
                <SettingsPopup>
                    <HeaderFilter MinHeight="500px" MinWidth="400px" />
                </SettingsPopup>
                <SettingsSearchPanel Visible="True" />
                <Columns>
                    <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                    </dx:GridViewCommandColumn>
                    <dx:GridViewDataTextColumn FieldName="Booked with PreTrip" ReadOnly="True" VisibleIndex="3">
                        <PropertiesTextEdit DisplayFormatString="n0">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Actual Min" VisibleIndex="4">
                        <PropertiesTextEdit DisplayFormatString="n0">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Driver Ct" VisibleIndex="5">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Est Rev" VisibleIndex="6">
                        <PropertiesTextEdit DisplayFormatString="c0">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="Year" FieldName="year" ReadOnly="True" VisibleIndex="10" Visible="False">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Month" ReadOnly="True" VisibleIndex="11" Visible="False">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="T/Act Min" ReadOnly="True" VisibleIndex="8">
                        <PropertiesTextEdit DisplayFormatString="c">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="T/Booked Min" ReadOnly="True" VisibleIndex="9">
                        <PropertiesTextEdit DisplayFormatString="c">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Fleet" SortIndex="1" SortOrder="Ascending" VisibleIndex="2">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="P2P" ReadOnly="True" VisibleIndex="7">
                        <PropertiesTextEdit DisplayFormatString="p1">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="Plan Date" SortIndex="0" SortOrder="Descending" VisibleIndex="1" GroupIndex="0">
                        <Settings AllowHeaderFilter="True" />
                        <SettingsHeaderFilter Mode="DateRangeCalendar">
                        </SettingsHeaderFilter>
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataHyperLinkColumn Caption="Details" VisibleIndex="12" FieldName="Plan Date" Visible="False">
                        <PropertiesHyperLinkEdit NavigateUrlFormatString="p2p driver breakout.aspx?sel_date={0}" Text="Drivers">
                        </PropertiesHyperLinkEdit>
                        <Settings AllowAutoFilter="False" AllowFilterBySearchPanel="False" AllowGroup="False" AllowHeaderFilter="False" AllowSort="False" ShowFilterRowMenu="False" ShowInFilterControl="False" />
                    </dx:GridViewDataHyperLinkColumn>
                </Columns>
                <TotalSummary>
                    <dx:ASPxSummaryItem FieldName="P2P" SummaryType="Average" />
                    <dx:ASPxSummaryItem FieldName="T/Act Min" SummaryType="Average" />
                    <dx:ASPxSummaryItem FieldName="Booked with PreTrip" SummaryType="Sum" />
                </TotalSummary>
                <GroupSummary>
                    <dx:ASPxSummaryItem DisplayFormat="Avg PHP = {0:p}" FieldName="P2P" SummaryType="Average" />
                </GroupSummary>
                <Styles>
                    <Header Wrap="True">
                    </Header>
                    <Cell Wrap="False">
                    </Cell>
                </Styles>
            </dx:ASPxGridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" SelectCommand="P2P Daily Breakout vSP" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

            <p>
                Booked with Pre Trip = total dwell + total transit + pretrip 15 minutes
            </p>
            <br />
            <uc1:SaveLayout runat="server" ID="SaveLayout" GridViewID="ASPxGridView1" />
            <br />
            <br />
        </div>
    </form>
</body>
</html>
