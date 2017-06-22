<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ETItonsmobile.aspx.vb" Inherits="ETItonsmobile" %>


<%@ Register assembly="DevExpress.Web.ASPxPivotGrid.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPivotGrid" tagprefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=320" />
    <title>ETI Tons (mobile)</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <strong>ETI Tons (mobile)</strong><br />
        <dx:ASPxPivotGrid ID="ASPxPivotGrid1" runat="server" ClientIDMode="AutoID" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2003Silver">
            <Fields>
                <dx:PivotGridField ID="fieldYear" Area="RowArea" AreaIndex="0" FieldName="Year" 
                    SortOrder="Descending">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldMonth" Area="RowArea" AreaIndex="1" 
                    FieldName="Month" SortOrder="Descending">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldTerminal" Area="ColumnArea" AreaIndex="0" 
                    FieldName="Terminal">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldTonsIn" Area="DataArea" AreaIndex="0" 
                    CellFormat-FormatString="{0:n1}" CellFormat-FormatType="Numeric" 
                    FieldName="Tons In" GrandTotalCellFormat-FormatString="{0:n1}" 
                    GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="{0:n1}" 
                    TotalCellFormat-FormatType="Numeric" TotalsVisibility="None" 
                    TotalValueFormat-FormatString="{0:n1}" TotalValueFormat-FormatType="Numeric" 
                    ValueFormat-FormatString="{0:n1}" ValueFormat-FormatType="Numeric">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldTonsOut" Area="DataArea" AreaIndex="1" 
                    CellFormat-FormatString="{0:n1}" CellFormat-FormatType="Numeric" 
                    FieldName="Tons Out" GrandTotalCellFormat-FormatString="{0:n1}" 
                    GrandTotalCellFormat-FormatType="Numeric" TotalCellFormat-FormatString="{0:n1}" 
                    TotalCellFormat-FormatType="Numeric" TotalsVisibility="None" 
                    TotalValueFormat-FormatString="{0:n1}" TotalValueFormat-FormatType="Numeric" 
                    ValueFormat-FormatString="{0:n1}" ValueFormat-FormatType="Numeric">
                </dx:PivotGridField>
            </Fields>
            <optionspager rowsperpage="13">
                <allbutton visible="True">
                </allbutton>
                <pagesizeitemsettings showallitem="True" visible="True">
                </pagesizeitemsettings>
            </optionspager>
        </dx:ASPxPivotGrid>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [ETI receiving and shipping tons summary]">
        </asp:SqlDataSource>
    
    </div>
    </form>
    <p>
        No Receivers or BOLs with Type = correction, system transfer, account transfer, 
        or inspection transfer.
    </p>
    <p>
        Received and Shipped tons only.</p>
</body>
</html>
