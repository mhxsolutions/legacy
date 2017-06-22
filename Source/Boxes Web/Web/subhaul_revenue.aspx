<%@ Page Language="VB" AutoEventWireup="false" CodeFile="subhaul_revenue.aspx.vb" Inherits="subhaul_revenue" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Subhaul Revenue</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Subhaul Generated RFS Revenue<br />
        </h3>
    
    </div>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        CssFilePath="~/App_Themes/Office2010Blue/{0}/styles.css" 
        CssPostfix="Office2010Blue" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
        <TotalSummary>
            <dx:ASPxSummaryItem FieldName="Total" ShowInColumn="Total" SummaryType="Sum" />
        </TotalSummary>
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Year" VisibleIndex="1">
                <Settings AllowHeaderFilter="True" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Month" VisibleIndex="2">
                <Settings AllowHeaderFilter="True" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Fleet" VisibleIndex="3">
                <Settings AllowHeaderFilter="True" AutoFilterCondition="Contains" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="RFS Rate" VisibleIndex="4">
                <PropertiesTextEdit DisplayFormatString="{0:c}">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FSC" VisibleIndex="5">
                <PropertiesTextEdit DisplayFormatString="{0:c}">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Total" VisibleIndex="6">
                <PropertiesTextEdit DisplayFormatString="{0:c}">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <SettingsPager PageSize="25">
        </SettingsPager>
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" 
            ShowFooter="True" ShowGroupPanel="True" />
        <Images SpriteCssFilePath="~/App_Themes/Office2010Blue/{0}/sprite.css">
            <LoadingPanelOnStatusBar Url="~/App_Themes/Office2010Blue/GridView/Loading.gif">
            </LoadingPanelOnStatusBar>
            <LoadingPanel Url="~/App_Themes/Office2010Blue/GridView/Loading.gif">
            </LoadingPanel>
        </Images>
        <ImagesFilterControl>
            <LoadingPanel Url="~/App_Themes/Office2010Blue/GridView/Loading.gif">
            </LoadingPanel>
        </ImagesFilterControl>
        <Styles CssFilePath="~/App_Themes/Office2010Blue/{0}/styles.css" 
            CssPostfix="Office2010Blue">
            <Header ImageSpacing="5px" SortingImageSpacing="5px">
            </Header>
            <LoadingPanel ImageSpacing="5px">
            </LoadingPanel>
        </Styles>
        <StylesPager>
            <PageNumber ForeColor="#3E4846">
            </PageNumber>
            <Summary ForeColor="#1E395B">
            </Summary>
        </StylesPager>
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
        <SettingsSearchPanel Visible="True" />
        <StylesEditors ButtonEditCellSpacing="0">
            <ProgressBar Height="21px">
            </ProgressBar>
        </StylesEditors>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        SelectCommand="SELECT * FROM [Subhaul RFS revenue] ORDER BY [Year] DESC, [Month] DESC, [Fleet]">
    </asp:SqlDataSource>
    </form>
    <p>
        Includes RFS auto-generated revenue only. No hourly, manual invoicing included.</p>
</body>
</html>
