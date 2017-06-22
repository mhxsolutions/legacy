<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Rifle Invoices.aspx.vb" Inherits="Rifle_Invoices" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rifle Invoice Details</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            TTL Invoices</h3>
        <br />
        <dx:ASPxButton ID="ASPxButton1" runat="server" Text="XLSX" Theme="Office2003Blue">
        </dx:ASPxButton>
    
        <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Expand All" Theme="Office2003Blue">
        </dx:ASPxButton>
        <dx:ASPxButton ID="ASPxButton3" runat="server" Text="Collapse All" Theme="Office2003Blue">
        </dx:ASPxButton>
    
    </div>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" Theme="Office2003Blue">
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
        <SettingsPopup>
            <HeaderFilter MinHeight="300px" MinWidth="360px" />
        </SettingsPopup>
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Terminal" GroupIndex="0" SortIndex="0" 
                SortOrder="Ascending" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Invoice" ShowInCustomizationForm="True" 
                VisibleIndex="2" GroupIndex="1" SortIndex="1" SortOrder="Ascending">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="Invoice Date" 
                ShowInCustomizationForm="True" VisibleIndex="3" SortIndex="2" SortOrder="Descending">
                <Settings AllowHeaderFilter="True" />
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Bill To" ReadOnly="True" 
                ShowInCustomizationForm="True" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Invoice Total" 
                ShowInCustomizationForm="True" VisibleIndex="5">
                <PropertiesTextEdit DisplayFormatString="c">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Line Number" 
                ShowInCustomizationForm="True" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="Item Date" ShowInCustomizationForm="True" 
                VisibleIndex="7">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Item Description" 
                ShowInCustomizationForm="True" VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Item Total" 
                ShowInCustomizationForm="True" VisibleIndex="9">
                <PropertiesTextEdit DisplayFormatString="c">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <SettingsPager PageSize="100">
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" ShowFilterBar="Visible" ShowFooter="True" ShowGroupedColumns="True" />
        <GroupSummary>
            <dx:ASPxSummaryItem FieldName="Item Total" SummaryType="Sum" />
        </GroupSummary>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
        SelectCommand="SELECT * FROM [RFS Invoice Items for Rifle] ORDER BY [Invoice Date] DESC, [Invoice], [Line Number]">
    </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
        <br />
        </form>
</body>
</html>
