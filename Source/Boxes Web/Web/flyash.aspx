<%@ Page Language="VB" AutoEventWireup="false" CodeFile="flyash.aspx.vb" Inherits="flyash" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>




<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>fly ash</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Fly Ash Traffic</h3>
        <h3>
            <asp:Button ID="Button1" runat="server" Text="Export to Excel" />
            <br />
        </h3>
    
    </div>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        CssFilePath="~/App_Themes/BlackGlass/{0}/styles.css" CssPostfix="BlackGlass" 
        DataSourceID="SqlDataSource1" Width="1143px" Theme="Aqua">
        <TotalSummary>
            <dx:ASPxSummaryItem FieldName="Pre Scale Time" ShowInColumn="Pre Scale Time" 
                SummaryType="Count" />
            <dx:ASPxSummaryItem FieldName="Pre Scale Time" ShowInColumn="Pre Scale Time" 
                SummaryType="Average" />
            <dx:ASPxSummaryItem FieldName="Scale Time" ShowInColumn="Scale Time" 
                SummaryType="Average" />
            <dx:ASPxSummaryItem FieldName="Total Time" ShowInColumn="Total Time" 
                SummaryType="Average" />
        </TotalSummary>
        <GroupSummary>
            <dx:ASPxSummaryItem FieldName="Pre Scale Time" SummaryType="Count" />
            <dx:ASPxSummaryItem DisplayFormat="pre-scale avg = {0:n0}" 
                FieldName="Pre Scale Time" SummaryType="Average" />
            <dx:ASPxSummaryItem DisplayFormat="scale avg = {0:n0}" FieldName="Scale Time" 
                SummaryType="Average" />
            <dx:ASPxSummaryItem DisplayFormat="total avg = {0:n0}" FieldName="Total Time" 
                SummaryType="Average" />
        </GroupSummary>
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataDateColumn FieldName="Date" GroupIndex="0" ReadOnly="True" 
                SortIndex="0" SortOrder="Descending" VisibleIndex="1">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Pre Scale Time" ReadOnly="True" 
                VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Scale Time" ReadOnly="True" 
                VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Total Time" ReadOnly="True" 
                VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Carrier" VisibleIndex="6">
                <Settings AllowHeaderFilter="True" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Product" VisibleIndex="5">
                <Settings AllowHeaderFilter="True" />
                <CellStyle Wrap="False">
                </CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Destination" VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Lot" VisibleIndex="9">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Ticket" VisibleIndex="10">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTimeEditColumn FieldName="Arrive" SortIndex="1" 
                SortOrder="Ascending" VisibleIndex="11">
                <PropertiesTimeEdit DisplayFormatString="t">
                </PropertiesTimeEdit>
                <CellStyle Wrap="False">
                </CellStyle>
            </dx:GridViewDataTimeEditColumn>
            <dx:GridViewDataTimeEditColumn FieldName="Scale" VisibleIndex="12">
                <PropertiesTimeEdit DisplayFormatString="t">
                </PropertiesTimeEdit>
                <CellStyle Wrap="False">
                </CellStyle>
            </dx:GridViewDataTimeEditColumn>
            <dx:GridViewDataTimeEditColumn FieldName="Depart" VisibleIndex="13">
                <PropertiesTimeEdit DisplayFormatString="t">
                </PropertiesTimeEdit>
                <CellStyle Wrap="False">
                </CellStyle>
            </dx:GridViewDataTimeEditColumn>
            <dx:GridViewDataTextColumn FieldName="Note" VisibleIndex="14" Width="200px">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Customer" VisibleIndex="7">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <SettingsPager PageSize="30">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
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
            <DetailRow Wrap="False">
            </DetailRow>
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
        SelectCommand="SELECT * FROM [fly ash time calcs] ORDER BY [Arrive] DESC">
    </asp:SqlDataSource>
    <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1" runat="server" 
        GridViewID="ASPxGridView1">
    </dx:ASPxGridViewExporter>
    </form>
    <p>
        &nbsp;</p>
</body>
</html>
