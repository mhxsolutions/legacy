<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Load Count and Weight Summary</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Load Count and Weight Summary</h3>
	<table style="width: 100%">
		<tr>
			<td style="width: 199px">Year:
			<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="Year" DataValueField="Year">
			</asp:DropDownList>
			<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Year] FROM [Load Count and Weight Summary] ORDER BY [Year] DESC">
			</asp:SqlDataSource>
			</td>
			<td style="width: 213px">Month:
			<asp:DropDownList id="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="Month" DataValueField="Month">
			</asp:DropDownList>
			<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Month] FROM [Load Count and Weight Summary] WHERE ([Year] = @Year) ORDER BY [Month] DESC">
				<SelectParameters>
					<asp:controlparameter ControlID="DropDownList1" Name="Year" PropertyName="SelectedValue" Type="Int32" />
				</SelectParameters>
			</asp:SqlDataSource>
			</td>
			<td>Fleet:
			<asp:DropDownList id="DropDownList3" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource3" DataTextField="Fleet" DataValueField="Fleet">
			</asp:DropDownList>
			<asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Fleet] FROM [Load Count and Weight Summary] WHERE (([Year] = @Year) AND ([Month] = @Month)) ORDER BY [Fleet]">
				<SelectParameters>
					<asp:controlparameter ControlID="DropDownList1" Name="Year" PropertyName="SelectedValue" Type="Int32" />
					<asp:controlparameter ControlID="DropDownList2" Name="Month" PropertyName="SelectedValue" Type="Int32" />
				</SelectParameters>
			</asp:SqlDataSource>
			</td>
		</tr>
		<tr>
			<td colspan="3">
			<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource4" ForeColor="#333333" GridLines="None">
				<RowStyle BackColor="#EFF3FB" />
				<Columns>
					<asp:boundfield DataField="Origin" HeaderText="Origin" SortExpression="Origin">
					</asp:boundfield>
					<asp:boundfield DataField="Destination" HeaderText="Destination" SortExpression="Destination">
					</asp:boundfield>
					<asp:boundfield DataField="Client" HeaderText="Client" SortExpression="Client">
					</asp:boundfield>
					<asp:boundfield DataField="Load_Ct" HeaderText="Load_Ct" SortExpression="Load_Ct">
					</asp:boundfield>
					<asp:boundfield DataField="Avg_Wt" HeaderText="Avg_Wt" ReadOnly="True" SortExpression="Avg_Wt">
					</asp:boundfield>
					<asp:boundfield DataField="Man_Rev" HeaderText="Man_Rev" SortExpression="Man_Rev">
					</asp:boundfield>
					<asp:boundfield DataField="Rev_Total" HeaderText="Rev_Total" SortExpression="Rev_Total">
					</asp:boundfield>
					<asp:boundfield DataField="Avg_Transit" HeaderText="Avg_Transit" SortExpression="Avg_Transit">
					</asp:boundfield>
					<asp:boundfield DataField="Dwell" HeaderText="Dwell" SortExpression="Dwell">
					</asp:boundfield>
				</Columns>
				<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
				<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
				<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
				<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
				<EditRowStyle BackColor="#2461BF" />
				<AlternatingRowStyle BackColor="White" />
			</asp:GridView>
			<asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Origin], [Destination], [Client], [Load Ct] AS Load_Ct, [Avg Wt] AS Avg_Wt, [Man Rev] AS Man_Rev, [Rev Total] AS Rev_Total, [Avg Transit] AS Avg_Transit, [Dwell] FROM [Load Count and Weight Summary] WHERE (([Year] = @Year) AND ([Month] = @Month) AND ([Fleet] = @Fleet))">
				<SelectParameters>
					<asp:controlparameter ControlID="DropDownList1" Name="Year" PropertyName="SelectedValue" Type="Int32" />
					<asp:controlparameter ControlID="DropDownList2" Name="Month" PropertyName="SelectedValue" Type="Int32" />
					<asp:controlparameter ControlID="DropDownList3" Name="Fleet" PropertyName="SelectedValue" Type="String" />
				</SelectParameters>
			</asp:SqlDataSource>
			</td>
		</tr>
	</table>
	<p>&nbsp;</p>
</form>

</body>

</html>
