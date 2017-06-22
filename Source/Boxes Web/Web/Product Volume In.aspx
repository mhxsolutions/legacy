<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Product Volume In.aspx.vb" Inherits="Product_Volume_In" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Product Volume In</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Product Volume Received</h3>
    
    </div>
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
        AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" 
        BorderStyle="None" BorderWidth="1px" CellPadding="3" 
        DataSourceID="SqlDataSource1" EnableModelValidation="True">
        <Columns>
            <asp:BoundField DataField="Year" HeaderText="Year" SortExpression="Year" />
            <asp:BoundField DataField="Month" HeaderText="Month" SortExpression="Month" />
            <asp:BoundField DataField="Fleet" HeaderText="Fleet" SortExpression="Fleet" />
            <asp:BoundField DataField="Client" HeaderText="Client" 
                SortExpression="Client" />
            <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type" />
            <asp:BoundField DataField="Profile" HeaderText="Profile" 
                SortExpression="Profile" />
            <asp:BoundField DataField="Count" HeaderText="Count" SortExpression="Count" />
            <asp:BoundField DataField="Tons in" HeaderText="Tons in" 
                SortExpression="Tons in" />
        </Columns>
        <FooterStyle BackColor="White" ForeColor="#000066" />
        <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
        <RowStyle ForeColor="#000066" />
        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
        SelectCommand="SELECT * FROM [Tons received by fleet month client and type] ORDER BY [Year] DESC, [Month] DESC, [Fleet]">
    </asp:SqlDataSource>
    </form>
    <p>
        Does not include account transfers or corrections.</p>
</body>
</html>
