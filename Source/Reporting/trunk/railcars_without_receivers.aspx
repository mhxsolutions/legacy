<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<meta name="viewport" content="width=320" />
<title>Railcars without Receivers</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Railcars without Receivers</h3>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Terminal" HeaderText="Terminal" SortExpression="Terminal">
			</asp:boundfield>
			<asp:boundfield DataField="Car Number" HeaderText="Car Number" SortExpression="Car Number">
			</asp:boundfield>
			<asp:boundfield DataField="daterel" DataFormatString="{0:d}" HeaderText="Released" HtmlEncode="False" SortExpression="daterel">
			</asp:boundfield>
			<asp:boundfield DataField="Shipper" HeaderText="Shipper" SortExpression="Shipper">
			</asp:boundfield>
			<asp:boundfield DataField="Content" HeaderText="Content" SortExpression="Content">
			</asp:boundfield>
			<asp:boundfield DataField="Status" HeaderText="Status" SortExpression="Status">
			</asp:boundfield>
			<asp:checkboxfield DataField="WhseComplete" HeaderText="WhseComplete" SortExpression="WhseComplete">
			</asp:checkboxfield>
		</Columns>
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" SelectCommand="SELECT * FROM [railcars without receivers detail ltd] ORDER BY [Terminal], [Car Number]">
	</asp:SqlDataSource>
</form>

</body>

</html>
