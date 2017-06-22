<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Coils Shipped vs. Staged</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Coils Shipped vs. Staged Detail (Fontana)</h3>
	<p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Load" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="LogOutDate" DataFormatString="{0:d}" HeaderText="LogOutDate" HtmlEncode="False" SortExpression="LogOutDate">
			</asp:boundfield>
			<asp:boundfield DataField="Load" HeaderText="Load" ReadOnly="True" SortExpression="Load">
			</asp:boundfield>
			<asp:boundfield DataField="COIL" HeaderText="COIL" SortExpression="COIL">
			</asp:boundfield>
			<asp:boundfield DataField="StageTime" DataFormatString="{0:t}" HeaderText="StageTime" HtmlEncode="False" SortExpression="StageTime">
			</asp:boundfield>
			<asp:boundfield DataField="LogOutTime" DataFormatString="{0:t}" HeaderText="LogOutTime" HtmlEncode="False" SortExpression="LogOutTime">
			</asp:boundfield>
			<asp:boundfield DataField="On Planner At" HeaderText="On Planner At" SortExpression="On Planner At">
			</asp:boundfield>
			<asp:boundfield DataField="WC Log In" DataFormatString="{0:t}" HeaderText="WC Log In" HtmlEncode="False" SortExpression="WC Log In">
			</asp:boundfield>
			<asp:boundfield DataField="Name-city" HeaderText="Name-city" SortExpression="Name-city">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Coils Shipped v Staged Detail] ORDER BY [LogOutDate] DESC">
	</asp:SqlDataSource>
	</p>
</form>

</body>

</html>
