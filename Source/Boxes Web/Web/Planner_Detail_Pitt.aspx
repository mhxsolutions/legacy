<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Planner_Detail_Pitt.aspx.vb" Inherits="Planner_Detail_Pitt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Planner Detail - Pittsburg</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Planner Status Detail - Pittsburg - <a href="pitt_default.aspx">home</a></h3>
    
    </div>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Load" 
        Theme="Aqua">
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataDateColumn Caption="Load Date" FieldName="Date" ReadOnly="True" 
                SortIndex="0" SortOrder="Descending" VisibleIndex="2">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Client" ReadOnly="True" SortIndex="1" 
                SortOrder="Ascending" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Load" ReadOnly="True" SortIndex="2" 
                SortOrder="Ascending" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="Planned" ReadOnly="True" VisibleIndex="5">
                <PropertiesDateEdit EnableFocusedStyle="False">
                </PropertiesDateEdit>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Assigned" ReadOnly="True" 
                VisibleIndex="6">
                <PropertiesTextEdit EnableFocusedStyle="False">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="LogOut" ReadOnly="True" VisibleIndex="7">
            </dx:GridViewDataCheckColumn>
        </Columns>
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <SettingsPager PageSize="100">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" ShowFilterBar="Visible" />
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        SelectCommand="SELECT * FROM [Planner Status Detail] WHERE ([Fleet] = @Fleet)">
        <SelectParameters>
            <asp:Parameter DefaultValue="bud- pittsburg" Name="Fleet" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    </form>
    <p>
        Bucket + Planned but not Logged Out</p>
</body>
</html>
