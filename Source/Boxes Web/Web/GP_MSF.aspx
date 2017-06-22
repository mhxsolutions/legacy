<%@ Page Language="VB" AutoEventWireup="false" CodeFile="GP_MSF.aspx.vb" Inherits="GP_MSF" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>GP MSF</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Georgia-Pacific MSF by Month</h3>
        <br />
        <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
            AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" 
            ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="Yr" HeaderText="Yr" SortExpression="Yr" />
                <asp:BoundField DataField="Mo" HeaderText="Mo" SortExpression="Mo" />
                <asp:BoundField DataField="Client" HeaderText="Client" 
                    SortExpression="Client" />
                <asp:BoundField DataField="MSF In" DataFormatString="{0:n1}" 
                    HeaderText="MSF In" SortExpression="MSF In">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="MSF Out" DataFormatString="{0:n1}" 
                    HeaderText="MSF Out" SortExpression="MSF Out">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT Yr, Mo, Client, [MSF In], [MSF Out] FROM [GP Special Invoice Value Monthly In n Out] ORDER BY Yr DESC, Mo DESC">
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
