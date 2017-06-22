<%@ Page Language="VB" AutoEventWireup="false" CodeFile="fontanadwell.aspx.vb" Inherits="fontanadwell" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=320" />
    <title>Fontana Dwell</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Fontana Dwell</h3>
    
    </div>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" 
        DataSourceID="SqlDataSource1">
        <Columns>
            <dx:GridViewDataTextColumn FieldName="Date" VisibleIndex="0">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataProgressBarColumn FieldName="Pit Dwell" VisibleIndex="1">
                <PropertiesProgressBar DisplayFormatString="" DisplayMode="Position" Height="" 
                    Maximum="30" Minimum="5" Width="">
                </PropertiesProgressBar>
            </dx:GridViewDataProgressBarColumn>
            <dx:GridViewDataTextColumn FieldName="Track 5 Dwell" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataProgressBarColumn FieldName="Yard Dwell" VisibleIndex="3">
                <PropertiesProgressBar DisplayFormatString="" DisplayMode="Position" Height="" 
                    Maximum="50" Minimum="5" Width="">
                </PropertiesProgressBar>
            </dx:GridViewDataProgressBarColumn>
            <dx:GridViewDataProgressBarColumn FieldName="Dwell" VisibleIndex="4">
                <PropertiesProgressBar DisplayFormatString="" DisplayMode="Position" Height="" 
                    Maximum="40" Minimum="5" Width="">
                </PropertiesProgressBar>
            </dx:GridViewDataProgressBarColumn>
        </Columns>
        <SettingsLoadingPanel ImagePosition="Top" />
        <Images SpriteCssFilePath="~/App_Themes/Aqua/{0}/sprite.css">
            <LoadingPanelOnStatusBar Url="~/App_Themes/Aqua/GridView/gvLoadingOnStatusBar.gif">
            </LoadingPanelOnStatusBar>
            <LoadingPanel Url="~/App_Themes/Aqua/GridView/Loading.gif">
            </LoadingPanel>
        </Images>
        <ImagesEditors>
            <DropDownEditDropDown>
                <SpriteProperties HottrackedCssClass="dxEditors_edtDropDownHover_Aqua" 
                    PressedCssClass="dxEditors_edtDropDownPressed_Aqua" />
            </DropDownEditDropDown>
            <SpinEditIncrement>
                <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditIncrementImageHover_Aqua" 
                    PressedCssClass="dxEditors_edtSpinEditIncrementImagePressed_Aqua" />
            </SpinEditIncrement>
            <SpinEditDecrement>
                <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditDecrementImageHover_Aqua" 
                    PressedCssClass="dxEditors_edtSpinEditDecrementImagePressed_Aqua" />
            </SpinEditDecrement>
            <SpinEditLargeIncrement>
                <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeIncImageHover_Aqua" 
                    PressedCssClass="dxEditors_edtSpinEditLargeIncImagePressed_Aqua" />
            </SpinEditLargeIncrement>
            <SpinEditLargeDecrement>
                <SpriteProperties HottrackedCssClass="dxEditors_edtSpinEditLargeDecImageHover_Aqua" 
                    PressedCssClass="dxEditors_edtSpinEditLargeDecImagePressed_Aqua" />
            </SpinEditLargeDecrement>
        </ImagesEditors>
        <ImagesFilterControl>
            <LoadingPanel Url="~/App_Themes/Aqua/Editors/Loading.gif">
            </LoadingPanel>
        </ImagesFilterControl>
        <Styles CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua">
            <LoadingPanel ImageSpacing="8px">
            </LoadingPanel>
        </Styles>
        <StylesEditors>
            <CalendarHeader Spacing="1px">
            </CalendarHeader>
            <ProgressBar Height="25px">
            </ProgressBar>
        </StylesEditors>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        SelectCommand="SELECT * FROM [Gage dwell]"></asp:SqlDataSource>
    </form>
</body>
</html>
