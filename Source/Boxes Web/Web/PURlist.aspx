<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PURlist.aspx.vb" Inherits="PURlist" %>

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
            PUR list<br />
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            CssFilePath="~/App_Themes/Office2010Blue/{0}/styles.css" 
            CssPostfix="Office2010Blue" DataSourceID="SqlDataSource1" 
            KeyFieldName="Load" EnableTheming="True" Theme="Office2003Blue">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="Fleet" GroupIndex="0" SortIndex="0" 
                    SortOrder="Ascending" VisibleIndex="1">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True"/>
                <dx:GridViewDataDateColumn FieldName="Pick Up Date" SortIndex="1" 
                    SortOrder="Descending" VisibleIndex="2">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Load" ReadOnly="True" SortIndex="2" 
                    SortOrder="Descending" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Shipper" ReadOnly="True" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Origin" ReadOnly="True" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Destination" ReadOnly="True" 
                    VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Receiver" ReadOnly="True" 
                    VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="LogOut" VisibleIndex="8">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTimeEditColumn FieldName="LogOutTime" VisibleIndex="9">
                    <PropertiesTimeEdit DisplayFormatString="t">
                    </PropertiesTimeEdit>
                </dx:GridViewDataTimeEditColumn>
                <dx:GridViewDataDateColumn FieldName="LogOutDate" VisibleIndex="10">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataCheckColumn FieldName="POD" VisibleIndex="11">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTimeEditColumn FieldName="POD Time" VisibleIndex="12">
                    <PropertiesTimeEdit DisplayFormatString="t">
                    </PropertiesTimeEdit>
                </dx:GridViewDataTimeEditColumn>
                <dx:GridViewDataDateColumn FieldName="POD Date" VisibleIndex="13">
                </dx:GridViewDataDateColumn>
            </Columns>
            <SettingsPager PageSize="100">
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" />
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
            SelectCommand="SELECT * FROM [PUR on TPL]"></asp:SqlDataSource>
    
    </div>
    </form>
    <p>
        PURs assigned to Loads</p>
</body>
</html>
