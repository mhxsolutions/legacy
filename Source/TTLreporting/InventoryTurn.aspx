<%@ Page Language="VB" AutoEventWireup="false" CodeFile="InventoryTurn.aspx.vb" Inherits="InventoryTurn" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta name="viewport" content="width=320" />
    <title>Inventory Turn</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Inventory Turnover&nbsp; - <a href="default.aspx">home</a></h3>
        <br />
        <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
            AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" 
            BorderStyle="None" BorderWidth="1px" CellPadding="3" 
            DataSourceID="SqlDataSource1" GridLines="Vertical">
            <AlternatingRowStyle BackColor="#DCDCDC" />
            <Columns>
                <asp:BoundField DataField="Client" HeaderText="Client" 
                    SortExpression="Client" />
                <asp:BoundField DataField="Code" HeaderText="Code" SortExpression="Code" />
                <asp:BoundField DataField="Profile" HeaderText="Profile" 
                    SortExpression="Profile" />
                <asp:BoundField DataField="Ext Description" HeaderText="Ext Description" 
                    SortExpression="Ext Description" />
                <asp:BoundField DataField="Total Inventory" HeaderText="Total Inventory" 
                    SortExpression="Total Inventory">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="Inventory Shipped" HeaderText="Inventory Shipped" 
                    SortExpression="Inventory Shipped">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="Shipped Last 45 Days" 
                    HeaderText="Shipped Last 45 Days" SortExpression="Shipped Last 45 Days">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
            </Columns>
            <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
            <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
            <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
            <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#0000A9" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#000065" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            SelectCommand="SELECT * FROM [TTL Inventory Velocity] ORDER BY [Client], [Profile], [Code]">
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
