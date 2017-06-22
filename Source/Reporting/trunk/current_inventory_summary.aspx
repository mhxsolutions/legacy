<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Current Inventory Summary</title>
</head>

<body>

	<form id="form1" runat="server">

	<h3>Client Inventory Summary</h3>
	<p>includes BOLs not yet shipped</p>
	<p>Total on-site inventory: unallocated and allocated</p>
	<p>Client:
	<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="Client_Name" DataValueField="Client_Name">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Client Name] AS Client_Name FROM [client inventory summary with pending BOL] ORDER BY [Client Name]">
	</asp:SqlDataSource>
		</p>
		<p>
		<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None" ShowFooter="True">
			<RowStyle BackColor="#EFF3FB" />
			<Columns>
				<asp:boundfield DataField="Client Name" HeaderText="Client Name" SortExpression="Client Name">
				</asp:boundfield>
				<asp:boundfield DataField="Product Profile Description" HeaderText="Profile" SortExpression="Product Profile Description">
				</asp:boundfield>
				<asp:boundfield DataField="Product Group 1" HeaderText="PG1" SortExpression="Product Group 1">
				</asp:boundfield>
				<asp:boundfield DataField="Product Group 2" HeaderText="PG2" SortExpression="Product Group 2">
				</asp:boundfield>
				<asp:boundfield DataField="Product Group 3" HeaderText="PG3" SortExpression="Product Group 3">
				</asp:boundfield>
				<asp:boundfield DataField="Tons" DataFormatString="{0:n1}" HeaderText="Tons" SortExpression="Tons">
					<ItemStyle HorizontalAlign="Right" />
				</asp:boundfield>
				<asp:boundfield DataField="Count" HeaderText="Count" SortExpression="Count">
					<ItemStyle HorizontalAlign="Right" />
				</asp:boundfield>
				<asp:boundfield DataField="Linear Ft" DataFormatString="{0:n1}" HeaderText="Linear Ft" SortExpression="Linear Ft">
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
		<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [client inventory summary with pending BOL] WHERE ([Client Name] = @Client_Name) ORDER BY [Product Profile Description], [Product Group 1], [Product Group 2]">
			<SelectParameters>
				<asp:controlparameter ControlID="DropDownList1" Name="Client_Name" PropertyName="SelectedValue" Type="String" />
			</SelectParameters>
		</asp:SqlDataSource>
		</p>

	</form>

</body>

</html>
