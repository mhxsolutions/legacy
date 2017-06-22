<%@ Page Language="VB" AutoEventWireup="false" CodeFile="DriverReq.aspx.vb" Inherits="DriverReq" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>




<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Driver Info Requirements</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Required Information for Independent Contract Drivers</h3>
        <h3>
            <asp:Button ID="Button1" runat="server" Text="Export to xlsx" />
            <br />
        </h3>
    
    </div>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        CssFilePath="~/App_Themes/BlackGlass/{0}/styles.css" CssPostfix="BlackGlass" 
        DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Driver" GroupIndex="1" ReadOnly="True" 
                SortIndex="1" SortOrder="Ascending" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="Approved" VisibleIndex="3">
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataDateColumn FieldName="Expires" VisibleIndex="4">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Fleet" GroupIndex="0" SortIndex="0" 
                SortOrder="Ascending" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Notes" FieldName="Class Data" 
                VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Sort Order" SortIndex="2" 
                SortOrder="Ascending" Visible="False" VisibleIndex="7">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <SettingsPager PageSize="150">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterBar="Visible" ShowFilterRowMenu="True" ShowFooter="True" />
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
            <Row Wrap="False">
            </Row>
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
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
        SelectCommand="SELECT * FROM [Driver Info Needed] ORDER BY [Driver], [Description]">
    </asp:SqlDataSource>
    <dx:ASPxGridViewExporter ID="gridexport" runat="server" FileName="SubReqInfo" 
        GridViewID="ASPxGridView1">
    </dx:ASPxGridViewExporter>
    </form>
    <p>
        Includes IC drivers missing required items or expiring within 30 days.</p>
    <p>
        Only drivers requiring information are shown.
        <span class="dxcaRefreshButtonText_BlackGlass">Goal = Empty List</span></p>
    <p>
        Title = Driver. No Driver-NLE shown.</p>
    <p>
        Owner Operators only. No 3rd Party Company drivers.</p>
</body>
</html>
