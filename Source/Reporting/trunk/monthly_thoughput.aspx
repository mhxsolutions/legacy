<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Monthly Thoughput</title>
<base target="main" />
</head>

<body>

<form id="form1" runat="server">
	<h3>Monthly Throughput</h3>
	<asp:GridView runat="server" id="GridView1" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" AllowSorting="True" ForeColor="#333333" CellPadding="4" GridLines="None">
		<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<Columns>
			<asp:boundfield DataField="Year" SortExpression="Year" HeaderText="Year">
			</asp:boundfield>
			<asp:boundfield DataField="Month" SortExpression="Month" HeaderText="Month">
			</asp:boundfield>
			<asp:boundfield HtmlEncode="False" DataFormatString="{0:c}" ReadOnly="True" DataField="column1" SortExpression="column1" HeaderText="T/Act Min">
			</asp:boundfield>
		</Columns>
		<RowStyle BackColor="#EFF3FB" />
		<EditRowStyle BackColor="#2461BF" />
		<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Year], [Month], [Rev/Act Min] AS column1 FROM [Throughput total rev over act min] ORDER BY [Year] DESC, [Month] DESC">
	</asp:SqlDataSource>
</form>

<p>Total Rev / Total Act Min</p>

<p>EOD ltd. Includes weekends</p>

</body>

</html>
