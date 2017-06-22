<%@ Page Language="VB" AutoEventWireup="false" CodeFile="inventory.aspx.vb" Inherits="inventory" %>

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
            All available and committed inventory</h3>
        <p>
            <br />
            Detail lines are combined when all columns are identical. (excluding Totals)<dx:ASPxButton 
                ID="ASPxButton1" runat="server" Text="Export to Excel" Theme="Office2003Olive" 
                Width="130px">
            </dx:ASPxButton>
        </p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            CssFilePath="~/App_Themes/Office2003Olive/gridview/styles.css" 
            CssPostfix="Office2003Olive" DataSourceID="SqlDataSource1" 
            Theme="Office2003Olive">
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="Ct TOTAL" ShowInColumn="Ct TOTAL" 
                    SummaryType="Sum" />
                <dx:ASPxSummaryItem FieldName="Ct Committed" ShowInColumn="Ct Committed" 
                    SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="Sum={0:n1}" FieldName="Footage Total" 
                    ShowInColumn="Footage Total" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="Sum={0:n1}" FieldName="Tons Total" 
                    ShowInColumn="Tons Total" SummaryType="Sum" />
            </TotalSummary>
            <GroupSummary>
                <dx:ASPxSummaryItem DisplayFormat="Ct={0:n0}" FieldName="Ct TOTAL" 
                    SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="Committed={0:n0}" FieldName="Ct Committed" 
                    SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="Footage={0:n1}" FieldName="Footage Total" 
                    SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="Tons={0:n1}" FieldName="Tons Total" 
                    SummaryType="Sum" />
            </GroupSummary>
            <Columns>
                <dx:GridViewDataTextColumn FieldName="Terminal" GroupIndex="0" SortIndex="0" 
                    SortOrder="Ascending" VisibleIndex="0">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Location" SortIndex="1" 
                    SortOrder="Ascending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Profile" SortIndex="2" 
                    SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
<dx:GridViewDataTextColumn FieldName="Client" SortIndex="3" SortOrder="Ascending" 
                    ShowInCustomizationForm="True" VisibleIndex="3"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Ext Desc" SortIndex="4" 
                    SortOrder="Ascending" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="PG1" SortIndex="5" SortOrder="Ascending" 
                    VisibleIndex="5">
                    <Settings AutoFilterCondition="Contains" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="PG2" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="PG3" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Item ID" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Pcs ea" VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Footage ea" VisibleIndex="11">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Wt ea" VisibleIndex="13">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Ct TOTAL" VisibleIndex="15">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Pcs Total" ReadOnly="True" 
                    VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Footage Total" ReadOnly="True" 
                    VisibleIndex="12">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons Total" ReadOnly="True" 
                    VisibleIndex="14">
                    <PropertiesTextEdit DisplayFormatString="{0:n1}">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Ct Committed" VisibleIndex="16">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager PageSize="200">
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" 
                ShowFooter="True" ShowGroupPanel="True" />
            <SettingsCustomizationWindow Enabled="True" Height="100px" Width="100px" />
            <Images SpriteCssFilePath="~/App_Themes/Office2003Olive/gridview/sprite.css">
                <LoadingPanelOnStatusBar Url="~/App_Themes/Office2003Olive/GridView/gvLoadingOnStatusBar.gif">
                </LoadingPanelOnStatusBar>
                <LoadingPanel Url="~/App_Themes/Office2003Olive/GridView/Loading.gif">
                </LoadingPanel>
            </Images>
            <ImagesFilterControl>
                <LoadingPanel Url="~/App_Themes/Office2003Olive/Editors/Loading.gif">
                </LoadingPanel>
            </ImagesFilterControl>
            <Styles CssFilePath="~/App_Themes/Office2003Olive/gridview/styles.css" 
                CssPostfix="Office2003Olive">
                <Header ImageSpacing="5px" SortingImageSpacing="5px">
                </Header>
                <DetailCell Wrap="False">
                </DetailCell>
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
            
            SelectCommand="SELECT * FROM [Inventory Summary available and committed with profiles]">
        </asp:SqlDataSource>
    
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" 
            FileName="available and committed inventory" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    
    </div>
    </form>
    <p>
        Committed inventory is on a BOL but the load has not been marked Log Out.</p>
    <p>
        Available inventory has been received, the receiver locked, but not placed on 
        BOL.</p>
</body>
</html>
