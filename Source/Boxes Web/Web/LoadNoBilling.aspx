<%@ Page Language="VB" AutoEventWireup="false" CodeFile="LoadNoBilling.aspx.vb" Inherits="LoadNoBilling" %>

<%@ Register Src="~/Controls/SaveLayout.ascx" TagPrefix="uc1" TagName="SaveLayout" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Loads without Billing</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <h3>Loads Without Billing (<a href="index.aspx">home</a>)<br />
                <br />
            </h3>
            <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Load" Theme="MetropolisBlue">
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
                    <dx:GridViewDataTextColumn FieldName="Load" ReadOnly="True" SortIndex="1" SortOrder="Ascending" VisibleIndex="4">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="RFS ref" VisibleIndex="5">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Origin" ReadOnly="True" SortIndex="2" SortOrder="Ascending" VisibleIndex="2">
                        <Settings AllowHeaderFilter="True" />
                        <SettingsHeaderFilter Mode="CheckedList">
                        </SettingsHeaderFilter>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Destination" ReadOnly="True" SortIndex="3" SortOrder="Ascending" VisibleIndex="3">
                        <Settings AllowHeaderFilter="True" />
                        <SettingsHeaderFilter Mode="CheckedList">
                        </SettingsHeaderFilter>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="LogOutDate" VisibleIndex="6">
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataDateColumn FieldName="POD Date" VisibleIndex="7">
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataTextColumn FieldName="Client" GroupIndex="0" ReadOnly="True" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                        <Settings AllowHeaderFilter="True" />
                        <SettingsHeaderFilter Mode="CheckedList">
                        </SettingsHeaderFilter>
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewBandColumn Caption="Driver Type" VisibleIndex="10">
                        <Columns>
                            <dx:GridViewDataCheckColumn FieldName="Will Call" VisibleIndex="0">
                            </dx:GridViewDataCheckColumn>
                            <dx:GridViewDataCheckColumn FieldName="Subhauler" VisibleIndex="1">
                            </dx:GridViewDataCheckColumn>
                        </Columns>
                    </dx:GridViewBandColumn>
                </Columns>
                <GroupSummary>
                    <dx:ASPxSummaryItem FieldName="Load" SummaryType="Count" />
                </GroupSummary>
            </dx:ASPxGridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Loads without Billing] WHERE ([Company ID ref] = @Company_ID_ref)">
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
