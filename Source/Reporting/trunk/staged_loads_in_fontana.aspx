<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<meta name="viewport" content="width=320" />
<meta http-equiv="refresh" content="180" />
<title>Staged Loads in Fontana</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Staged Loads in Fontana</h3>
	<p>&nbsp;</p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Date" DataFormatString="{0:d}" HeaderText="Date" HtmlEncode="False" SortExpression="Date">
			</asp:boundfield>
			<asp:boundfield DataField="Load Ct" HeaderText="Load Ct" SortExpression="Load Ct">
			</asp:boundfield>
			<asp:boundfield DataField="Staged" HeaderText="Staged" SortExpression="Staged">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Staged Loads Origin Fontana] ORDER BY [Date] DESC">
	</asp:SqlDataSource>
</form>

</body>

</html>
