<%@ Page Language="VB" AutoEventWireup="false" CodeFile="InventoryFIFO.aspx.vb" Inherits="InventoryFIFO" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta name="viewport" content="width=320" />
    <title>FIFO</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Inventory FIFO&nbsp; - <a href="default.aspx">home</a></h3>
        <p>
            current inventory</p>
        Select Client:<asp:DropDownList ID="DropDownList1" runat="server" 
            AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="Client_Name" 
            DataValueField="Client_Name">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            SelectCommand="SELECT DISTINCT [Client Name] AS Client_Name FROM [TTL FIFO] ORDER BY [Client Name]">
        </asp:SqlDataSource>
        <br />
        <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
            AutoGenerateColumns="False" BackColor="White" BorderColor="#E7E7FF" 
            BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="Client Name" 
            DataSourceID="SqlDataSource2" GridLines="Horizontal">
            <AlternatingRowStyle BackColor="#F7F7F7" />
            <Columns>
                <asp:BoundField DataField="Product Group 1" HeaderText="Group 1" 
                    SortExpression="Product Group 1" />
                <asp:BoundField DataField="First Date" DataFormatString="{0:d}" 
                    HeaderText="First Date" SortExpression="First Date" />
                <asp:BoundField DataField="Product Group 2" HeaderText="Group 2" 
                    SortExpression="Product Group 2" />
                <asp:BoundField DataField="Product Group 3" HeaderText="Group 3" 
                    SortExpression="Product Group 3" />
                <asp:BoundField DataField="Extended Description" 
                    HeaderText="Extended Description" SortExpression="Extended Description" />
                <asp:BoundField DataField="LnFt" DataFormatString="{0:n1}" HeaderText="LnFt" 
                    SortExpression="LnFt" />
                <asp:BoundField DataField="Ct" HeaderText="Ct" SortExpression="Ct" />
                <asp:BoundField DataField="Tons" DataFormatString="{0:n1}" HeaderText="Tons" 
                    SortExpression="Tons">
                <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
            </Columns>
            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
            <SortedAscendingCellStyle BackColor="#F4F4FD" />
            <SortedAscendingHeaderStyle BackColor="#5A4C9D" />
            <SortedDescendingCellStyle BackColor="#D8D8F0" />
            <SortedDescendingHeaderStyle BackColor="#3E3277" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            SelectCommand="SELECT * FROM [TTL FIFO] WHERE ([Client Name] = @Client_Name) ORDER BY [Product Group 1], [First Date]">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="Client_Name" 
                    PropertyName="SelectedValue" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
    <p>
        total in inventory with all BOLs removed even if they have not shipped</p>
</body>
</html>
