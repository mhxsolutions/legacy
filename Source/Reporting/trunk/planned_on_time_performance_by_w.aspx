<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Planned On Time Performance by Week</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Planned On Time Performance by Week</h3>
	<asp:GridView runat="server" id="GridView1" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" ForeColor="#333333" CellPadding="4" GridLines="None" AllowSorting="True">
		<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<Columns>
			<asp:boundfield DataField="Year" SortExpression="Year" HeaderText="Year">
			</asp:boundfield>
			<asp:boundfield DataField="Week" SortExpression="Week" HeaderText="Week">
			</asp:boundfield>
			<asp:boundfield DataField="Planned Min" SortExpression="Planned Min" HeaderText="Planned Min">
			</asp:boundfield>
			<asp:boundfield DataField="Act Min" SortExpression="Act Min" HeaderText="Act Min">
			</asp:boundfield>
			<asp:boundfield DataField="AvgWkDrivers" SortExpression="AvgWkDrivers" HeaderText="Drv Ct">
			</asp:boundfield>
			<asp:boundfield HtmlEncode="False" DataFormatString="{0:p}" ReadOnly="True" DataField="Ratio" SortExpression="Ratio" HeaderText="Ratio">
			</asp:boundfield>
		</Columns>
		<RowStyle BackColor="#EFF3FB" />
		<EditRowStyle BackColor="#2461BF" />
		<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Booked Hours to Actual Hours Wkly] ORDER BY [Year] DESC, [Week] DESC">
	</asp:SqlDataSource>
</form>

</body>

</html>
