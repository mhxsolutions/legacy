<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Origin Monthly Summary</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Origin Monthly Summary</h3>
	<table style="width: 100%">
		<tr>
			<td style="width: 269px">Year:
			<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="Year" DataValueField="Year">
			</asp:DropDownList>
			<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Year] FROM [Planned Loads Origin Summary by Month] ORDER BY [Year] DESC">
			</asp:SqlDataSource>
			</td>
			<td>Month:
			<asp:DropDownList id="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="Month" DataValueField="Month">
			</asp:DropDownList>
			<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Month] FROM [Planned Loads Origin Summary by Month] WHERE ([Year] = @Year) ORDER BY [Month] DESC">
				<SelectParameters>
					<asp:controlparameter ControlID="DropDownList1" Name="Year" PropertyName="SelectedValue" Type="Int32" />
				</SelectParameters>
			</asp:SqlDataSource>
			</td>
		</tr>
		<tr>
			<td style="width: 269px">&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
	</table>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource4" ForeColor="#333333" GridLines="None">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Fleet" HeaderText="Fleet" SortExpression="Fleet">
			</asp:boundfield>
			<asp:boundfield DataField="Origin" HeaderText="Origin" SortExpression="Origin">
			</asp:boundfield>
			<asp:boundfield DataField="Count" HeaderText="Count" SortExpression="Count">
			</asp:boundfield>
			<asp:boundfield DataField="Net_Tons" DataFormatString="{0:n1}" HeaderText="Net_Tons" SortExpression="Net_Tons">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Count], [Origin], [Net Tons] AS Net_Tons, [Fleet] FROM [Planned Loads Origin Summary by Month] WHERE (([Year] = @Year) AND ([Month] = @Month)) ORDER BY [Origin]">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Year" PropertyName="SelectedValue" Type="Int32" />
			<asp:controlparameter ControlID="DropDownList2" Name="Month" PropertyName="SelectedValue" Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
</form>

</body>

</html>
