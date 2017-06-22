<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<meta name="viewport" content="width=320" />
<title>Raritan Inventory</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Raritan Inventory</h3>
	<p>Product Symmary</p>
	<p>
	<asp:GridView id="GridView2" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Client" HeaderText="Client" SortExpression="Client">
			</asp:boundfield>
			<asp:boundfield DataField="PG 1" HeaderText="PG 1" SortExpression="PG 1">
			</asp:boundfield>
			<asp:boundfield DataField="PG 2" HeaderText="PG 2" SortExpression="PG 2">
			</asp:boundfield>
			<asp:boundfield DataField="Total Wt" HeaderText="Total Wt" SortExpression="Total Wt">
			</asp:boundfield>
			<asp:boundfield DataField="Total Pkg" HeaderText="Total Pkg" SortExpression="Total Pkg">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Raritan Inventory PG2 Summary] ORDER BY [Client], [PG 1], [PG 2]">
	</asp:SqlDataSource>
	</p>
	<p>&nbsp;</p>
	<p>Rail Breakout</p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Car Number" HeaderText="Car Number" SortExpression="Car Number">
			</asp:boundfield>
			<asp:boundfield DataField="Date Received" DataFormatString="{0:d}" HeaderText="Date Received" HtmlEncode="False" SortExpression="Date Received">
			</asp:boundfield>
			<asp:boundfield DataField="Client" HeaderText="Client" SortExpression="Client">
			</asp:boundfield>
			<asp:boundfield DataField="Product Group 1" HeaderText="Product Group 1" SortExpression="Product Group 1">
			</asp:boundfield>
			<asp:boundfield DataField="Product Group 2" HeaderText="Product Group 2" SortExpression="Product Group 2">
			</asp:boundfield>
			<asp:boundfield DataField="Weight" HeaderText="Weight" SortExpression="Weight">
			</asp:boundfield>
			<asp:boundfield DataField="Ct" HeaderText="Ct" SortExpression="Ct">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Raritan Inventory]">
	</asp:SqlDataSource>
</form>

</body>

</html>
