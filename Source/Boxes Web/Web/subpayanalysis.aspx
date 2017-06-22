<%@ Page Language="VB" AutoEventWireup="false" CodeFile="subpayanalysis.aspx.vb" Inherits="subpayanalysis" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sub-Hauler Pay Analysis</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Sub-Hauler Pay Analysis</h3>
        <p>
            Actual driver pay over load revenue billing (not invoice). If billing Revenue 
            equals 0, there may be revenue on a manual charge on the revenue invoice.</p>
        <p>
            <asp:Button ID="Button1" runat="server" Text="Export to Excel" />
        </p>
    
    </div>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        CssFilePath="~/App_Themes/Office2010Blue/{0}/styles.css" 
        CssPostfix="Office2010Blue" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
        <TotalSummary>
            <dx:ASPxSummaryItem FieldName="Invoice Total" ShowInColumn="Paid to Sub" 
                SummaryType="Average" ValueDisplayFormat="{0:c2}" />
            <dx:ASPxSummaryItem FieldName="Rev with FSC" ShowInColumn="Rev with FSC" 
                SummaryType="Average" ValueDisplayFormat="{0:c2}" />
            <dx:ASPxSummaryItem FieldName="Percent of Rev" ShowInColumn="Percent of Rev" 
                SummaryType="Average" ValueDisplayFormat="{0:p1}" />
            <dx:ASPxSummaryItem FieldName="Invoice Total" ShowInColumn="Paid to Sub" SummaryType="Sum" />
            <dx:ASPxSummaryItem FieldName="Rev with FSC" ShowInColumn="Rev with FSC" SummaryType="Sum" />
        </TotalSummary>
        <GroupSummary>
            <dx:ASPxSummaryItem DisplayFormat="Avg Paid ={0:c2}" FieldName="Invoice Total" 
                SummaryType="Average" />
            <dx:ASPxSummaryItem DisplayFormat="Avg Rev ={0:c2}" FieldName="Rev with FSC" 
                SummaryType="Average" />
            <dx:ASPxSummaryItem FieldName="Percent of Rev" SummaryType="Average" 
                ValueDisplayFormat="{0:p1}" />
            <dx:ASPxSummaryItem DisplayFormat="Total Paid={0:c2}" FieldName="Invoice Total" 
                SummaryType="Sum" />
            <dx:ASPxSummaryItem DisplayFormat="Rev={0:c2}" FieldName="Rev with FSC" SummaryType="Sum" />
        </GroupSummary>
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Driver" ReadOnly="True" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="Payable Date" FieldName="Invoice Date" 
                VisibleIndex="5">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataDateColumn FieldName="LogOutDate" 
                SortIndex="4" SortOrder="Ascending" VisibleIndex="4">
                <Settings GroupInterval="DateMonth" AllowHeaderFilter="True" />
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn Caption="Load" FieldName="Load Ref" SortIndex="3" 
                SortOrder="Ascending" VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Origin" ReadOnly="True" VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Destination" 
                ReadOnly="True" VisibleIndex="9">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Paid to Sub" FieldName="Invoice Total" 
                VisibleIndex="10">
                <PropertiesTextEdit DisplayFormatString="c">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Rev with FSC" ReadOnly="True" 
                VisibleIndex="11">
                <PropertiesTextEdit DisplayFormatString="c">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Percent of Rev" ReadOnly="True" 
                VisibleIndex="12">
                <PropertiesTextEdit DisplayFormatString="p">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Fleet" GroupIndex="2" SortIndex="2" 
                SortOrder="Ascending" VisibleIndex="3">
                <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Rev Invoice" FieldName="RFS Invoice Ref" 
                VisibleIndex="13">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="RFS Invoice Total" VisibleIndex="14">
                <PropertiesTextEdit DisplayFormatString="c">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Month" GroupIndex="1" ReadOnly="True" SortIndex="1" SortOrder="Descending" VisibleIndex="2">
                <Settings AllowHeaderFilter="True" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Year" GroupIndex="0" ReadOnly="True" SortIndex="0" SortOrder="Descending" VisibleIndex="1">
                <Settings AllowHeaderFilter="True" />
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <SettingsPager PageSize="20">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True" ShowAllItem="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" 
            ShowGroupPanel="True" ShowFilterBar="Visible" />
        <SettingsPopup>
            <HeaderFilter MinHeight="200px" />
            <CustomizationWindow Height="200px" Width="200px" />
        </SettingsPopup>
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
        <SettingsSearchPanel Visible="True" />
        <StylesEditors ButtonEditCellSpacing="0">
            <ProgressBar Height="21px">
            </ProgressBar>
        </StylesEditors>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        SelectCommand="SELECT * FROM [Subhaul Payables]"></asp:SqlDataSource>
    <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" 
        GridViewID="ASPxGridView1">
    </dx:ASPxGridViewExporter>
    </form>
</body>
</html>
