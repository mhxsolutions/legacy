<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Revenue History</title>
<style type="text/css">
.style1 {
	text-align: left;
}
</style>
</head>

<body>

<form id="form1" runat="server">
	<h3>Revenue History (POD date)</h3>
	<div class="style1">
	<asp:GridView runat="server" id="GridView1" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" AllowSorting="True" AllowPaging="True" Width="300px" ForeColor="#333333" CellPadding="4" GridLines="None">
		<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<Columns>
			<asp:boundfield DataField="Date" SortExpression="Date" HeaderText="LogOut Dt">
			</asp:boundfield>
			<asp:boundfield HtmlEncode="False" DataFormatString="{0:c0}" ReadOnly="True" DataField="Revenue" SortExpression="Revenue" HeaderText="Revenue">
				<ItemStyle HorizontalAlign="Center" />
			</asp:boundfield>
			<asp:boundfield DataField="Rev Ct" SortExpression="Rev Ct" HeaderText="Rev Ct">
			</asp:boundfield>
			<asp:boundfield DataField="Total" SortExpression="Total" HeaderText="Total">
			</asp:boundfield>
		</Columns>
		<RowStyle BackColor="#EFF3FB" />
		<EditRowStyle BackColor="#2461BF" />
		<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	</div>
	<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Load Rev 30 day Summary] ORDER BY [Date] DESC">
	</asp:SqlDataSource>
</form>

<p>Other reports are based on the Planed Delivery date. This report is based on 
the Log Out Date.</p>

</body>

</html>
