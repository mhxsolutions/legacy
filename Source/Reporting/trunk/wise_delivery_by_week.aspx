<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Wise Delivery by Week</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Wise Delivery by Week</h3>
	<p>Week Starting:
	<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="Start" DataValueField="Start">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Start] FROM [Wise quota balance] ORDER BY [Start] DESC">
	</asp:SqlDataSource>
	</p>
	<p>
	<asp:GridView id="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" PageSize="25">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="column1" HeaderText="Gage - Width" SortExpression="column1">
			</asp:boundfield>
			<asp:boundfield DataField="Pounds" DataFormatString="{0:n0}" HeaderText="Pounds" SortExpression="Pounds">
				<ItemStyle HorizontalAlign="Right" />
			</asp:boundfield>
			<asp:boundfield DataField="Min_Pounds_Quota" HeaderText="Min_Pounds_Quota" SortExpression="Min_Pounds_Quota" DataFormatString="{0:n0}">
				<ItemStyle HorizontalAlign="Right" />
			</asp:boundfield>
			<asp:boundfield DataField="Max_Pounds_Quota" DataFormatString="{0:n0}" HeaderText="Max_Pounds_Quota" SortExpression="Max_Pounds_Quota">
				<ItemStyle HorizontalAlign="Right" />
			</asp:boundfield>
			<asp:boundfield DataField="Pounds_Remaining" DataFormatString="{0:n0}" HeaderText="Pounds_Remaining" SortExpression="Pounds_Remaining" ReadOnly="True">
				<ItemStyle HorizontalAlign="Right" />
			</asp:boundfield>
			<asp:BoundField DataField="column2" HeaderText="Destination" SortExpression="column2">
			</asp:BoundField>
		</Columns>
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Gage - Width] AS column1, [Pounds], [Min Pounds Quota] AS Min_Pounds_Quota, [Max Pounds Quota] AS Max_Pounds_Quota, [Pounds Remaining] AS Pounds_Remaining, [Name-city] AS column2 FROM [Wise quota balance] WHERE ([Start] = @Start) ORDER BY [Gage - Width]">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Start" PropertyName="SelectedValue" Type="DateTime" />
		</SelectParameters>
	</asp:SqlDataSource>
	</p>
</form>

</body>

</html>
