<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Throughput by Totals</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>&nbsp;Actual Throughput (EOD ltd.)</h3>
	<p>Total Load Rev Est / Total Actual Minutes</p>
	<asp:GridView runat="server" id="GridView1" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" GridLines="Horizontal" AllowSorting="True" Width="552px">
		<FooterStyle BackColor="White" ForeColor="#333333" />
		<Columns>
			<asp:boundfield DataField="Year" SortExpression="Year" HeaderText="Year">
			</asp:boundfield>
			<asp:boundfield DataField="Month" SortExpression="Month" HeaderText="Month">
			</asp:boundfield>
			<asp:boundfield HtmlEncode="False" DataFormatString="{0:c0}" DataField="Mo Trans Rev Est" SortExpression="Mo Trans Rev Est" HeaderText="Mo Trans Rev Est">
				<ItemStyle HorizontalAlign="Right" />
				<HeaderStyle HorizontalAlign="Right" />
			</asp:boundfield>
			<asp:boundfield HtmlEncode="False" DataFormatString="{0:c0}" DataField="Mo FSC Rev Est" SortExpression="Mo FSC Rev Est" HeaderText="Mo FSC Rev Est">
				<ItemStyle HorizontalAlign="Right" />
				<HeaderStyle HorizontalAlign="Right" />
			</asp:boundfield>
			<asp:boundfield HtmlEncode="False" DataFormatString="{0:n0}" DataField="Act Min" SortExpression="Act Min" HeaderText="Act Min">
				<ItemStyle HorizontalAlign="Right" />
			</asp:boundfield>
			<asp:boundfield HtmlEncode="False" DataFormatString="{0:c}" ReadOnly="True" DataField="Rev/Act Min" SortExpression="Rev/Act Min" HeaderText="Rev/Act Min">
				<ItemStyle HorizontalAlign="Center" />
			</asp:boundfield>
			<asp:boundfield HtmlEncode="False" DataFormatString="{0:c}" ReadOnly="True" DataField="Rev/Act Min with FSC" SortExpression="Rev/Act Min with FSC" HeaderText="Rev/Act Min with FSC">
				<ItemStyle HorizontalAlign="Center" />
			</asp:boundfield>
		</Columns>
		<RowStyle BackColor="White" ForeColor="#333333" />
		<SelectedRowStyle BackColor="#339966" ForeColor="White" Font-Bold="True" />
		<PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
		<HeaderStyle BackColor="#336666" ForeColor="White" Font-Bold="True" />
	</asp:GridView>
	<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Throughput total rev over act min] ORDER BY [Year] DESC, [Month] DESC">
	</asp:SqlDataSource>
</form>

<p>All loads in Load Rev with Log Out Date less than today. Includes weekends.</p>
<p>Revenue is based on Log Out Date as listed in Load Rev.</p>

</body>

</html>
