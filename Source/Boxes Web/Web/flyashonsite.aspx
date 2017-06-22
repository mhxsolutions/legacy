<%@ Page Language="VB" AutoEventWireup="false" CodeFile="flyashonsite.aspx.vb" Inherits="flyashonsite" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rail Inventory</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <strong>Rail Inventory On-Site<br />
        </strong>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2003Blue">
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="Unload_Status" ShowInColumn="Loads Remaining" 
                    SummaryType="Sum" />
            </TotalSummary>
            <Columns>
                <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True"/>
                <dx:GridViewDataTextColumn Caption="Car Number" FieldName="Car_Number" 
                    SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Product" FieldName="Product_Type" 
                    VisibleIndex="2">
                    <Settings AllowHeaderFilter="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Loads Remaining" FieldName="Unload_Status" 
                    VisibleIndex="3">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" 
                ShowGroupPanel="True" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" 
            SelectCommand="SELECT [Car Number] AS Car_Number, [Product Type] AS Product_Type, [Unload Status] AS Unload_Status FROM [fly ash on site inventory]">
        </asp:SqlDataSource>
    
    </div>
    </form>
    <p>
        Rails cars are placed on-site by DWS Rail Log</p>
</body>
</html>
