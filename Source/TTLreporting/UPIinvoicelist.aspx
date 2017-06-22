<%@ Page Language="VB" AutoEventWireup="false" CodeFile="UPIinvoicelist.aspx.vb" Inherits="UPIinvoicelist" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            UPI Invoice List - <a href="default.aspx">home</a></h3>
        <br />
    
    </div>
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
        AutoGenerateColumns="False" CellPadding="4" DataKeyNames="RFS_Invoice_Id" 
        DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="RFS_Invoice_Id" HeaderText="RFS_Invoice_Id" 
                ReadOnly="True" SortExpression="RFS_Invoice_Id" />
            <asp:BoundField DataField="Invoice_Date" DataFormatString="{0:d}" 
                HeaderText="Invoice_Date" SortExpression="Invoice_Date" />
            <asp:BoundField DataField="Invoice_Total" HeaderText="Invoice_Total" 
                SortExpression="Invoice_Total" />
            <asp:BoundField DataField="Load" HeaderText="Load" SortExpression="Load" />
        </Columns>
        <EditRowStyle BackColor="#2461BF" />
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#EFF3FB" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#F5F7FB" />
        <SortedAscendingHeaderStyle BackColor="#6D95E1" />
        <SortedDescendingCellStyle BackColor="#E9EBEF" />
        <SortedDescendingHeaderStyle BackColor="#4870BE" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
        SelectCommand="SELECT [RFS Invoice Id] AS RFS_Invoice_Id, [Invoice Date] AS Invoice_Date, [Invoice Total] AS Invoice_Total, [Load] FROM [UPI invoice list with detail] ORDER BY [RFS Invoice Id] DESC">
    </asp:SqlDataSource>
    </form>
</body>
</html>
