<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Fontana Composite Dwell</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Fontana Composite Dwell</h3>
	<p>average by month</p>
	<asp:GridView runat="server" id="GridView1" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" ForeColor="#333333" CellPadding="4" GridLines="None" AllowSorting="True">
		<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<Columns>
			<asp:boundfield DataField="Month" SortExpression="Month" HeaderText="Month">
			</asp:boundfield>
			<asp:boundfield DataField="Composite Dwell" SortExpression="Composite Dwell" HeaderText="Composite Dwell">
			</asp:boundfield>
		</Columns>
		<RowStyle BackColor="#EFF3FB" />
		<EditRowStyle BackColor="#2461BF" />
		<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Fontana Dwell Composite] ORDER BY [Month] DESC">
	</asp:SqlDataSource>
</form>
<p>filter = today -1, 30 day look back</p>

</body>

</html>
