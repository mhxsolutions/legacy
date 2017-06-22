<%@ Page Language="VB" AutoEventWireup="false" CodeFile="coilsstaged.aspx.vb" Inherits="coilsstaged" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Coils Staged<br />
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            CssFilePath="~/App_Themes/Office2010Blue/{0}/styles.css" 
            CssPostfix="Office2010Blue" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="Shipped" ShowInColumn="Shipped" 
                    SummaryType="Sum" />
                <dx:ASPxSummaryItem FieldName="Staged" ShowInColumn="Staged" 
                    SummaryType="Sum" />
            </TotalSummary>
            <GroupSummary>
                <dx:ASPxSummaryItem DisplayFormat="Shipped={0:n0}" FieldName="Shipped" 
                    SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="Staged={0:n0}" FieldName="Staged" 
                    SummaryType="Sum" />
            </GroupSummary>
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataDateColumn FieldName="Date" GroupIndex="0" SortIndex="0" 
                    SortOrder="Descending" VisibleIndex="1">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Client" SortIndex="1" 
                    SortOrder="Ascending" VisibleIndex="2">
                    <Settings AutoFilterCondition="Contains" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Staged" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Shipped" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Percent Staged" ReadOnly="True" 
                    VisibleIndex="5">
                    <PropertiesTextEdit DisplayFormatString="{0:p0}">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="100">
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
            SelectCommand="SELECT * FROM [Coils Shipped v Staged by client with percent]">
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
