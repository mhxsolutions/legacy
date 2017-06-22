<%@ Page Language="VB" AutoEventWireup="false" CodeFile="inventoy_transactions.aspx.vb" Inherits="inventoy_transactions" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Monthly Transactions</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Monthly Transactions In/Out</h3>
    
    </div>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        CssFilePath="~/App_Themes/BlackGlass/{0}/styles.css" CssPostfix="BlackGlass" 
        DataSourceID="SqlDataSource1">
        <TotalSummary>
            <dx:ASPxSummaryItem FieldName="Footage In" ShowInColumn="Footage" 
                SummaryType="Sum" />
        </TotalSummary>
        <GroupSummary>
            <dx:ASPxSummaryItem FieldName="Footage In" ShowInColumn="Footage" 
                ShowInGroupFooterColumn="Fleet" SummaryType="Sum" />
        </GroupSummary>
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Fleet" GroupIndex="0" SortIndex="0" 
                SortOrder="Ascending" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Year" SortIndex="2" SortOrder="Ascending" 
                VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Month" SortIndex="3" 
                SortOrder="Ascending" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Client" SortIndex="1" 
                SortOrder="Ascending" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Profile" SortIndex="4" 
                SortOrder="Ascending" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Product" SortIndex="5" 
                SortOrder="Ascending" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Pounds" FieldName="Pounds In" 
                VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Footage" FieldName="Footage In" 
                VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Count" FieldName="Count In" 
                VisibleIndex="9">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Pcs" FieldName="Pcs In" VisibleIndex="10">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <SettingsPager PageSize="100">
        </SettingsPager>
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" 
            ShowFooter="True" ShowGroupFooter="VisibleIfExpanded" ShowGroupPanel="True" />
        <Images SpriteCssFilePath="~/App_Themes/BlackGlass/{0}/sprite.css">
            <LoadingPanelOnStatusBar Url="~/App_Themes/BlackGlass/GridView/gvLoadingOnStatusBar.gif">
            </LoadingPanelOnStatusBar>
            <LoadingPanel Url="~/App_Themes/BlackGlass/GridView/Loading.gif">
            </LoadingPanel>
        </Images>
        <ImagesFilterControl>
            <LoadingPanel Url="~/App_Themes/BlackGlass/Editors/Loading.gif">
            </LoadingPanel>
        </ImagesFilterControl>
        <Styles CssFilePath="~/App_Themes/BlackGlass/{0}/styles.css" 
            CssPostfix="BlackGlass">
            <Header ImageSpacing="5px" SortingImageSpacing="5px">
            </Header>
        </Styles>
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
        <SettingsSearchPanel Visible="True" />
        <StylesEditors>
            <CalendarHeader Spacing="1px">
            </CalendarHeader>
            <ProgressBar Height="25px">
            </ProgressBar>
        </StylesEditors>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        SelectCommand="SELECT * FROM [Inventory transactions summary by profile and PG1 web] ORDER BY [Year] DESC, [Month] DESC, [Client]">
    </asp:SqlDataSource>
    <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1" runat="server" 
        GridViewID="ASPxGridView1">
    </dx:ASPxGridViewExporter>
    </form>
</body>
</html>
