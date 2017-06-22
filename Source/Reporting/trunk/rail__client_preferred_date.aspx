<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Rail - Client Preferred Date</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Rail - Client Preferred Date</h3>
	<p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Car Number" HeaderText="Car Number" SortExpression="Car Number">
			</asp:boundfield>
			<asp:boundfield DataField="Content" HeaderText="Content" SortExpression="Content">
			</asp:boundfield>
			<asp:boundfield DataField="E T A" DataFormatString="{0:d}" HeaderText="E T A" HtmlEncode="False" SortExpression="E T A">
			</asp:boundfield>
			<asp:boundfield DataField="Shipper" HeaderText="Shipper" SortExpression="Shipper">
			</asp:boundfield>
			<asp:boundfield DataField="CP Date" DataFormatString="{0:d}" HeaderText="CP Date" HtmlEncode="False" SortExpression="CP Date">
			</asp:boundfield>
			<asp:boundfield DataField="Terminal" HeaderText="Terminal" SortExpression="Terminal">
			</asp:boundfield>
			<asp:boundfield DataField="Client Preferred Date" DataFormatString="{0:d}" HeaderText="Client Preferred Date" HtmlEncode="False" SortExpression="Client Preferred Date">
			</asp:boundfield>
			<asp:boundfield DataField="Status" HeaderText="Status" SortExpression="Status">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Rail Client Prefered Date] ORDER BY [Client Preferred Date] DESC">
	</asp:SqlDataSource>
	</p>
</form>

</body>

</html>
