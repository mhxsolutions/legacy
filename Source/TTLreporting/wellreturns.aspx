<%@ Page Language="VB" AutoEventWireup="false" CodeFile="wellreturns.aspx.vb" Inherits="wellreturns" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta name="viewport" content="width=320" />
    <title>Well Returns</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Well Returns - <a href="default.aspx">home</a></h3>
        <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
            AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" 
            BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="Client_Name" 
            DataSourceID="SqlDataSource1" GridLines="Vertical">
            <AlternatingRowStyle BackColor="#DCDCDC" />
            <Columns>
                <asp:BoundField DataField="Client_Name" HeaderText="Client_Name" 
                    ReadOnly="True" SortExpression="Client_Name" />
                <asp:BoundField DataField="Code" HeaderText="Code" SortExpression="Code" />
                <asp:BoundField DataField="Mill" HeaderText="Mill" SortExpression="Mill" />
                <asp:BoundField DataField="Inspection" HeaderText="Inspection" 
                    SortExpression="Inspection" />
                <asp:BoundField DataField="Count" HeaderText="Count" SortExpression="Count" />
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
            SelectCommand="SELECT [Client Name] AS Client_Name, [Code], [Mill], [Inspection], [Count] FROM [TTL well return inventory] ORDER BY [Client Name], [Code]">
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
