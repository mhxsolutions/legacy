<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Load REvenue Minutes</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Actual Minutes with Rev Calcs<br />
	</h3>
	<asp:GridView runat="server" id="GridView1" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" ForeColor="#333333" CellPadding="4" GridLines="None" Width="300px">
		<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<Columns>
			<asp:boundfield DataField="Year" SortExpression="Year" HeaderText="Year">
			</asp:boundfield>
			<asp:boundfield DataField="Month" SortExpression="Month" HeaderText="Month">
			</asp:boundfield>
			<asp:boundfield HtmlEncode="False" DataFormatString="{0:n0}" DataField="Minutes in Load Rev" SortExpression="Minutes in Load Rev" HeaderText="Minutes in Load Rev">
			</asp:boundfield>
			<asp:boundfield HtmlEncode="False" DataFormatString="{0:c0}" DataField="Load Rev with Min" SortExpression="Load Rev with Min" HeaderText="Load Rev with Min">
			</asp:boundfield>
		</Columns>
		<RowStyle BackColor="#EFF3FB" HorizontalAlign="Right" />
		<EditRowStyle BackColor="#2461BF" />
		<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Load Rev Minutes Summary] ORDER BY [Year] DESC, [Month] DESC">
	</asp:SqlDataSource>
</form>

</body>

</html>
