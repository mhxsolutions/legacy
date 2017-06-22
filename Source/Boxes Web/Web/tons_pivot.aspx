<%@ Page Language="VB" AutoEventWireup="false" CodeFile="tons_pivot.aspx.vb" Inherits="tons_pivot" %>

<%@ Register assembly="DevExpress.Web.ASPxPivotGrid.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPivotGrid" tagprefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tons Handled by Month</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Tons Handled by Month - pivot report<br />
        </h3>
        <dx:ASPxPivotGrid ID="ASPxPivotGrid1" runat="server" ClientIDMode="AutoID" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Default">
            <Fields>
                <dx:PivotGridField ID="fieldFleet" Area="ColumnArea" AreaIndex="0" 
                    FieldName="Fleet">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldYear" Area="RowArea" AreaIndex="0" FieldName="Year" 
                    SortOrder="Descending">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldMonth" Area="RowArea" AreaIndex="1" 
                    FieldName="Month" SortOrder="Descending">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldTonsin" Area="DataArea" AreaIndex="0" 
                    CellFormat-FormatString="n1" CellFormat-FormatType="Numeric" 
                    FieldName="Tons in">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldTonsOut" Area="DataArea" AreaIndex="1" 
                    CellFormat-FormatString="n1" CellFormat-FormatType="Numeric" 
                    FieldName="Tons Out">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldTruckTons" Area="DataArea" AreaIndex="2" 
                    CellFormat-FormatString="n1" CellFormat-FormatType="Numeric" 
                    FieldName="Truck Tons">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldTruckCt" Area="DataArea" AreaIndex="3" 
                    CellFormat-FormatString="n0" CellFormat-FormatType="Numeric" 
                    FieldName="Truck Ct">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldSubhaulTons" Area="DataArea" AreaIndex="4" 
                    CellFormat-FormatString="n1" CellFormat-FormatType="Numeric" 
                    FieldName="Subhaul Tons">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldSubhaulCt" Area="DataArea" AreaIndex="5" 
                    CellFormat-FormatString="n0" CellFormat-FormatType="Numeric" 
                    FieldName="Subhaul Ct">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldWCTons" Area="DataArea" AreaIndex="6" 
                    CellFormat-FormatString="n1" CellFormat-FormatType="Numeric" 
                    FieldName="WC Tons">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldWCCt" Area="DataArea" AreaIndex="7" 
                    CellFormat-FormatString="n0" CellFormat-FormatType="Numeric" FieldName="WC Ct">
                </dx:PivotGridField>
            </Fields>
            <OptionsPager RowsPerPage="13">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </OptionsPager>
        </dx:ASPxPivotGrid>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [Tons Handled by Fleet and Month]">
        </asp:SqlDataSource>
    
    </div>
    </form>
    <p>
        Receiving from DWS Receivers. No UPI.</p>
    <p>
        Shipping from Loads Shipped. 
        Rail in Tons Out. No Thoro. No transfers or corrections. UPI included.</p>
</body>
</html>
