<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Load Rev $/Driver/Day</title>
<base target="_blank" />
</head>

<body>

<form id="form1" runat="server">
	<h3>Load Rev $/Driver/Day (EOD ltd.)</h3>
	<asp:GridView runat="server" id="GridView1" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" ForeColor="#333333" CellPadding="4" GridLines="None" AllowSorting="True">
		<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
		<Columns>
			<asp:boundfield DataField="Year" HeaderText="Year" SortExpression="Year">
			</asp:boundfield>
			<asp:boundfield DataField="Month" HeaderText="Month" SortExpression="Month">
			</asp:boundfield>
			<asp:boundfield DataField="Avg Driver/Day" HeaderText="Avg Driver/Day" SortExpression="Avg Driver/Day">
			</asp:boundfield>
			<asp:boundfield DataField="Avg Rev/Day" DataFormatString="{0:c0}" HeaderText="Avg Rev/Day" HtmlEncode="False" SortExpression="Avg Rev/Day">
			</asp:boundfield>
			<asp:boundfield DataField="$/Dr/Day" DataFormatString="{0:c0}" HeaderText="$/Dr/Day" HtmlEncode="False" ReadOnly="True" SortExpression="$/Dr/Day">
			</asp:boundfield>
			<asp:boundfield DataField="Days Worked" HeaderText="Days Worked" SortExpression="Days Worked">
			</asp:boundfield>
		</Columns>
		<EditRowStyle BackColor="#2461BF" />
		<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Load Rev per Driver per Day M-F day ltd] ORDER BY [Year] DESC, [Month] DESC">
	</asp:SqlDataSource>
</form>
<p style="width: 399px; height: 118px">All data is based on loads with estimated 
revenue. M-F only. Planned Date. All non service drivers. This report is also limited to previous 
days' data. </p>

</body>

</html>
