<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Load Summary</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Planned/Roll-Over Load Summary</h3>
	<p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Plan_Date" DataFormatString="{0:d}" HeaderText="Plan_Date" HtmlEncode="False" SortExpression="Plan_Date">
			</asp:boundfield>
			<asp:boundfield DataField="Tendered" HeaderText="Tendered" SortExpression="Tendered">
				<ItemStyle HorizontalAlign="Center" />
			</asp:boundfield>
			<asp:boundfield DataField="Ct_Planned" HeaderText="Ct_Planned" SortExpression="Ct_Planned">
				<ItemStyle HorizontalAlign="Center" />
			</asp:boundfield>
			<asp:boundfield DataField="Unplanned_Roll_Over" HeaderText="Roll Over" SortExpression="Unplanned_Roll_Over">
				<ItemStyle HorizontalAlign="Center" />
			</asp:boundfield>
			<asp:boundfield DataField="Delivered" HeaderText="Delivered" SortExpression="Delivered">
				<ItemStyle HorizontalAlign="Center" />
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Plan Date] AS Plan_Date, [Tendered], [Ct Planned] AS Ct_Planned, [Unplanned Roll Over] AS Unplanned_Roll_Over, [Delivered] FROM [Planner Ct Planned] ORDER BY [Plan Date] DESC">
	</asp:SqlDataSource>
	</p>
</form>

</body>

</html>
