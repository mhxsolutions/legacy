<%@ Page Language="VB" AutoEventWireup="false" CodeFile="planning_status.aspx.vb" Inherits="planning_status" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Planning Status</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Planning Status Overview - Budway<br />
        </h3>
    
    </div>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2010Blue">
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Fleet" SortIndex="0" 
                SortOrder="Ascending" VisibleIndex="1">
                <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="LoadDate" SortIndex="1" 
                SortOrder="Descending" VisibleIndex="2">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Load Ct" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Unplanned" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Unassigned" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="No LogOut" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <SettingsPager>
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterRowMenu="True" ShowFilterBar="Visible" />
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
        <SettingsPopup>
            <HeaderFilter MinHeight="200px" />
        </SettingsPopup>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        SelectCommand="SELECT * FROM [Planning_status_p1] WHERE ([Fleet] LIKE '%' + @Fleet + '%')">
        <SelectParameters>
            <asp:Parameter DefaultValue="bud" Name="Fleet" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    </form>
    <p>
        <a href="planning_status_detail.aspx">Load Detail</a></p>
    <p>
        Analyzes all loads not marked Will Call</p>
    <p>
        Removes all days with Unplanned=0, Unassigned=0, No Log Out=0</p>
</body>
</html>
