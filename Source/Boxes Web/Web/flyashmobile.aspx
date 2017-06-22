<%@ Page Language="VB" AutoEventWireup="false" CodeFile="flyashmobile.aspx.vb" Inherits="flyashmobile" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=320" />
    <title>Fly Ash Tons</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Fly Ash Tons</h3>
    
    </div>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" 
        GridLines="None">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="Yr" HeaderText="Yr" SortExpression="Yr" />
            <asp:BoundField DataField="Mo" HeaderText="Mo" SortExpression="Mo" />
            <asp:BoundField DataField="Product" HeaderText="Product" 
                SortExpression="Product" />
            <asp:BoundField DataField="Ct" HeaderText="Ct" SortExpression="Ct" />
            <asp:BoundField DataField="Tons" HeaderText="Tons" SortExpression="Tons" 
                DataFormatString="{0:n1}" >
            <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Average" DataFormatString="{0:n1}" 
                HeaderText="Average" SortExpression="Average" />
        </Columns>
        <EditRowStyle BackColor="#2461BF" />
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#F5F7FB" />
        <SortedAscendingHeaderStyle BackColor="#6D95E1" />
        <SortedDescendingCellStyle BackColor="#E9EBEF" />
        <SortedDescendingHeaderStyle BackColor="#4870BE" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        SelectCommand="SELECT * FROM [fly ash weight summary tons for phone] ORDER BY [Yr] DESC, [Mo] DESC, [Product]">
    </asp:SqlDataSource>
    <br />
    <br />
    <dx:ASPxPivotGrid ID="ASPxPivotGrid1" runat="server" ClientIDMode="AutoID" 
        DataSourceID="SqlDataSource2" EnableTheming="True" Theme="Metropolis">
        <Fields>
            <dx:PivotGridField ID="fieldCustomer" AreaIndex="0" FieldName="Customer">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldProduct" Area="ColumnArea" AreaIndex="0" 
                FieldName="Product">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldCt" Area="DataArea" AreaIndex="0" FieldName="Ct">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldTons" Area="DataArea" AreaIndex="1" 
                CellFormat-FormatString="n0" CellFormat-FormatType="Numeric" FieldName="Tons">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldyear" Area="RowArea" AreaIndex="0" FieldName="year" 
                SortOrder="Descending">
            </dx:PivotGridField>
            <dx:PivotGridField ID="fieldmonth" Area="RowArea" AreaIndex="1" 
                FieldName="month" SortOrder="Descending">
            </dx:PivotGridField>
        </Fields>
<StylesPrint Cell-BackColor2="" Cell-GradientMode="Horizontal" FieldHeader-BackColor2="" FieldHeader-GradientMode="Horizontal" TotalCell-BackColor2="" TotalCell-GradientMode="Horizontal" GrandTotalCell-BackColor2="" GrandTotalCell-GradientMode="Horizontal" CustomTotalCell-BackColor2="" CustomTotalCell-GradientMode="Horizontal" FieldValue-BackColor2="" FieldValue-GradientMode="Horizontal" FieldValueTotal-BackColor2="" FieldValueTotal-GradientMode="Horizontal" FieldValueGrandTotal-BackColor2="" FieldValueGrandTotal-GradientMode="Horizontal" Lines-BackColor2="" Lines-GradientMode="Horizontal"></StylesPrint>
    </dx:ASPxPivotGrid>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        SelectCommand="SELECT [Customer], [Product], [Ct], [Tons], [year], [month] FROM [fly ash weight summary tonne]">
    </asp:SqlDataSource>
    </form>
</body>
</html>
