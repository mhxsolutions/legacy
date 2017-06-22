<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Planned Loaded History</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Planned Loaded History</h3>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Plan_Date" DataFormatString="{0:d}" HeaderText="Date" HtmlEncode="False" SortExpression="Plan_Date">
			</asp:boundfield>
			<asp:boundfield DataField="column1" DataFormatString="{0:p1}" HeaderText="% loaded" HtmlEncode="False" ReadOnly="True" SortExpression="column1">
			</asp:boundfield>
		</Columns>
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Plan Date] AS Plan_Date, [% Loaded] AS column1, [Count] FROM [Planned Loaded History] ORDER BY [Plan Date] DESC">
	</asp:SqlDataSource>
</form>

</body>

</html>
