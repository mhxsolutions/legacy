<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<meta http-equiv="refresh" content="60" />
<title>Drivers</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Drivers' Harbor Delay</h3>
	<p>as measured between Leg STA and Gun Finalize</p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" Width="419px">
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Load" HeaderText="Load" SortExpression="Load">
			</asp:boundfield>
			<asp:boundfield DataField="Driver" HeaderText="Driver" ReadOnly="True" SortExpression="Driver">
				<ItemStyle Wrap="False" />
			</asp:boundfield>
			<asp:boundfield DataField="Driver_Time" DataFormatString="{0:t}" HeaderText="Driver_Time" HtmlEncode="False" SortExpression="Driver_Time">
			</asp:boundfield>
			<asp:boundfield DataField="Harbor_Time" DataFormatString="{0:t}" HeaderText="Harbor_Time" HtmlEncode="False" SortExpression="Harbor_Time">
			</asp:boundfield>
			<asp:boundfield DataField="Harbor_to_Driver_Difference" HeaderText="Difference" ReadOnly="True" SortExpression="Harbor_to_Driver_Difference">
			</asp:boundfield>
			<asp:boundfield DataField="Origin" HeaderText="Origin" ReadOnly="True" SortExpression="Origin">
				<ItemStyle Wrap="False" />
			</asp:boundfield>
		</Columns>
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Origin], [Load], [Driver], [Driver Time] AS Driver_Time, [Harbor Time] AS Harbor_Time, [Harbor to Driver Difference] AS Harbor_to_Driver_Difference FROM [Harbor Gun v Driver Phone times] WHERE ([Driver Time] IS NOT NULL) ORDER BY [Origin], [Harbor Time]">
	</asp:SqlDataSource>
</form>

</body>

</html>
