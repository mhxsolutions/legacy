<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SubhaulList.aspx.vb" Inherits="SubhaulList" %>

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
    
        Subhaul Loads</h3>
        <br />
    
    </div>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" KeyFieldName="Load">
        <Columns>
            <dx:GridViewCommandColumn ShowInCustomizationForm="True" VisibleIndex="0" ShowEditButton="True" ShowClearFilterButton="True"/>
            <dx:GridViewDataTextColumn FieldName="Load" ReadOnly="True" 
                ShowInCustomizationForm="True" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Driver" ReadOnly="True" 
                ShowInCustomizationForm="True" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="LogOutDate" 
                ShowInCustomizationForm="True" VisibleIndex="3">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataCheckColumn FieldName="POD" ReadOnly="True" 
                ShowInCustomizationForm="True" VisibleIndex="4">
            </dx:GridViewDataCheckColumn>
            <dx:GridViewDataTextColumn FieldName="LoadNotes" ReadOnly="True" 
                ShowInCustomizationForm="True" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Destination" ReadOnly="True" 
                ShowInCustomizationForm="True" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Invoice" ShowInCustomizationForm="True" 
                VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Rate" ShowInCustomizationForm="True" 
                VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Fleet" GroupIndex="0" SortIndex="0" 
                SortOrder="Ascending" VisibleIndex="9">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Year" GroupIndex="1" SortIndex="1" 
                SortOrder="Ascending" VisibleIndex="11">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Month" GroupIndex="2" SortIndex="2" 
                SortOrder="Ascending" VisibleIndex="13">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsPager PageSize="100">
        </SettingsPager>
        <Settings EnableFilterControlPopupMenuScrolling="True" ShowFilterRow="True" />
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
        SelectCommand="SELECT * FROM [Subhaul Loads with invoice and rate] ORDER BY [Load] DESC">
    </asp:SqlDataSource>
    </form>
</body>
</html>
