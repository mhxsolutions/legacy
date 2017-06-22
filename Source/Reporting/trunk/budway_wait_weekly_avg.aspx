<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Budway Wait Weekly Avg</title>
</head>

<body>

<form id="form1" runat="server">
	<h4>Budway Wait Weekly Avg</h4>
	<asp:GridView runat="server" id="GridView1" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" ForeColor="#333333" CellPadding="4" GridLines="None" AllowSorting="True">
		<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<Columns>
			<asp:boundfield DataField="Year" SortExpression="Year" HeaderText="Year">
			</asp:boundfield>
			<asp:boundfield DataField="Week" SortExpression="Week" HeaderText="Week">
			</asp:boundfield>
			<asp:boundfield HtmlEncode="False" DataFormatString="{0:F1}" ReadOnly="True" DataField="Average" SortExpression="Average" HeaderText="Average">
			</asp:boundfield>
			<asp:boundfield DataField="Trk_Ct" SortExpression="Trk_Ct" HeaderText="Trk_Ct">
			</asp:boundfield>
		</Columns>
		<RowStyle BackColor="#EFF3FB" />
		<EditRowStyle BackColor="#2461BF" />
		<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Year], [Week], [Average], [Trk Ct] AS Trk_Ct FROM [webDetentionBudwayWkAvg] ORDER BY [Year] DESC, [Week] DESC">
	</asp:SqlDataSource>
</form>

</body>

</html>
