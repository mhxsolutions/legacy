<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SalesPivot.aspx.vb" Inherits="SalesPivot" %>

<%@ Register assembly="DevExpress.Web.ASPxPivotGrid.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPivotGrid" tagprefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sales History</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>Sales History Pivot Table - <a href="default.aspx">home</a><br />
        </h3>
        <dx:ASPxPivotGrid ID="ASPxPivotGrid1" runat="server" ClientIDMode="AutoID" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
            <Fields>
                <dx:PivotGridField ID="fieldCustName" Area="RowArea" AreaIndex="0" FieldName="Cust_Name">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldInvoiceDate" Area="ColumnArea" AreaIndex="0" FieldName="Invoice_Date" Visible="False">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldFullDescription" AreaIndex="2" Caption="Description" FieldName="Full_Description">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldQuantityShipped" Area="DataArea" AreaIndex="0" Caption="Quantity" CellFormat-FormatString="n0" CellFormat-FormatType="Numeric" FieldName="Quantity_Shipped" TotalCellFormat-FormatString="n0" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="n0" TotalValueFormat-FormatType="Numeric" ValueFormat-FormatString="n0" ValueFormat-FormatType="Numeric">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldGrossSales" Area="DataArea" AreaIndex="2" CellFormat-FormatString="c0" CellFormat-FormatType="Numeric" FieldName="Gross_Sales" TotalCellFormat-FormatString="c0" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="c0" TotalValueFormat-FormatType="Numeric" ValueFormat-FormatString="c0" ValueFormat-FormatType="Numeric">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldExtCost" Area="DataArea" AreaIndex="0" FieldName="Ext_Cost" Visible="False">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldTonnage" Area="DataArea" AreaIndex="1" CellFormat-FormatString="n0" CellFormat-FormatType="Numeric" FieldName="Tonnage" TotalCellFormat-FormatString="n0" TotalCellFormat-FormatType="Numeric" TotalValueFormat-FormatString="n0" TotalValueFormat-FormatType="Numeric" ValueFormat-FormatString="n0" ValueFormat-FormatType="Numeric">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldMill" AreaIndex="0" FieldName="Mill">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldMonthInv" Area="DataArea" FieldName="Month_Inv" Visible="False">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldYearInv" Area="ColumnArea" AreaIndex="0" Caption="Year" FieldName="Year_Inv">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldQuarterInv" Area="ColumnArea" AreaIndex="1" Caption="Quarter" FieldName="Quarter_Inv">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldPart" AreaIndex="1" FieldName="Part#">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldCOGS" Area="DataArea" FieldName="COGS%" ValueFormat-FormatString="p1" Visible="False">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldGP" Area="DataArea" AreaIndex="3" Caption="Avg GP%" CellFormat-FormatString="p1" CellFormat-FormatType="Numeric" FieldName="GP%" SummaryType="Average" TotalCellFormat-FormatString="{0:p1}" TotalCellFormat-FormatType="Custom" TotalValueFormat-FormatString="{0:p1}" TotalValueFormat-FormatType="Custom" ValueFormat-FormatString="{0:p1}" ValueFormat-FormatType="Custom">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldNetGrossProfit" Area="DataArea" FieldName="Net_Gross_Profit" ValueFormat-FormatString="c" Visible="False">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldTotalWithTax" Area="DataArea" FieldName="Total_With_Tax" ValueFormat-FormatString="c" Visible="False">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldDescription11" Area="DataArea" AreaIndex="3" FieldName="Description_1" Visible="False">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldDescription21" Area="DataArea" AreaIndex="3" FieldName="Description_2" Visible="False">
                </dx:PivotGridField>
            </Fields>
            <OptionsPager RowsPerPage="20">
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </OptionsPager>
        </dx:ASPxPivotGrid>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT SalesHistory_ID, Cust#, Cust_Name, Cust_Detail, Invoice#, Invoice_Date, Ship_Date, Month_Inv, Year_Inv, Quarter_Inv, Well_Name, AFE#, Part#, Description_1, Description_2, Full_Description, Quantity_Shipped, List_Price, Gross_Sales, Warehouse, Joints_Shipped, Net_Sales, Ext_Weight, Tax_Amt, Unit_Cost, Ext_Cost, Total_Gross_Profit, [COGS%], [GP%], UOM, Sales_Code, [Tax%], Discount, Net_Gross_Profit, Weight_per_Ft, Tonnage, Mill, Total_With_Tax FROM SalesHistoryETI WHERE (Quantity_Shipped &gt; 0)"></asp:SqlDataSource>
    
    </div>
    </form>
    <p>
        Right click in grid header for hidden fields.</p>
</body>
</html>
