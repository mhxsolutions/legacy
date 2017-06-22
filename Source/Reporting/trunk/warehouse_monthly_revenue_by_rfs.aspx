<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Warehouse Monthly Revenue by RFS</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Warehouse Monthly Revenue by RFS</h3>
	<p>Year:
	<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="years" DataTextField="Year" DataValueField="Year">
	</asp:DropDownList>
	<asp:SqlDataSource ID="years" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Year] FROM [Warehouse Revenue Monthly by RFS] ORDER BY [Year] DESC">
	</asp:SqlDataSource>
	</p>
	<p>Month:
	<asp:DropDownList id="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="months" DataTextField="Month" DataValueField="Month">
	</asp:DropDownList>
	<asp:SqlDataSource ID="months" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Month] FROM [Warehouse Revenue Monthly by RFS] WHERE ([Year] = @Year) ORDER BY [Month] DESC">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Year" PropertyName="SelectedValue" Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
	</p>
	<p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Client" HeaderText="Client" SortExpression="Client">
			</asp:boundfield>
			<asp:boundfield DataField="RFS" HeaderText="RFS" SortExpression="RFS">
			</asp:boundfield>
			<asp:boundfield DataField="Revenue" DataFormatString="{0:c}" HeaderText="Revenue" HtmlEncode="False" SortExpression="Revenue">
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
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Client], [RFS], [Revenue] FROM [Warehouse Revenue Monthly by RFS] WHERE (([Month] = @Month) AND ([Year] = @Year)) ORDER BY [Client], [RFS]">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList2" Name="Month" PropertyName="SelectedValue" Type="Int32" />
			<asp:controlparameter ControlID="DropDownList1" Name="Year" PropertyName="SelectedValue" Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
	</p>
</form>

</body>

</html>
