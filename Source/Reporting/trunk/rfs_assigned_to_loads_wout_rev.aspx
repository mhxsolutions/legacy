<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>RFS assigned to loads without Lo</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>RFS assigned to loads without Load Revenue</h3>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Client Name" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Client Name" HeaderText="Client Name" ReadOnly="True" SortExpression="Client Name">
			</asp:boundfield>
			<asp:boundfield DataField="RFS" HeaderText="RFS" SortExpression="RFS">
			</asp:boundfield>
			<asp:boundfield DataField="Load Ct" HeaderText="Load Ct" SortExpression="Load Ct">
				<ItemStyle HorizontalAlign="Right" />
			</asp:boundfield>
		</Columns>
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [RFS loads with RFS no rev summary] ORDER BY [Client Name]">
	</asp:SqlDataSource>
</form>

</body>

</html>
