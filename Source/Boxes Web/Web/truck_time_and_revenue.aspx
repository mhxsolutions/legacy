<%@ Page Language="VB" AutoEventWireup="false" CodeFile="truck_time_and_revenue.aspx.vb" Inherits="truck_time_and_revenue" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Truck Time and Revenue</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Truck Time and Revenue - Fontana</h3>
        <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export to Excel" 
            Theme="Aqua" Width="127px">
        </dx:ASPxButton>
    
    </div>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Aqua">
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Truck" SortIndex="1" 
                SortOrder="Ascending" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="Plan Date" SortIndex="0" 
                SortOrder="Descending" VisibleIndex="1">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Est Transit" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Est Dwell" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Act Transit" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Act Dwell" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Private Revnue" VisibleIndex="7">
                <PropertiesTextEdit DisplayFormatString="c">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Public Revenue" VisibleIndex="8">
                <PropertiesTextEdit DisplayFormatString="c">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <SettingsPager PageSize="20">
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" 
            ShowGroupPanel="True" />
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        SelectCommand="SELECT * FROM [Truck time and revenue] WHERE ([Fleet ref] = @Fleet_ref)">
        <SelectParameters>
            <asp:Parameter DefaultValue="1" Name="Fleet_ref" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" 
        FileName="truck time and revenue" GridViewID="ASPxGridView1">
    </dx:ASPxGridViewExporter>
    </form>
</body>
</html>
