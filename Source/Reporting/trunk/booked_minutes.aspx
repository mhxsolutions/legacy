<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Booked Minutes</title>
<style type="text/css">
.style1 {
	text-align: left;
}
</style>
</head>

<body>

<form id="form1" runat="server">
	<h3>Booked Minutes MTD</h3>
	<div class="style1">
	<asp:GridView runat="server" id="GridView1" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" AllowSorting="True" ForeColor="#333333" CellPadding="4" GridLines="None" Width="464px">
		<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<Columns>
			<asp:boundfield DataField="Year" SortExpression="Year" HeaderText="Year">
			</asp:boundfield>
			<asp:boundfield DataField="Month" SortExpression="Month" HeaderText="Month">
			</asp:boundfield>
			<asp:boundfield HtmlEncode="False" DataFormatString="{0:n0}" DataField="MoTotal" SortExpression="MoTotal" HeaderText="MoTotal">
			</asp:boundfield>
			<asp:boundfield DataField="Avg Driver/Day" SortExpression="Avg Driver/Day" HeaderText="Avg Driver/Day">
			</asp:boundfield>
			<asp:boundfield HtmlEncode="False" DataFormatString="{0:f}" ReadOnly="True" DataField="Avg Hr/Driver/Day" SortExpression="Avg Hr/Driver/Day" HeaderText="Avg Hr/Driver/Day">
			</asp:boundfield>
			<asp:boundfield HtmlEncode="False" DataFormatString="{0:n0}" ReadOnly="True" DataField="Avg Min/Day" SortExpression="Avg Min/Day" HeaderText="Avg Min/Day">
			</asp:boundfield>
			<asp:boundfield DataField="Days Worked" SortExpression="Days Worked" HeaderText="Days Worked">
			</asp:boundfield>
		</Columns>
		<RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
		<EditRowStyle BackColor="#2461BF" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	</div>
	<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Booked Hours Monthly] ORDER BY [Year] DESC, [Month] DESC">
	</asp:SqlDataSource>
</form>

<p><a href="planned_minutes_history.aspx">See Detail Average Minutes per Day</a></p>

<p>non-service drivers only</p>
<p>M-F only</p>
<p>Includes pre-trip time @ 15 min each driver</p>

</body>

</html>
