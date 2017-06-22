<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Payload Capacity</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Payload Capacity</h3>
	<p>Payload- cargo capacity of fully equipped trailer.</p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Driver" HeaderText="Driver" ReadOnly="True" SortExpression="Driver">
			</asp:boundfield>
			<asp:boundfield DataField="Tractor" HeaderText="Tractor" SortExpression="Tractor">
			</asp:boundfield>
			<asp:boundfield DataField="Trailer" HeaderText="Trailer" SortExpression="Trailer">
			</asp:boundfield>
			<asp:boundfield DataField="Payload" DataFormatString="{0:n0}" HeaderText="Payload" HtmlEncode="False" ReadOnly="True" SortExpression="Payload">
			</asp:boundfield>
		</Columns>
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Driver], [Tractor], [Trailer], [Payload] FROM [Driver Current Unit Payload Cap] ORDER BY [Driver]">
	</asp:SqlDataSource>
</form>

</body>

</html>
