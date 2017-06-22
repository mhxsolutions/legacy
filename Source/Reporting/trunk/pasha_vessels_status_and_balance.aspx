<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>PASHA Vessels Status and Balance</title>
</head>

<body>

<form id="form1" runat="server">
	<p>PASHA Vessels Status and Balance</p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
		<RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
		<Columns>
			<asp:boundfield DataField="Vessel" HeaderText="Vessel" SortExpression="Vessel">
			</asp:boundfield>
			<asp:boundfield DataField="Berth" HeaderText="Berth" SortExpression="Berth">
			</asp:boundfield>
			<asp:boundfield DataField="Status" HeaderText="Status" SortExpression="Status">
			</asp:boundfield>
			<asp:boundfield DataField="Client Number" HeaderText="Client Number" SortExpression="Client Number">
			</asp:boundfield>
			<asp:boundfield DataField="Delivery Order" HeaderText="Delivery Order" SortExpression="Delivery Order">
			</asp:boundfield>
			<asp:boundfield DataField="Product Type" HeaderText="Product Type" SortExpression="Product Type">
			</asp:boundfield>
			<asp:boundfield DataField="Tendered" HeaderText="Tendered" SortExpression="Tendered">
			</asp:boundfield>
			<asp:boundfield DataField="Delivered" HeaderText="Delivered" SortExpression="Delivered">
			</asp:boundfield>
			<asp:boundfield DataField="Balance" HeaderText="Balance" ReadOnly="True" SortExpression="Balance">
			</asp:boundfield>
		</Columns>
		<PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
		<HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Project Totals for PASHA by BL with balance] ORDER BY [Vessel], [Client Number], [Delivery Order]">
	</asp:SqlDataSource>
</form>

</body>

</html>
