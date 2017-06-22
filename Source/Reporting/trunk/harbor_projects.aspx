<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Harbor Projects</title>
<base target="main" />
</head>

<body>

<form id="form1" runat="server">
	<h3>Harbor Projects</h3>
	<asp:GridView runat="server" id="GridView1" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" ForeColor="#333333" CellPadding="4" GridLines="None" AllowSorting="True">
		<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<Columns>
			<asp:boundfield DataField="Year" SortExpression="Year" HeaderText="Year">
			</asp:boundfield>
			<asp:boundfield DataField="Month" SortExpression="Month" HeaderText="Month">
			</asp:boundfield>
			<asp:boundfield DataField="Ct w/out Invoices" SortExpression="Ct w/out Invoices" HeaderText="Ct w/out Invoices">
			</asp:boundfield>
		</Columns>
		<RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" Font-Size="Medium" />
		<EditRowStyle BackColor="#2461BF" />
		<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Size="Larger" Font-Bold="True" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [wProject Manager unbilled] ORDER BY [Year] DESC, [Month] DESC">
	</asp:SqlDataSource>
</form>
<p><a target="_self" href="project_invoicing.aspx">Detail</a></p>

<p>&nbsp;</p>

</body>

</html>
