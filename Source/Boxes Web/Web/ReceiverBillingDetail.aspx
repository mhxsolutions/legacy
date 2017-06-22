<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ReceiverBillingDetail.aspx.vb" Inherits="ReceiverBillingDetail" %>

<%@ Register Src="~/Controls/SaveLayout.ascx" TagPrefix="uc1" TagName="SaveLayout" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Receiver Billing Detail</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <h3>Billing Detail - Receivers (<a href="index.aspx">home</a>)<br />
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
                <SettingsSearchPanel Visible="True" />
                <Columns>
                    <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                    </dx:GridViewCommandColumn>
                    <dx:GridViewDataTextColumn Caption="Receiver" FieldName="Receiver Ct" SortIndex="5" SortOrder="Ascending" VisibleIndex="6">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="RFS" FieldName="RFS Assigned Ct" VisibleIndex="7">
                        <Settings AllowHeaderFilter="True" />
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="Billing" FieldName="Billing Ct" VisibleIndex="8">
                        <PropertiesTextEdit DisplayFormatString="c">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn Caption="Invoice" FieldName="Invoiced Ct" VisibleIndex="9">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Invoiced" VisibleIndex="10">
                        <PropertiesTextEdit DisplayFormatString="c">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Inv Client" ReadOnly="True" SortIndex="4" SortOrder="Ascending" VisibleIndex="4">
                        <Settings AllowHeaderFilter="True" />
                        <SettingsHeaderFilter Mode="CheckedList">
                        </SettingsHeaderFilter>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Shipper" ReadOnly="True" VisibleIndex="5">
                        <Settings AllowHeaderFilter="True" />
                        <SettingsHeaderFilter Mode="CheckedList">
                        </SettingsHeaderFilter>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Terminal" SortIndex="3" SortOrder="Ascending" VisibleIndex="3">
                        <Settings AllowHeaderFilter="True" />
                        <SettingsHeaderFilter Mode="CheckedList">
                        </SettingsHeaderFilter>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Sales" VisibleIndex="11">
                        <Settings AllowHeaderFilter="True" />
                        <SettingsHeaderFilter Mode="CheckedList">
                        </SettingsHeaderFilter>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="CEC" VisibleIndex="12">
                        <Settings AllowHeaderFilter="True" />
                        <SettingsHeaderFilter Mode="CheckedList">
                        </SettingsHeaderFilter>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="Date Received" SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
                        <Settings AllowHeaderFilter="True" />
                        <SettingsHeaderFilter Mode="DateRangeCalendar">
                        </SettingsHeaderFilter>
                    </dx:GridViewDataDateColumn>
                </Columns>
            </dx:ASPxGridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Receiver list for billing detail] WHERE ([Company ID ref] = @Company_ID_ref)">
                <SelectParameters>
                    <asp:Parameter DefaultValue="9" Name="Company_ID_ref" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <uc1:SaveLayout runat="server" ID="SaveLayout" GridViewID="ASPxGridView1" />
            <br />
            No Correction Receivers<br />
            Locked Receivers only<br />
        </div>
    </form>
</body>
</html>
