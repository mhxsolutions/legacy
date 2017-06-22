<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Booked Throughput</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Booked Throughput (precision)</h3>
	<asp:GridView runat="server" id="GridView1" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" AllowSorting="True" ForeColor="#333333" CellPadding="4" GridLines="None" Width="367px">
		<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<Columns>
			<asp:boundfield DataField="Year" SortExpression="Year" HeaderText="Year">
			</asp:boundfield>
			<asp:boundfield DataField="Month" SortExpression="Month" HeaderText="Month">
			</asp:boundfield>
			<asp:boundfield DataField="Fleet" HeaderText="Fleet" SortExpression="Fleet">
			</asp:boundfield>
			<asp:boundfield HtmlEncode="False" DataFormatString="{0:c0}" DataField="Mo_Trans_Rev_Est" SortExpression="Mo_Trans_Rev_Est" HeaderText="Total Trans Rev Est">
			</asp:boundfield>
			<asp:boundfield DataFormatString="{0:n0}" DataField="Booked_Min_with_Pretrip" SortExpression="Booked_Min_with_Pretrip" HeaderText="Booked Min">
			</asp:boundfield>
			<asp:boundfield HtmlEncode="False" DataFormatString="{0:c}" ReadOnly="True" DataField="column1" SortExpression="column1" HeaderText="T/Booked Min">
			</asp:boundfield>
		</Columns>
		<RowStyle BackColor="#EFF3FB" />
		<EditRowStyle BackColor="#2461BF" />
		<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Year], [Month],[Fleet], [Mo Trans Rev Est] AS Mo_Trans_Rev_Est, [Booked Min with Pretrip] AS Booked_Min_with_Pretrip, [T/Booked Min] AS column1 FROM [Booked Min Mo Throughput 7day wk EOD ltd with pretrip min] ORDER BY [Year] DESC, [Month] DESC,[Fleet]">
	</asp:SqlDataSource>
</form>
<p>Precision:</p>
<p>7 days revenue</p>
<p>7 days booked minutes</p>
<p>EOD ltd</p>
<p>Includes 15 minute pretrip for each driver.</p>

</body>

</html>
