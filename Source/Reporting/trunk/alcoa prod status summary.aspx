<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Material</title>
<meta content="none" name="Microsoft Theme">
<meta content="none, default" name="Microsoft Border">
</head>

<body>

<form id="form1" runat="server">
	<h4>Alcoa Product Status Sumary<br>
	</h4>
	<asp:GridView runat="server" id="GridView1" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" ForeColor="#333333" CellPadding="4" GridLines="None" AllowSorting="True">
		<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<Columns>
			<asp:boundfield DataField="Material" SortExpression="Material" HeaderText="Material">
			</asp:boundfield>
			<asp:boundfield DataField="Available" SortExpression="Available" HeaderText="Available">
			</asp:boundfield>
			<asp:boundfield DataField="Shipping" SortExpression="Shipping" HeaderText="Shipping">
			</asp:boundfield>
		</Columns>
		<RowStyle BackColor="#EFF3FB" />
		<EditRowStyle BackColor="#2461BF" />
		<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Material], [Available], [Shipping] FROM [Alcoa Product Status Summary]">
	</asp:SqlDataSource>
</form>

</body>

</html>
