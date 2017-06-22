<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Today's Pre Trip Times</title>
<style type="text/css">
.style1 {
	text-align: left;
}
</style>
</head>

<body>

<form id="form1" runat="server">
	<h3>Today's Pre-Trip Times</h3>
	<div class="style1">
		<asp:GridView runat="server" id="GridView1" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" ForeColor="#333333" CellPadding="4" GridLines="None" AllowSorting="True">
			<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
			<Columns>
				<asp:boundfield DataField="Driver" SortExpression="Driver" HeaderText="Driver">
				</asp:boundfield>
				<asp:boundfield DataField="Clock_In" SortExpression="Clock_In" HeaderText="Clock_In">
				</asp:boundfield>
				<asp:boundfield ReadOnly="True" DataField="Pre_Trip_Time" SortExpression="Pre_Trip_Time" HeaderText="Pre_Trip_Time">
				</asp:boundfield>
			</Columns>
			<RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
			<EditRowStyle BackColor="#2461BF" />
			<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True" />
			<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
			<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
			<AlternatingRowStyle BackColor="White" />
		</asp:GridView>
	</div>
	<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Driver], [Clock In] AS Clock_In, [Pre Trip Time] AS Pre_Trip_Time FROM [Driver's Pre Trip Time Today Summary] ORDER BY [Driver]">
	</asp:SqlDataSource>
</form>
<p>If Drivers are missing from this report it is because they did not clock in 
today.</p>

</body>

</html>
