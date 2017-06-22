<%@ Page Language="VB" AutoEventWireup="false" CodeFile="flyashtonnes.aspx.vb" Inherits="flyashtonnes" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=320" />
    <title>Fly Ash Tonnes</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Fly Ash Tonnes<br />
        </h3>
        <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" 
            CssFilePath="~/App_Themes/Office2010Blue/{0}/styles.css" 
            CssPostfix="Office2010Blue" DataSourceID="SqlDataSource1">
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="Ct" ShowInColumn="Ct" SummaryType="Sum" />
                <dx:ASPxSummaryItem FieldName="Tonne" ShowInColumn="Tonne" SummaryType="Sum" />
                <dx:ASPxSummaryItem FieldName="Tons" ShowInColumn="Tons" SummaryType="Sum" />
            </TotalSummary>
            <GroupSummary>
                <dx:ASPxSummaryItem DisplayFormat="Count = {0:n0}" FieldName="Ct" 
                    SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="Tonne = {0:n2}" FieldName="Tonne" 
                    SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="Tons = {0:n2}" FieldName="Tons" 
                    SummaryType="Sum" />
            </GroupSummary>
            <Columns>
                <dx:GridViewDataTextColumn FieldName="Customer" SortIndex="2" 
                    SortOrder="Ascending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Product" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Ct" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tonne" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Pounds" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Date" SortIndex="3" SortOrder="Ascending" 
                    VisibleIndex="0">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn Caption="Year" FieldName="year" GroupIndex="0" 
                    SortIndex="0" SortOrder="Ascending" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Month" FieldName="month" GroupIndex="1" 
                    SortIndex="1" SortOrder="Ascending" VisibleIndex="9">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager PageSize="25">
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFooter="True" 
                ShowGroupFooter="VisibleIfExpanded" ShowGroupPanel="True" />
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
            <StylesEditors ButtonEditCellSpacing="0">
                <ProgressBar Height="21px">
                </ProgressBar>
            </StylesEditors>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [fly ash weight summary tonne]">
        </asp:SqlDataSource>
    
    </div>

    </form>
</body>
</html>
