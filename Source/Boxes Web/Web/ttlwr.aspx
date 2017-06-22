<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ttlwr.aspx.vb" Inherits="ttlwr" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>TTL Well Returns</title>
</head>
<body>
    <h3>
        TTL - Well Returns</h3>
    <form id="form1" runat="server">
    <div>
    
        <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
            AutoGenerateColumns="False" BackColor="White" BorderColor="#E7E7FF" 
            BorderStyle="None" BorderWidth="1px" CellPadding="3" 
            DataKeyNames="Fleet ID,Client Name" DataSourceID="SqlDataSource1" 
            GridLines="Horizontal">
            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
            <Columns>
                <asp:BoundField DataField="Client Name" HeaderText="Client Name" 
                    ReadOnly="True" SortExpression="Client Name" />
                <asp:BoundField DataField="Code" HeaderText="Code" SortExpression="Code" />
                <asp:BoundField DataField="Mill" HeaderText="Mill" SortExpression="Mill" />
                <asp:BoundField DataField="Inspection" HeaderText="Inspection" 
                    SortExpression="Inspection" />
                <asp:BoundField DataField="Wt" DataFormatString="{0:n0}" HeaderText="Wt" 
                    SortExpression="Wt">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="LnFt" DataFormatString="{0:n1}" HeaderText="LnFt" 
                    SortExpression="LnFt">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="Location" HeaderText="Location" 
                    SortExpression="Location">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Count" HeaderText="Count" SortExpression="Count">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
            </Columns>
            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
            <AlternatingRowStyle BackColor="#F7F7F7" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            SelectCommand="SELECT * FROM [TTL well return inventory] ORDER BY [Client Name], [Code]">
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
