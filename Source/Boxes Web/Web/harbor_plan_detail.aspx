<%@ Page Language="VB" AutoEventWireup="false" CodeFile="harbor_plan_detail.aspx.vb" Inherits="harbor_plan_detail" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Harbor Detail</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Harbor Plan - Load and Driver Detail</h3>
        <br />
        <asp:Button ID="Button1" runat="server" Text="Export to Excel" />
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataDateColumn FieldName="Plan Date" GroupIndex="0" SortIndex="0" 
                    SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Vessel" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Shipper" ReadOnly="True" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Origin" GroupIndex="1" ReadOnly="True" 
                    SortIndex="1" SortOrder="Ascending" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTimeEditColumn FieldName="Arrive Origin" ReadOnly="True" 
                    SortIndex="2" SortOrder="Ascending" VisibleIndex="6">
                </dx:GridViewDataTimeEditColumn>
                <dx:GridViewDataTextColumn FieldName="Load Time" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTimeEditColumn FieldName="Depart Origin" ReadOnly="True" 
                    VisibleIndex="8">
                </dx:GridViewDataTimeEditColumn>
                <dx:GridViewDataTextColumn FieldName="Destination" ReadOnly="True" 
                    VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Load" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Driver" ReadOnly="True" VisibleIndex="11">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="50">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterBar="Visible" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [Harbor Plan Detail]"></asp:SqlDataSource>
    
    </div>
    <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" 
        FileName="harbor detail" GridViewID="ASPxGridView1">
    </dx:ASPxGridViewExporter>
    </form>
</body>
</html>
