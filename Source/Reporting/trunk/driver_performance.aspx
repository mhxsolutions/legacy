<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Driver Performance</title>
<meta http-equiv="refresh" content="60" />
</head>

<body>

<form id="form1" runat="server">
	<h3>Driver Performance</h3>
	<p style="width: 330px">+ time over plan (bad)&nbsp; - time ahead of plan 
	(good)</p>
	<asp:GridView runat="server" id="GridView1" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" AllowSorting="True">
		<FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
		<Columns>
			<asp:boundfield DataField="Date" SortExpression="Date" HeaderText="Date">
			</asp:boundfield>
			<asp:boundfield DataField="Drivers" SortExpression="Drivers" HeaderText="Drivers">
			</asp:boundfield>
			<asp:boundfield DataField="Off Sch" SortExpression="Off Sch" HeaderText="Off Sch">
			</asp:boundfield>
		</Columns>
		<RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
		<SelectedRowStyle BackColor="#738A9C" ForeColor="#F7F7F7" Font-Bold="True" />
		<PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
		<HeaderStyle BackColor="#4A3C8C" ForeColor="#F7F7F7" Font-Bold="True" />
		<AlternatingRowStyle BackColor="#F7F7F7" />
	</asp:GridView>
	<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Driver Performance to Plan for Today] ORDER BY [Off Sch] DESC">
	</asp:SqlDataSource>
</form>
<p><a href="worst_leg.aspx">Driver's Worst Leg</a></p>

</body>

</html>
