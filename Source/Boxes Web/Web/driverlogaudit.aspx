<%@ Page Language="VB" AutoEventWireup="false" CodeFile="driverlogaudit.aspx.vb" Inherits="driverlogaudit" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Driver Log Audit</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Driver Log Audit</h3>
        Filter for 
        starting Plan Date to show drivers missing start times or with incomplete logs.<br />
    
    </div>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        CssFilePath="~/App_Themes/BlackGlass/{0}/styles.css" CssPostfix="BlackGlass" 
        DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Fleet" ShowInCustomizationForm="True" 
                VisibleIndex="1" GroupIndex="0" SortIndex="0" SortOrder="Ascending">
                <Settings AllowAutoFilter="True" AllowAutoFilterTextInputTimer="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Driver" ShowInCustomizationForm="True" 
                VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="Plan Date" ShowInCustomizationForm="True" 
                VisibleIndex="3">
                <PropertiesDateEdit Spacing="0">
                </PropertiesDateEdit>
                <Settings AutoFilterCondition="GreaterOrEqual" />
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataCheckColumn FieldName="Start Time" ReadOnly="True" 
                ShowInCustomizationForm="True" VisibleIndex="4">
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataTextColumn FieldName="Complete" ReadOnly="True" 
                ShowInCustomizationForm="True" VisibleIndex="5">
                <PropertiesTextEdit DisplayFormatString="{0:p0}">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <SettingsPager NumericButtonCount="5" PageSize="50">
        </SettingsPager>
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" 
            ShowHeaderFilterButton="True" ShowGroupPanel="True" ShowFooter="True" />
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
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
        SelectCommand="SELECT * FROM [Driver Log Audit] ORDER BY [Fleet], [Driver], [Plan Date]">
    </asp:SqlDataSource>
    </form>
    <p>
        Drivers and Subs with Agilis phones</p>
</body>
</html>
