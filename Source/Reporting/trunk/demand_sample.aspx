<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Demand Sample</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Demand Sample</h3>
	<p>Select Date
	<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="Date" DataValueField="Date">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Date] FROM [OR demand] ORDER BY [Date] DESC">
	</asp:SqlDataSource>
	</p>
	<p><a href="solution_sample.aspx">solution page</a></p>
	<br />
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Date" HeaderText="Date" ReadOnly="True" SortExpression="Date">
			</asp:boundfield>
			<asp:boundfield DataField="Origin Ref" HeaderText="Origin Ref" SortExpression="Origin Ref">
			</asp:boundfield>
			<asp:boundfield DataField="Origin" HeaderText="Origin" ReadOnly="True" SortExpression="Origin">
			</asp:boundfield>
			<asp:boundfield DataField="Origin Detention" HeaderText="Origin Detention" SortExpression="Origin Detention">
			</asp:boundfield>
			<asp:boundfield DataField="Destination Ref" HeaderText="Destination Ref" SortExpression="Destination Ref">
			</asp:boundfield>
			<asp:boundfield DataField="Destination" HeaderText="Destination" ReadOnly="True" SortExpression="Destination">
			</asp:boundfield>
			<asp:boundfield DataField="Destination Detention" HeaderText="Destination Detention" SortExpression="Destination Detention">
			</asp:boundfield>
			<asp:boundfield DataField="Transit" HeaderText="Transit" SortExpression="Transit">
			</asp:boundfield>
			<asp:boundfield DataField="Load Ref" HeaderText="Load Ref" SortExpression="Load Ref">
			</asp:boundfield>
		</Columns>
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [OR demand] WHERE ([Date] = @Date)">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Date" PropertyName="SelectedValue" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
</form>
<p>&nbsp;</p>

</body>

</html>
