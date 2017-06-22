<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TonsbyFleet.aspx.vb" Inherits="TonsbyFleet" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            width: 426px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Tons by Fleet and Date<br />
        </h3>
    
    </div>
    <table class="style1">
        <tr>
            <td class="style2">
                <strong>Receivers</strong></td>
            <td>
                BOLs</td>
        </tr>
        <tr>
            <td class="style2" valign="top">
                <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
                    CssFilePath="~/App_Themes/Office2010Silver/{0}/styles.css" 
                    CssPostfix="Office2010Silver" DataSourceID="SqlDataSource1" Theme="Office2010Silver">
                    <Columns>
                        <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn FieldName="Fleet" VisibleIndex="1">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="Tons_in" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn FieldName="Date" VisibleIndex="3">
                            <PropertiesDateEdit Spacing="0">
                            </PropertiesDateEdit>
                        </dx:GridViewDataDateColumn>
                    </Columns>
                    <Images SpriteCssFilePath="~/App_Themes/Office2010Silver/{0}/sprite.css">
                        <LoadingPanelOnStatusBar Url="~/App_Themes/Office2010Silver/GridView/Loading.gif">
                        </LoadingPanelOnStatusBar>
                        <LoadingPanel Url="~/App_Themes/Office2010Silver/GridView/Loading.gif">
                        </LoadingPanel>
                    </Images>
                    <ImagesFilterControl>
                        <LoadingPanel Url="~/App_Themes/Office2010Silver/GridView/Loading.gif">
                        </LoadingPanel>
                    </ImagesFilterControl>
                    <Styles CssFilePath="~/App_Themes/Office2010Silver/{0}/styles.css" 
                        CssPostfix="Office2010Silver">
                        <Header ImageSpacing="5px" SortingImageSpacing="5px">
                        </Header>
                        <LoadingPanel ImageSpacing="5px">
                        </LoadingPanel>
                    </Styles>
                    <Settings ShowFilterRow="True" />
                    <StylesEditors ButtonEditCellSpacing="0">
                        <ProgressBar Height="21px">
                        </ProgressBar>
                    </StylesEditors>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
                    SelectCommand="SELECT [Fleet], [Tons in] AS Tons_in, [Date] FROM [Tons received by Fleet and Date] ORDER BY [Date] DESC, [Fleet]">
                </asp:SqlDataSource>
            </td>
            <td valign="top">
                <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="SqlDataSource2" Theme="Office2010Blue">
                    <Settings ShowFilterRow="True" />
                    <Columns>
                        <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn FieldName="Fleet" VisibleIndex="1">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn FieldName="Date" VisibleIndex="3">
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn FieldName="Tons Out" VisibleIndex="2">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
                    SelectCommand="SELECT * FROM [Tons Shipped by Fleet and date] ORDER BY [Date] DESC, [Fleet]">
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
