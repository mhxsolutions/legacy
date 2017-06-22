<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Current Inventory Summary with L</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Current Inventory Summary with Locations</h3>
	<p>includes BOLs not yet shipped</p>
	<p>Total on-site inventory: unallocated and allocated</p>
	<p>Client:
	<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="column1" DataValueField="column1">
	</asp:DropDownList>
	</p>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Name-city] AS column1 FROM [Current Inventory Summary with Locations and ext desc] ORDER BY [Name-city]">
	</asp:SqlDataSource>
	<p>&nbsp;</p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None">
		<RowStyle BackColor="#E3EAEB" />
		<Columns>
			<asp:boundfield DataField="Extended Description" HeaderText="Extended Description" SortExpression="Extended Description">
			</asp:boundfield>
			<asp:boundfield DataField="Product Group 1" HeaderText="PG1" SortExpression="Product Group 1">
			</asp:boundfield>
			<asp:boundfield DataField="Product Group 2" HeaderText="PG2" SortExpression="Product Group 2">
			</asp:boundfield>
			<asp:boundfield DataField="Product Group 3" HeaderText="PG3" SortExpression="Product Group 3">
			</asp:boundfield>
			<asp:boundfield DataField="Location" HeaderText="Location" SortExpression="Location">
			</asp:boundfield>
			<asp:boundfield DataField="Count" HeaderText="Count" SortExpression="Count">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#7C6F57" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Current Inventory Summary with Locations and ext desc] WHERE ([Name-city] = @column1) ORDER BY [Extended Description], [Product Group 1], [Product Group 2]">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="column1" PropertyName="SelectedValue" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
</form>

</body>

</html>
