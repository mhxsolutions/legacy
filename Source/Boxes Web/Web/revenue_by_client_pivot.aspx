<%@ Page Language="VB" AutoEventWireup="false" CodeFile="revenue_by_client_pivot.aspx.vb" Inherits="revenue_by_client_pivot" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxPivotGrid.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPivotGrid" tagprefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Revenue Pivot</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
    
        Revenue By Client</h3>
        <p>
            <a href="revenue_by_client.aspx">straight table</a></p>
        <br />
        <br />
        <dx:ASPxPivotGrid ID="ASPxPivotGrid3" runat="server" ClientIDMode="AutoID" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2003Blue">
            <Fields>
                <dx:PivotGridField ID="fieldYear0" Area="ColumnArea" AreaIndex="0" 
                    FieldName="Year">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldMonth0" Area="ColumnArea" AreaIndex="1" 
                    FieldName="Month">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldFleet0" AreaIndex="0" FieldName="Fleet">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldClient0" Area="RowArea" AreaIndex="0" 
                    FieldName="Client">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldGLCodeAbr0" Area="RowArea" AreaIndex="1" 
                    Caption="GL" FieldName="GL Code Abr">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldTotal0" Area="DataArea" AreaIndex="0" 
                    CellFormat-FormatString="c0" CellFormat-FormatType="Numeric" FieldName="Total">
                </dx:PivotGridField>
            </Fields>
            <OptionsPager RowsPerPage="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </OptionsPager>
        </dx:ASPxPivotGrid>
        <br />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        SelectCommand="SELECT * FROM [RFS Invoiced totals by client] ORDER BY [Year] DESC, [Month] DESC, [Total] DESC">
    </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
