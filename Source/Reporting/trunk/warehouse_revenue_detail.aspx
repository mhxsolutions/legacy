<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Warehouse Revenue Detail</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Warehouse Revenue Detail&nbsp;&nbsp;&nbsp; </h3>
	<p>&nbsp;</p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Document Date" DataFormatString="{0:d}" HeaderText="Document Date" HtmlEncode="False" SortExpression="Document Date">
			</asp:boundfield>
			<asp:boundfield DataField="Document Type" HeaderText="Document Type" SortExpression="Document Type">
			</asp:boundfield>
			<asp:boundfield DataField="Document Id" HeaderText="Document Id" SortExpression="Document Id">
			</asp:boundfield>
			<asp:boundfield DataField="Inv Client" HeaderText="Inv Client" SortExpression="Inv Client">
			</asp:boundfield>
			<asp:boundfield DataField="Weight" DataFormatString="{0:n0}" HeaderText="Weight" HtmlEncode="False" SortExpression="Weight">
			</asp:boundfield>
			<asp:boundfield DataField="Type" HeaderText="Type" SortExpression="Type">
				<ItemStyle HorizontalAlign="Center" />
			</asp:boundfield>
			<asp:boundfield DataField="Revenue" DataFormatString="{0:c}" HeaderText="Revenue" HtmlEncode="False" SortExpression="Revenue">
			</asp:boundfield>
		</Columns>
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Warehouse Revenue Detail 30 day] ORDER BY [Document Date] DESC, [Document Type], [Document Id] DESC">
	</asp:SqlDataSource>
</form>

</body>

</html>
