<%@ Page Language="VB" AutoEventWireup="false" CodeFile="revenue_by_client.aspx.vb" Inherits="revenue_by_client" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>




<%@ Register assembly="DevExpress.Web.ASPxPivotGrid.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPivotGrid" tagprefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Revenue by Client</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Revenue by Client</h3>
        <p>
            <a href="revenue_by_client_pivot.aspx">pivot table</a></p>
        <p>
            &nbsp;</p>
        <p>
            Summary by Year<dx:ASPxGridView 
                ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" 
                DataSourceID="SqlDataSource2" EnableTheming="True" Theme="Metropolis">
                <GroupSummary>
                    <dx:ASPxSummaryItem DisplayFormat="c" FieldName="Total" SummaryType="Sum" />
                </GroupSummary>
                <SettingsSearchPanel Visible="True" />
                <Columns>
                    <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                    </dx:GridViewCommandColumn>
                    <dx:GridViewDataTextColumn FieldName="Year" SortIndex="1" 
                        SortOrder="Descending" VisibleIndex="2">
                        <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Fleet" GroupIndex="0" SortIndex="0" 
                        SortOrder="Ascending" VisibleIndex="1">
                        <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Client" VisibleIndex="3">
                        <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Total" SortIndex="2" 
                        SortOrder="Descending" VisibleIndex="4">
                        <PropertiesTextEdit DisplayFormatString="c">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>
                </Columns>
                <SettingsContextMenu Enabled="True" EnableRowMenu="False">
                </SettingsContextMenu>
                <SettingsPager>
                    <AllButton Visible="True">
                    </AllButton>
                    <PageSizeItemSettings Visible="True">
                    </PageSizeItemSettings>
                </SettingsPager>
                <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterBar="Visible" ShowFooter="True" />
                <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
                <SettingsPopup>
                    <HeaderFilter MinHeight="300px" />
                </SettingsPopup>
            </dx:ASPxGridView>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
                SelectCommand="SELECT * FROM [RFS Invoiced Totals by client by year]">
            </asp:SqlDataSource>
            </a></p>
        <p>
            Detail<dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        CssFilePath="~/App_Themes/Office2010Blue/{0}/styles.css" 
        CssPostfix="Office2010Blue" DataSourceID="SqlDataSource1" 
        Theme="Metropolis" EnableTheming="True">
                <GroupSummary>
                    <dx:ASPxSummaryItem DisplayFormat="c" FieldName="Total" SummaryType="Sum" />
                </GroupSummary>
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Year" SortIndex="0" 
                SortOrder="Descending" VisibleIndex="1">
                <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Month" SortIndex="1" 
                SortOrder="Descending" VisibleIndex="2">
                <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Fleet" VisibleIndex="3">
                <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Client" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="GL" FieldName="GL Code Abr" 
                VisibleIndex="4">
                <PropertiesTextEdit DisplayFormatString="{0:c}">
                </PropertiesTextEdit>
                <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Total" SortIndex="2" 
                SortOrder="Descending" VisibleIndex="8">
                <PropertiesTextEdit DisplayFormatString="{0:c2}">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
        </Columns>
                <SettingsContextMenu Enabled="True" EnableRowMenu="False">
                </SettingsContextMenu>
        <SettingsPager PageSize="50">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" 
            ShowGroupPanel="True" ShowFooter="True" />
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
        </p>
    
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        SelectCommand="SELECT * FROM [RFS Invoiced totals by client] ORDER BY [Year] DESC, [Month] DESC, [Total] DESC">
    </asp:SqlDataSource>
    </form>
</body>
</html>
