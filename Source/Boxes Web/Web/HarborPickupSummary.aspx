<%@ Page Language="VB" AutoEventWireup="false" CodeFile="HarborPickupSummary.aspx.vb" Inherits="HarborPickupSummary" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Harbor Pickups</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Harbor Pickup Summary<br />
        </h3>
        <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Export XLSX" Theme="Metropolis">
        </dx:ASPxButton>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsPopup>
                <HeaderFilter MinHeight="350px" MinWidth="350px" />
            </SettingsPopup>
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Detail 1" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons" ReadOnly="True" VisibleIndex="6">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn Caption="Delivery Date" FieldName="LogOutDate" SortIndex="1" SortOrder="Descending" VisibleIndex="2">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="DeliverTo" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Vessel" SortIndex="2" SortOrder="Ascending" VisibleIndex="3">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="POD" VisibleIndex="9">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="ProjectClient" SortIndex="3" SortOrder="Ascending" VisibleIndex="4">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [COPSharborDeliverySummary]"></asp:SqlDataSource>
    
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="harbor Pickup Summary" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    
    </div>
    </form>
</body>
</html>
