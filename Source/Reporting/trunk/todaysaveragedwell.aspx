<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Today</title>
<meta http-equiv="refresh" content="60" />
</head>

<body>

<form id="form1" runat="server">
	<h2>Today's Average Dwell</h2>
	<asp:GridView runat="server" id="GridView1" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" DataKeyNames="Client Name" AllowSorting="True" ForeColor="#333333" CellPadding="4" GridLines="None">
		<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<Columns>
			<asp:boundfield ReadOnly="True" DataField="Client Name" SortExpression="Client Name" HeaderText="Client Name">
			</asp:boundfield>
			<asp:boundfield DataField="Avg Wait" SortExpression="Avg Wait" HeaderText="Avg Wait">
			</asp:boundfield>
		</Columns>
		<RowStyle BackColor="#EFF3FB" Font-Size="Large" />
		<EditRowStyle BackColor="#2461BF" />
		<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" Font-Size="X-Large" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [TodaysAverageDwell] ORDER BY [Avg Wait] DESC">
	</asp:SqlDataSource>
</form>

<p>no time filter</p>

</body>

</html>
