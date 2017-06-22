<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Planned Minutes by Month</title>
<style type="text/css">
.style1 {
	border-right-style: solid;
	border-right-width: 1px;
}
.style2 {
	border-left-style: solid;
	border-left-width: 1px;
}
</style>
</head>

<body>

<form id="form1" runat="server">
	<table style="width: 100%">
		<tr>
			<td class="style1" style="width: 522px">
			<h3>Planned Minutes by Month</h3>
			<p><a href="default.aspx">home</a>&nbsp;&nbsp;&nbsp;
			<a href="rick2.html">back</a></p>
			</td>
			<td class="style2">
			<p><strong>Terminal Review</strong></p>
			<p>Fleet:
			<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="Fleet" DataValueField="Fleet">
			</asp:DropDownList>
			<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Fleet] FROM [Booked Min by Fleet and Month] ORDER BY [Fleet]">
			</asp:SqlDataSource>
			</p>
			</td>
		</tr>
		<tr>
			<td class="style1" style="width: 522px" valign="top">
			<asp:GridView id="GridView2" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource3" ForeColor="#333333" GridLines="None" PageSize="12">
				<RowStyle BackColor="#EFF3FB" />
				<Columns>
					<asp:boundfield DataField="Year" HeaderText="Year" SortExpression="Year">
					</asp:boundfield>
					<asp:boundfield DataField="Month" HeaderText="Month" SortExpression="Month">
						<ItemStyle HorizontalAlign="Center" />
					</asp:boundfield>
					<asp:boundfield DataField="Booked Min" DataFormatString="{0:n0}" HeaderText="Booked Min" SortExpression="Booked Min">
						<ItemStyle HorizontalAlign="Center" />
					</asp:boundfield>
					<asp:boundfield DataField="Throughput" DataFormatString="{0:c}" HeaderText="Throughput" SortExpression="Throughput" ReadOnly="True">
						<ItemStyle HorizontalAlign="Right" />
					</asp:boundfield>
					<asp:boundfield DataField="Work Days" HeaderText="Work Days" SortExpression="Work Days">
						<ItemStyle HorizontalAlign="Center" />
					</asp:boundfield>
					<asp:boundfield DataField="Avg Min per Day" DataFormatString="{0:n0}" HeaderText="Avg Min per Day" ReadOnly="True" SortExpression="Avg Min per Day">
						<ItemStyle HorizontalAlign="Center" />
					</asp:boundfield>
				</Columns>
				<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
				<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
				<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
				<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
				<EditRowStyle BackColor="#2461BF" />
				<AlternatingRowStyle BackColor="White" />
			</asp:GridView>
			<asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Booked Min by Month with avg min per day] ORDER BY [Year] DESC, [Month] DESC">
			</asp:SqlDataSource>
			</td>
			<td class="style2" valign="top">
			<asp:GridView id="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None" PageSize="12">
				<RowStyle BackColor="#EFF3FB" />
				<Columns>
					<asp:boundfield DataField="Year" HeaderText="Year" SortExpression="Year">
					</asp:boundfield>
					<asp:boundfield DataField="Month" HeaderText="Month" SortExpression="Month">
						<ItemStyle HorizontalAlign="Center" />
					</asp:boundfield>
					<asp:boundfield DataField="Booked Min" DataFormatString="{0:n0}" HeaderText="Booked Min" SortExpression="Booked Min">
						<ItemStyle HorizontalAlign="Center" />
					</asp:boundfield>
					<asp:boundfield DataField="Throughput" DataFormatString="{0:c}" HeaderText="Throughput" SortExpression="Throughput" ReadOnly="True">
						<ItemStyle HorizontalAlign="Right" />
					</asp:boundfield>
					<asp:boundfield DataField="Work Days" HeaderText="Work Days" SortExpression="Work Days">
						<ItemStyle HorizontalAlign="Center" />
					</asp:boundfield>
					<asp:boundfield DataField="Avg Min per Day" DataFormatString="{0:n0}" HeaderText="Avg Min per Day" ReadOnly="True" SortExpression="Avg Min per Day">
						<ItemStyle HorizontalAlign="Center" />
					</asp:boundfield>
				</Columns>
				<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
				<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
				<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
				<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
				<EditRowStyle BackColor="#2461BF" />
				<AlternatingRowStyle BackColor="White" />
			</asp:GridView>
			<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Booked Min by Fleet and Month with average minper day] WHERE ([Fleet] = @Fleet) ORDER BY [Year] DESC, [Month] DESC">
				<SelectParameters>
					<asp:controlparameter ControlID="DropDownList1" Name="Fleet" PropertyName="SelectedValue" Type="String" />
				</SelectParameters>
			</asp:SqlDataSource>
			</td>
		</tr>
	</table>
</form>

</body>

</html>
