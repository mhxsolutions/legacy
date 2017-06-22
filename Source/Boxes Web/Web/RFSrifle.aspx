<%@ Page Language="VB" AutoEventWireup="false" CodeFile="RFSrifle.aspx.vb" Inherits="RFSrifle" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rifle Invoices Errors</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            RFS Rifle Audit</h3>
        <br />
        Invoices with Loads but no Manual Charges<br />
    
    </div>
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
        AutoGenerateColumns="False" BackColor="White" BorderColor="White" 
        BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" CellSpacing="1" 
        DataSourceID="SqlDataSource1" EnableModelValidation="True" GridLines="None">
        <Columns>
            <asp:BoundField DataField="Invoice" HeaderText="Invoice" 
                SortExpression="Invoice" />
            <asp:BoundField DataField="Status" HeaderText="Status" 
                SortExpression="Status" />
            <asp:BoundField DataField="Invoice_Date" DataFormatString="{0:d}" 
                HeaderText="Invoice_Date" SortExpression="Invoice_Date" />
            <asp:BoundField DataField="count_of_loads" HeaderText="Load Ct" 
                SortExpression="count_of_loads" />
        </Columns>
        <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />
        <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
        <RowStyle BackColor="#DEDFDE" ForeColor="Black" />
        <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
        
        SelectCommand="SELECT [Invoice], [Invoice Date] AS Invoice_Date, [count of loads] AS count_of_loads, [Status] FROM [RFS Rifle Manual Audit] ORDER BY [Invoice Date] DESC">
    </asp:SqlDataSource>
    </form>
</body>
</html>
