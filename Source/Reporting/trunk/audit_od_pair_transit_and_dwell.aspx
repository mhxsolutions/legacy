<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Audit OD Pair Transit and Dwell</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Audit OD Pair Planned Transit and Dwell</h3>
	<p><a href="default.aspx">home</a>&nbsp;&nbsp;&nbsp; <a href="rick2.html">
	back</a></p>
	<table style="width: 100%">
		<tr>
			<td style="width: 155px">
	<p>Fleet:
	<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="Fleet" DataTextField="Fleet" DataValueField="Fleet">
	</asp:DropDownList>
	<asp:SqlDataSource ID="Fleet" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Fleet] FROM [Audit Booked OD Pair transit and dwell] ORDER BY [Fleet]">
	</asp:SqlDataSource>
	</p>
			</td>
			<td style="width: 153px">
	<p>Year:
	<asp:DropDownList id="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="Year" DataTextField="Year" DataValueField="Year">
	</asp:DropDownList>
	<asp:SqlDataSource ID="Year" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Year] FROM [Audit Booked OD Pair transit and dwell] WHERE ([Fleet] = @Fleet) ORDER BY [Year] DESC">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Fleet" PropertyName="SelectedValue" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	</p>
			</td>
			<td>
	<p>Month:
	<asp:DropDownList id="DropDownList3" runat="server" AutoPostBack="True" DataSourceID="Month" DataTextField="Month" DataValueField="Month">
	</asp:DropDownList>
	<asp:SqlDataSource ID="Month" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Month] FROM [Audit Booked OD Pair transit and dwell] WHERE (([Fleet] = @Fleet) AND ([Year] = @Year)) ORDER BY [Month] DESC">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Fleet" PropertyName="SelectedValue" Type="String" />
			<asp:controlparameter ControlID="DropDownList2" Name="Year" PropertyName="SelectedValue" Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
	</p>
			</td>
		</tr>
	</table>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Origin" HeaderText="Origin" SortExpression="Origin">
			</asp:boundfield>
			<asp:boundfield DataField="Destination" HeaderText="Destination" SortExpression="Destination">
			</asp:boundfield>
			<asp:boundfield DataField="Avg_Transit" HeaderText="Avg_Transit" SortExpression="Avg_Transit">
			</asp:boundfield>
			<asp:boundfield DataField="Avg_Dwell" HeaderText="Avg_Dwell" SortExpression="Avg_Dwell">
			</asp:boundfield>
			<asp:boundfield DataField="count" HeaderText="count" SortExpression="count">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Origin], [Destination], [Avg Transit] AS Avg_Transit, [Avg Dwell] AS Avg_Dwell, [count] FROM [Audit Booked OD Pair transit and dwell] WHERE (([Fleet] = @Fleet) AND ([Year] = @Year) AND ([Month] = @Month)) ORDER BY [Origin], [Destination]">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Fleet" PropertyName="SelectedValue" Type="String" />
			<asp:controlparameter ControlID="DropDownList2" Name="Year" PropertyName="SelectedValue" Type="Int32" />
			<asp:controlparameter ControlID="DropDownList3" Name="Month" PropertyName="SelectedValue" Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
</form>
<p>This report averages transit times from all hours.</p>
<p>Planned times not actual times. All OD pairs not only revenue pairs.</p>

</body>

</html>
