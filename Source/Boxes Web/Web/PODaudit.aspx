<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PODaudit.aspx.vb" Inherits="PODaudit" %>

<%@ Register Src="~/Controls/SaveLayout.ascx" TagPrefix="uc1" TagName="SaveLayout" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>POD Audit</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>MHX POD Audit&nbsp;&nbsp;&nbsp; (<a href="index.aspx">home</a>)<br />
            <br />
            <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export XLSX" Theme="MetropolisBlue">
            </dx:ASPxButton>
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
            <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" ShowFilterBar="Visible" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsPopup>
                <HeaderFilter MinHeight="500px" MinWidth="400px" />
            </SettingsPopup>
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Load" ReadOnly="True" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="LoadDate" VisibleIndex="4">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="DateRangeCalendar">
                    </SettingsHeaderFilter>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataDateColumn FieldName="Plan Date" VisibleIndex="5">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="DateRangeCalendar">
                    </SettingsHeaderFilter>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataCheckColumn Caption="Arrive/Depart" FieldName="LogOut" VisibleIndex="6">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataCheckColumn FieldName="POD" VisibleIndex="7">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataCheckColumn FieldName="POD Scan" VisibleIndex="8">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataCheckColumn FieldName="Will Call" VisibleIndex="3">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="Fleet" VisibleIndex="11" Caption="Driver Fleet">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Driver" VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="Subhauler" VisibleIndex="10">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="Load Fleet" VisibleIndex="2">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Action" FieldName="Planner Action" VisibleIndex="12">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:GridViewDataTextColumn>
            </Columns>
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="Load" SummaryType="Count" />
            </GroupSummary>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Loads without logout or POD] WHERE ([Company ID ref] = @Company_ID_ref)">
            <SelectParameters>
                <asp:Parameter DefaultValue="9" Name="Company_ID_ref" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="POD audit" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
        <uc1:SaveLayout runat="server" ID="SaveLayout" GridViewID="ASPxGridView1" /><br /><br />
    </form>
</body>
</html>
