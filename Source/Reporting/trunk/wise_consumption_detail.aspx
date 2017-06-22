<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Wise Consumption Detail</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Wise Consumption Detail</h3>
	<p>
	<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="Year" DataValueField="Year">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Year] FROM [Wise detail consumption data] ORDER BY [Year] DESC">
	</asp:SqlDataSource>
	</p>
	<p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Destination,City" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" PageSize="100">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Year" HeaderText="Year" SortExpression="Year">
			</asp:boundfield>
			<asp:boundfield DataField="Week" HeaderText="Week" SortExpression="Week">
			</asp:boundfield>
			<asp:boundfield DataField="Destination" HeaderText="Destination" ReadOnly="True" SortExpression="Destination">
			</asp:boundfield>
			<asp:boundfield DataField="City" HeaderText="City" ReadOnly="True" SortExpression="City">
			</asp:boundfield>
			<asp:boundfield DataField="Product Group 1" HeaderText="Product Group 1" SortExpression="Product Group 1">
			</asp:boundfield>
			<asp:boundfield DataField="Pounds Delivered" DataFormatString="{0:n0}" HeaderText="Pounds Delivered" HtmlEncode="False" SortExpression="Pounds Delivered">
				<ItemStyle HorizontalAlign="Right" />
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Wise detail consumption data] WHERE ([Year] = @Year) ORDER BY [Year] DESC, [Week] DESC">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Year" PropertyName="SelectedValue" Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
	</p>
</form>

</body>

</html>
