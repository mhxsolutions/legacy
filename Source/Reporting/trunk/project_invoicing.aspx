<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Project Invoicing</title>
<base target="main" />
</head>

<body>

<form id="form1" runat="server">
	<h4>Project Invoicing</h4>
	<asp:GridView runat="server" id="GridView1" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" ForeColor="#333333" CellPadding="4" GridLines="None" AllowSorting="True">
		<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<Columns>
			<asp:boundfield ReadOnly="True" DataField="Year" SortExpression="Year" HeaderText="Year">
				<ItemStyle Font-Size="Small" />
				<HeaderStyle Font-Size="Small" />
			</asp:boundfield>
			<asp:boundfield ReadOnly="True" DataField="Month" SortExpression="Month" HeaderText="Month">
				<ItemStyle Font-Size="Small" />
				<HeaderStyle Font-Size="Small" />
			</asp:boundfield>
			<asp:boundfield ReadOnly="True" DataField="Client" SortExpression="Client" HeaderText="Client">
				<ItemStyle Font-Size="Small" />
				<HeaderStyle Font-Size="Small" />
			</asp:boundfield>
			<asp:boundfield DataField="Vessel" SortExpression="Vessel" HeaderText="Vessel">
				<ItemStyle Font-Size="Small" />
				<HeaderStyle Font-Size="Small" />
			</asp:boundfield>
			<asp:boundfield DataField="Load_Ct" SortExpression="Load_Ct" HeaderText="Load_Ct">
				<ItemStyle Font-Size="Small" />
				<HeaderStyle Font-Size="Small" />
			</asp:boundfield>
		</Columns>
		<RowStyle BackColor="#EFF3FB" />
		<EditRowStyle BackColor="#2461BF" />
		<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Client], [Vessel], [Invoice Total] AS Invoice_Total, [Load Ct] AS Load_Ct, [Year], [Month] FROM [Project Manager missing Invoicing] ORDER BY [Year] DESC, [Month] DESC">
	</asp:SqlDataSource>
</form>

</body>

</html>
