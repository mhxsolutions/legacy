<%@ Page Language="VB" AutoEventWireup="false" CodeFile="current_inventory_summary.aspx.vb" Inherits="current_inventory_summary" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Current Inventory</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Current Inventory Summary (with pending BOLs)</h3>
        <br />
        Includes available and committed inventory, everything in yard.<br />
        <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export to Excel" 
            Theme="Metropolis" Width="131px">
        </dx:ASPxButton>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn Caption="Client" FieldName="Client Name" 
                    SortIndex="2" SortOrder="Ascending" VisibleIndex="3">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Profile" 
                    FieldName="Product Profile Description" SortIndex="3" SortOrder="Ascending" 
                    VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="PG1" FieldName="Product Group 1" 
                    VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="PG2" FieldName="Product Group 2" 
                    VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="PG3" FieldName="Product Group 3" 
                    VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Count" VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Linear Ft" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Terminal" FieldName="Term abr" 
                    GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsPopup>
                <HeaderFilter MinHeight="200px" />
            </SettingsPopup>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [client inventory summary with pending BOL]">
        </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" 
            FileName="current inventory with pending" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    
    </div>
    </form>
</body>
</html>
