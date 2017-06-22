<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<meta http-equiv="refresh" content="60" />
<title>Drivers At Harbor with Finalized</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Drivers At Harbor with Finalized Loads</h3>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
		<RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
		<Columns>
			<asp:boundfield DataField="Origin" HeaderText="Origin" ReadOnly="True" SortExpression="Origin">
			</asp:boundfield>
			<asp:boundfield DataField="Load" HeaderText="Load" SortExpression="Load">
			</asp:boundfield>
			<asp:boundfield DataField="Driver" HeaderText="Driver" ReadOnly="True" SortExpression="Driver">
			</asp:boundfield>
			<asp:boundfield DataField="Harbor_Time" DataFormatString="{0:t}" HeaderText="Harbor_Time" HtmlEncode="False" SortExpression="Harbor_Time">
			</asp:boundfield>
			<asp:boundfield DataField="Current_Delay" HeaderText="Current_Delay" ReadOnly="True" SortExpression="Current_Delay">
			</asp:boundfield>
		</Columns>
		<PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
		<HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Origin], [Load], [Driver], [Harbor Time] AS Harbor_Time, [Current Delay] AS Current_Delay FROM [Harbor Gun v Driver Phone times] WHERE ([Driver Time] IS NULL)">
	</asp:SqlDataSource>
</form>

</body>

</html>
