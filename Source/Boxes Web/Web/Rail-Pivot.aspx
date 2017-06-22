<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Rail-Pivot.aspx.vb" Inherits="Rail_Pivot" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rail Client Pivot</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Rail Client Pivot Table<br />
        </h3>
        <dx:ASPxPivotGrid ID="ASPxPivotGrid1" runat="server" ClientIDMode="AutoID" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Aqua">
            <Fields>
                <dx:PivotGridField ID="fieldTerminal" AreaIndex="0" FieldName="Terminal">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldDateReleased" AreaIndex="1" 
                    FieldName="Date Released">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldClient" Area="RowArea" AreaIndex="1" 
                    FieldName="Client">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldProductType" Area="ColumnArea" AreaIndex="2" 
                    FieldName="Product Type">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldCarNumber" Area="DataArea" AreaIndex="0" 
                    Caption="Count" FieldName="Car Number" SummaryType="Count" 
                    ValueFormat-FormatString="n0" ValueFormat-FormatType="Numeric">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldCarrier" Area="RowArea" AreaIndex="0" 
                    FieldName="Carrier">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldYear" Area="ColumnArea" AreaIndex="0" 
                    FieldName="Year">
                </dx:PivotGridField>
                <dx:PivotGridField ID="fieldMonth" Area="ColumnArea" AreaIndex="1" 
                    FieldName="Month">
                </dx:PivotGridField>
            </Fields>
            <OptionsPager RowsPerPage="30">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </OptionsPager>
        </dx:ASPxPivotGrid>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" 
            SelectCommand="SELECT * FROM [Railcars by Client Date and Product]">
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
