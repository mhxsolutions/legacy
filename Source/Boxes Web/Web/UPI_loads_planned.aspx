<%@ Page Language="VB" AutoEventWireup="false" CodeFile="UPI_loads_planned.aspx.vb" Inherits="UPI_loads_planned" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>UPI Planned Loads</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            UPI Planned Loads<br />
            <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export to Excel" 
                Theme="MetropolisBlue">
            </dx:ASPxButton>
        </h3>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="MetropolisBlue">
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataDateColumn FieldName="Plan Date" SortIndex="1" 
                    SortOrder="Descending" VisibleIndex="2">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Count" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Shipper" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Destination" SortIndex="3" 
                    SortOrder="Ascending" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Customer" SortIndex="2" 
                    SortOrder="Ascending" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Fleet" SortIndex="0" 
                    SortOrder="Ascending" VisibleIndex="1">
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
            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterBar="Visible" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [Planned UPI Loads 7 day look back summary count]">
        </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="ASPxGridView" runat="server" 
            FileName="UPI planned" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    
    </div>
    </form>
    <p>
        UPI loads on planner for past 7 days foreward. Does not limit for D/H vs. 
        Delivery.</p>
</body>
</html>
