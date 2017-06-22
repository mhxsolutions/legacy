<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>UPI MTD Status</title>
<style type="text/css">
.style1 {
	text-align: center;
}
</style>
<base target="rbottom" />
</head>

<body>

<form id="form1" runat="server">
	<h2 class="style1">UPI MTD Stats</h2>
	<div class="style1">
		<asp:GridView runat="server" id="GridView1" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" ForeColor="#333333" CellPadding="4" GridLines="None">
			<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
			<Columns>
				<asp:boundfield DataField="Month" SortExpression="Month" HeaderText="Month">
				</asp:boundfield>
				<asp:boundfield DataField="Year" SortExpression="Year" HeaderText="Year">
				</asp:boundfield>
				<asp:boundfield DataField="Fleet" HeaderText="Fleet" SortExpression="Fleet">
				</asp:boundfield>
				<asp:boundfield DataField="MTD Load Count" SortExpression="MTD Load Count" HeaderText="MTD Load Count">
				</asp:boundfield>
				<asp:boundfield HtmlEncode="False" DataFormatString="{0:f0}" DataField="MTD Tons" SortExpression="MTD Tons" HeaderText="MTD Tons">
				</asp:boundfield>
				<asp:boundfield DataField="UPI Loads Delivered Today" SortExpression="UPI Loads Delivered Today" HeaderText="UPI Loads Delivered Today">
				</asp:boundfield>
				<asp:boundfield DataField="Additional UPI Loads with Current Date" SortExpression="Additional UPI Loads with Current Date" HeaderText="Ad'l Loads with Current Date">
				</asp:boundfield>
			</Columns>
			<RowStyle BackColor="#EFF3FB" />
			<EditRowStyle BackColor="#2461BF" HorizontalAlign="Center" />
			<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True" />
			<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
			<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" BorderStyle="Solid" BorderWidth="1px" BorderColor="Black" />
			<AlternatingRowStyle BackColor="White" />
		</asp:GridView>
	</div>
	<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [UPI Status]">
	</asp:SqlDataSource>

<p class="style1">(Loads with DLV status only. Calculations as of&nbsp; this 
minute.)</p>
	<p class="style1">Tonnage calculations must consider that the MTD tons 
	includes the UPI Loads Delivered Today. It does not include planned loads 
	that are not yet delivered.</p>

	<div class="style1">
		<asp:GridView id="GridView2" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None">
			<FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
			<RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
			<Columns>
				<asp:boundfield DataField="month" HeaderText="Month" SortExpression="month">
				</asp:boundfield>
				<asp:boundfield DataField="year" HeaderText="Year" SortExpression="year">
				</asp:boundfield>
				<asp:boundfield DataField="Loads_Remaining" HeaderText="Loads Remaining" SortExpression="Loads_Remaining">
				</asp:boundfield>
				<asp:boundfield DataField="Tons_Remaining" DataFormatString="{0:f1}" HeaderText="Tons Remaining" HtmlEncode="False" SortExpression="Tons_Remaining">
				</asp:boundfield>
			</Columns>
			<PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
			<SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
			<HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
			<AlternatingRowStyle BackColor="White" />
		</asp:GridView>
	</div>
	<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [month], [year], [Loads Remaining] AS Loads_Remaining, [Tons Remaining] AS Tons_Remaining FROM [UPI remaining MTD]">
	</asp:SqlDataSource>
</form>

</body>

</html>
