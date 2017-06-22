<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SRMGpipeline.aspx.vb" Inherits="SRMGpipeline" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Pipeline</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            SRMG Fly Ash Pipeline Inventory</h3>
        <p>
            <asp:Button ID="Button1" runat="server" Text="Export to Excel" />
        </p>
        <p>
            <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
                DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2003Blue">
                <Columns>
                    <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True"/>
                    <dx:GridViewDataTextColumn FieldName="Status" VisibleIndex="1">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Status Flag" SortIndex="0" 
                        SortOrder="Descending" Visible="False" VisibleIndex="2">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Product Type" VisibleIndex="3">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="ETA" SortIndex="1" SortOrder="Ascending" 
                        VisibleIndex="4">
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataTextColumn FieldName="Loads" VisibleIndex="5">
                    </dx:GridViewDataTextColumn>
                </Columns>
                <SettingsPager>
                    <AllButton Visible="True">
                    </AllButton>
                    <PageSizeItemSettings Visible="True">
                    </PageSizeItemSettings>
                </SettingsPager>
                <Settings ShowFilterRow="True" ShowGroupPanel="True" />
            </dx:ASPxGridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" 
                SelectCommand="SELECT * FROM [fly ash pipeline inventory summary]">
            </asp:SqlDataSource>
            <dx:ASPxGridViewExporter ID="Exporter1" runat="server" 
                GridViewID="ASPxGridView1">
            </dx:ASPxGridViewExporter>
        </p>
    
    </div>
    </form>
</body>
</html>
