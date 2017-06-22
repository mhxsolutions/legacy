<%@ Page Language="VB" AutoEventWireup="false" CodeFile="willcall_dwell.aspx.vb" Inherits="willcall_dwell" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Will Call Dwell</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Will Call Dwell<br />
        </h3>
    
    </div>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        CssFilePath="~/App_Themes/BlackGlass/{0}/styles.css" CssPostfix="BlackGlass" 
        DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
        <TotalSummary>
            <dx:ASPxSummaryItem FieldName="Dwell" ShowInColumn="Dwell" 
                SummaryType="Average" />
        </TotalSummary>
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Client Name" VisibleIndex="2">
                <Settings AutoFilterCondition="Contains" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="LoadDate" VisibleIndex="1" SortIndex="0" 
                SortOrder="Descending">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Dwell" ReadOnly="True" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="Complete" FieldName="WC Comp Time" 
                SortIndex="2" SortOrder="Ascending" VisibleIndex="5">
                <PropertiesDateEdit DisplayFormatString="t">
                </PropertiesDateEdit>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn Caption="Type" FieldName="WC Type" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="Arrive" FieldName="LoadDate" SortIndex="1" 
                SortOrder="Ascending" VisibleIndex="4">
                <PropertiesDateEdit DisplayFormatString="t">
                </PropertiesDateEdit>
            </dx:GridViewDataDateColumn>
        </Columns>
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <SettingsPager PageSize="25">
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" 
            ShowGroupPanel="True" ShowFilterBar="Visible" />
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
        SelectCommand="SELECT * FROM [willcall dwell] ORDER BY [LoadDate] DESC, [Client Name]">
    </asp:SqlDataSource>
    </form>
</body>
</html>
