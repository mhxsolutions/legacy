<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Booked Hours to Actual Hours</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Booked Hours to Actual Hours</h3>
	<asp:GridView runat="server" id="GridView1" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" AllowSorting="True" ForeColor="#333333" CellPadding="4" GridLines="None" Width="584px">
		<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Year" HeaderText="Year" SortExpression="Year">
			</asp:boundfield>
			<asp:boundfield DataField="Month" HeaderText="Month" SortExpression="Month">
			</asp:boundfield>
			<asp:boundfield DataField="Planned Min" DataFormatString="{0:n0}" HeaderText="Planned Min" HtmlEncode="False" SortExpression="Planned Min">
				<ItemStyle HorizontalAlign="Center" />
			</asp:boundfield>
			<asp:boundfield DataField="Pln Avg Driver Hr" DataFormatString="{0:f}" HeaderText="Pln Avg Driver Hr" HtmlEncode="False" ReadOnly="True" SortExpression="Pln Avg Driver Hr">
				<ItemStyle HorizontalAlign="Center" />
			</asp:boundfield>
			<asp:boundfield DataField="Act Min" DataFormatString="{0:n0}" HeaderText="Act Min" HtmlEncode="False" SortExpression="Act Min">
				<ItemStyle HorizontalAlign="Center" />
			</asp:boundfield>
			<asp:boundfield DataField="Act Avg Driver Hr" DataFormatString="{0:f}" HeaderText="Act Avg Driver Hr" HtmlEncode="False" ReadOnly="True" SortExpression="Act Avg Driver Hr">
				<ItemStyle HorizontalAlign="Center" />
			</asp:boundfield>
			<asp:boundfield DataField="Ratio" DataFormatString="{0:p0}" HeaderText="P2P Ratio" HtmlEncode="False" ReadOnly="True" SortExpression="Ratio">
				<ItemStyle Wrap="False" />
			</asp:boundfield>
		</Columns>
		<EditRowStyle BackColor="#2461BF" />
		<SelectedRowStyle HorizontalAlign="Center" BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Booked Hours to Actual Hours] ORDER BY [Year] DESC, [Month] DESC">
	</asp:SqlDataSource>
</form>

<p>Monday - Friday Hours (EOD ltd.)</p>

<p>Includes pre-trip time.</p>

</body>

</html>
