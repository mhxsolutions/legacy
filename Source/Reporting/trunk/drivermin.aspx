<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Driver Minutes no Subhaul</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Driver Booked Minutes no Subhaul</h3>
	<p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Year" HeaderText="Year" SortExpression="Year">
			</asp:boundfield>
			<asp:boundfield DataField="Month" HeaderText="Month" SortExpression="Month">
			</asp:boundfield>
			<asp:boundfield DataField="Booked Minutes" HeaderText="Booked Minutes" SortExpression="Booked Minutes">
			</asp:boundfield>
			<asp:boundfield DataField="Trip Minutes" HeaderText="Trip Minutes" SortExpression="Trip Minutes">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Driver minutes booked and trip no subhaul] ORDER BY [Year] DESC, [Month] DESC">
	</asp:SqlDataSource>
	</p>
	<hr />
	<h3>Subhaul Booked Minutes no Drivers</h3>
	<p>
	<asp:GridView id="GridView2" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Year" HeaderText="Year" SortExpression="Year">
			</asp:boundfield>
			<asp:boundfield DataField="Month" HeaderText="Month" SortExpression="Month">
			</asp:boundfield>
			<asp:boundfield DataField="Booked Minutes" HeaderText="Booked Minutes" SortExpression="Booked Minutes">
			</asp:boundfield>
			<asp:boundfield DataField="Trip Minutes" HeaderText="Trip Minutes" SortExpression="Trip Minutes">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Subhaul minutes booked and trip no drivers] ORDER BY [Year] DESC, [Month] DESC">
	</asp:SqlDataSource>
	</p>
</form>

</body>

</html>
