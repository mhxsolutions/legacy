<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Inventory_Totals.aspx.vb" Inherits="Inventory_Totals" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta name="viewport" content="width=320" />
    <title>Inv Totals</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Inventory Totals&nbsp; - <a href="default.aspx">home</a><br />
        </h3>
    
    </div>
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
        AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Client Name" 
        DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="Terminal" HeaderText="Terminal" 
                SortExpression="Terminal" />
            <asp:BoundField DataField="Client Name" HeaderText="Client" 
                ReadOnly="True" SortExpression="Client Name" />
            <asp:BoundField DataField="LNFT" DataFormatString="{0:n1}" HeaderText="LNFT" 
                SortExpression="LNFT" />
            <asp:BoundField DataField="Tons" DataFormatString="{0:n1}" HeaderText="Tons" 
                SortExpression="Tons">
            <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
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
        
        SelectCommand="SELECT * FROM [TTL FIFO count and tons summary by client] ORDER BY [Terminal], [Client Name]">
    </asp:SqlDataSource>
    </form>
</body>
</html>
