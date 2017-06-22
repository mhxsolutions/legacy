<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ClientTons.aspx.vb" Inherits="ClientTons" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Client Tons</title>
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            width: 554px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Tons Handled by Client</h3>
        <table class="style1">
            <tr>
                <td class="style2">
                    Receiving</td>
                <td>
                    Shipping</td>
            </tr>
            <tr>
                <td class="style2" valign="top">
                    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
                        CssFilePath="~/App_Themes/Office2003Blue/{0}/styles.css" 
                        CssPostfix="Office2003Blue" DataSourceID="SqlDataSource1">
                        <TotalSummary>
                            <dx:ASPxSummaryItem DisplayFormat="Tons In = {0:n1}" FieldName="Tons In" 
                                SummaryType="Sum" />
                        </TotalSummary>
                        <GroupSummary>
                            <dx:ASPxSummaryItem DisplayFormat="Tons In = {0:n1}" FieldName="Tons In" 
                                SummaryType="Sum" />
                        </GroupSummary>
                        <Columns>
                            <dx:GridViewDataTextColumn FieldName="Fleet" GroupIndex="0" SortIndex="0" 
                                SortOrder="Ascending" VisibleIndex="0">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Yr" GroupIndex="1" SortIndex="1" 
                                SortOrder="Descending" VisibleIndex="1">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Mo" GroupIndex="2" SortIndex="2" 
                                SortOrder="Descending" VisibleIndex="2">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="Client" FieldName="Client Name" 
                                SortIndex="2" SortOrder="Ascending" VisibleIndex="3">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Tons In" VisibleIndex="6">
                                <PropertiesTextEdit DisplayFormatString="{0:n1}">
                                </PropertiesTextEdit>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="Type" FieldName="Receiver Type" 
                                SortIndex="4" SortOrder="Ascending" VisibleIndex="4">
                            </dx:GridViewDataTextColumn>
                        </Columns>
                        <SettingsPager PageSize="25">
                        </SettingsPager>
                        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" 
                            ShowGroupedColumns="True" ShowGroupPanel="True" />
                        <Images SpriteCssFilePath="~/App_Themes/Office2003Blue/{0}/sprite.css">
                            <LoadingPanelOnStatusBar Url="~/App_Themes/Office2003Blue/GridView/gvLoadingOnStatusBar.gif">
                            </LoadingPanelOnStatusBar>
                            <LoadingPanel Url="~/App_Themes/Office2003Blue/GridView/Loading.gif">
                            </LoadingPanel>
                        </Images>
                        <ImagesFilterControl>
                            <LoadingPanel Url="~/App_Themes/Office2003Blue/Editors/Loading.gif">
                            </LoadingPanel>
                        </ImagesFilterControl>
                        <Styles CssFilePath="~/App_Themes/Office2003Blue/{0}/styles.css" 
                            CssPostfix="Office2003Blue">
                            <Header ImageSpacing="5px" SortingImageSpacing="5px">
                            </Header>
                            <LoadingPanel ImageSpacing="10px">
                            </LoadingPanel>
                        </Styles>
                        <StylesEditors>
                            <ProgressBar Height="25px">
                            </ProgressBar>
                        </StylesEditors>
                    </dx:ASPxGridView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
                        SelectCommand="SELECT * FROM [Tons received by client fleet month]">
                    </asp:SqlDataSource>
                    <br />
                    Data from DWS Receivers (no UPI)</td>
                <td valign="top">
                    <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" 
                        CssFilePath="~/App_Themes/Office2003Olive/{0}/styles.css" 
                        CssPostfix="Office2003Olive" DataSourceID="SqlDataSource2">
                        <TotalSummary>
                            <dx:ASPxSummaryItem DisplayFormat="Tons Out = {0:n1}" FieldName="Tons Out" 
                                SummaryType="Sum" />
                        </TotalSummary>
                        <GroupSummary>
                            <dx:ASPxSummaryItem DisplayFormat="Ton Out = {0:n1}" FieldName="Tons Out" 
                                SummaryType="Sum" />
                        </GroupSummary>
                        <Columns>
                            <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True">

                            </dx:GridViewCommandColumn>
                            <dx:GridViewDataTextColumn FieldName="Fleet" GroupIndex="0" SortIndex="0" 
                                SortOrder="Ascending" VisibleIndex="1">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Yr" GroupIndex="1" SortIndex="1" 
                                SortOrder="Descending" VisibleIndex="2">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Mo" GroupIndex="2" SortIndex="2" 
                                SortOrder="Descending" VisibleIndex="3">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="Client" FieldName="Client Name" 
                                SortIndex="3" SortOrder="Ascending" VisibleIndex="5">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Tons Out" VisibleIndex="6">
                                <PropertiesTextEdit DisplayFormatString="{0:n1}">
                                </PropertiesTextEdit>
                            </dx:GridViewDataTextColumn>
                        </Columns>
                        <SettingsPager PageSize="25">
                        </SettingsPager>
                        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" 
                            ShowGroupedColumns="True" ShowGroupPanel="True" />
                        <Images SpriteCssFilePath="~/App_Themes/Office2003Olive/{0}/sprite.css">
                            <LoadingPanelOnStatusBar Url="~/App_Themes/Office2003Olive/GridView/gvLoadingOnStatusBar.gif">
                            </LoadingPanelOnStatusBar>
                            <LoadingPanel Url="~/App_Themes/Office2003Olive/GridView/Loading.gif">
                            </LoadingPanel>
                        </Images>
                        <ImagesFilterControl>
                            <LoadingPanel Url="~/App_Themes/Office2003Olive/Editors/Loading.gif">
                            </LoadingPanel>
                        </ImagesFilterControl>
                        <Styles CssFilePath="~/App_Themes/Office2003Olive/{0}/styles.css" 
                            CssPostfix="Office2003Olive">
                            <Header ImageSpacing="5px" SortingImageSpacing="5px">
                            </Header>
                            <LoadingPanel ImageSpacing="10px">
                            </LoadingPanel>
                        </Styles>
                        <StylesEditors>
                            <ProgressBar Height="25px">
                            </ProgressBar>
                        </StylesEditors>
                    </dx:ASPxGridView>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
                        SelectCommand="SELECT * FROM [tons shipped by client fleet month]">
                    </asp:SqlDataSource>
                    <br />
                    Data from DWS Loads gross weight (UPI included, no Thoro)</td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
