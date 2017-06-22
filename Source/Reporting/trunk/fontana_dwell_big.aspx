<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Fontana Dwell</title>
<meta http-equiv="refresh" content="120" />
</head>

<body>

<form id="form1" runat="server">
	<h2>Fontana Dwell</h2>
	<asp:GridView runat="server" id="GridView1" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" ForeColor="#333333" CellPadding="4" GridLines="None" AllowSorting="True" Font-Size="X-Large">
		<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<Columns>
			<asp:boundfield DataField="Date" SortExpression="Date" HeaderText="Date">
			</asp:boundfield>
			<asp:boundfield DataField="Pit_Dwell" SortExpression="Pit_Dwell" HeaderText="Pit_Dwell">
			</asp:boundfield>
			<asp:boundfield DataField="Track_5_Dwell" SortExpression="Track_5_Dwell" HeaderText="Track_5_Dwell">
			</asp:boundfield>
			<asp:boundfield DataField="Yard_Dwell" SortExpression="Yard_Dwell" HeaderText="Yard_Dwell">
			</asp:boundfield>
		</Columns>
		<RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
		<EditRowStyle BackColor="#2461BF" />
		<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Date], [Pit Dwell] AS Pit_Dwell, [Track 5 Dwell] AS Track_5_Dwell, [Yard Dwell] AS Yard_Dwell FROM [Fontana Dwell] ORDER BY [sort] DESC">
	</asp:SqlDataSource>
</form>

</body>

</html>
