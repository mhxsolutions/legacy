<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Product Shipments.aspx.vb" Inherits="Product_Shipments" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Product Shipments</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Product Shipments<br />
        </h3>
    
    </div>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2003Olive">
        <GroupSummary>
            <dx:ASPxSummaryItem FieldName="Ct" SummaryType="Sum" />
        </GroupSummary>
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Client" SortIndex="2" 
                SortOrder="Ascending" VisibleIndex="3">
                <Settings AllowHeaderFilter="True" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Fleet" SortIndex="1" 
                SortOrder="Ascending" VisibleIndex="2">
                <Settings AllowHeaderFilter="True" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="Shipment Date" GroupIndex="0" 
                SortIndex="0" SortOrder="Descending" VisibleIndex="1">
                <Settings GroupInterval="DateMonth" />
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Product" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Count" FieldName="Ct" SortIndex="3" 
                SortOrder="Descending" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <SettingsPager PageSize="30">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" />
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        SelectCommand="SELECT * FROM [Product Shipments - daily count]">
    </asp:SqlDataSource>
    </form>
</body>
</html>
