<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Current Inventory</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Client Inventory</h3>
	<p>includes BOLs not yet shipped</p>
	<p>Total on-site inventory: unallocated and allocated</p>
	<p>Client:
	<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="Client_Name" DataValueField="Client_Name">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Client Name] AS Client_Name FROM [Client inventory detail with pending BOL inventory] ORDER BY [Client Name]">
	</asp:SqlDataSource>
	</p>
	<p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" DataSourceID="SqlDataSource1" GridLines="Horizontal" AllowPaging="True" PageSize="500">
		<RowStyle BackColor="White" ForeColor="#333333" />
		<Columns>
			<asp:boundfield DataField="Receiver ID" HeaderText="Receiver ID" SortExpression="Receiver ID">
			</asp:boundfield>
			<asp:boundfield DataField="Date Received" DataFormatString="{0:d}" HeaderText="Date Received" SortExpression="Date Received">
			</asp:boundfield>
			<asp:boundfield DataField="Product Profile Description" HeaderText="Product Profile Description" SortExpression="Product Profile Description">
			</asp:boundfield>
			<asp:boundfield DataField="Product Group 1" HeaderText="Product Group 1" SortExpression="Product Group 1">
			</asp:boundfield>
			<asp:boundfield DataField="Product Group 2" HeaderText="Product Group 2" SortExpression="Product Group 2">
			</asp:boundfield>
			<asp:boundfield DataField="Product Group 3" HeaderText="Product Group 3" SortExpression="Product Group 3">
			</asp:boundfield>
			<asp:boundfield DataField="Weight" HeaderText="Weight" SortExpression="Weight">
			</asp:boundfield>
			<asp:boundfield DataField="Count In Package" HeaderText="Count In Package" SortExpression="Count In Package">
			</asp:boundfield>
			<asp:boundfield DataField="Load ID" HeaderText="BOL" SortExpression="Load ID">
			</asp:boundfield>
			<asp:boundfield DataField="Shipment Date" DataFormatString="{0:d}" HeaderText="BOL Date" SortExpression="Shipment Date">
			</asp:boundfield>
			<asp:boundfield DataField="Source REF" HeaderText="Source REF" SortExpression="Source REF">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="White" ForeColor="#333333" />
		<PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
		<HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Client inventory detail with pending BOL inventory] WHERE ([Client Name] = @Client_Name)">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Client_Name" PropertyName="SelectedValue" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	</p>
</form>

</body>

</html>
