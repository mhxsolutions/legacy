<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Drivers Hours of Service</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Drivers Hours of Service</h3>
	<table style="width: 32%">
		<tr>
			<td style="width: 69px"><strong>Year</strong></td>
			<td style="width: 117px"><strong>Week</strong></td>
			<td style="width: 134px"><strong>Fleet</strong></td>
		</tr>
		<tr>
			<td style="width: 69px">
			<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="year" DataTextField="Year" DataValueField="Year">
			</asp:DropDownList>
			<asp:SqlDataSource ID="year" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Year] FROM [Driver hours of service - hours for week] ORDER BY [Year] DESC">
			</asp:SqlDataSource>
			</td>
			<td style="width: 117px">
			<asp:DropDownList id="DropDownList3" runat="server" AutoPostBack="True" DataSourceID="week" DataTextField="Week" DataValueField="Week">
			</asp:DropDownList>
			<asp:SqlDataSource ID="week" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Week] FROM [Driver hours of service - hours for week] WHERE ([Year] = @Year) ORDER BY [Week] DESC">
				<SelectParameters>
					<asp:controlparameter ControlID="DropDownList1" Name="Year" PropertyName="SelectedValue" Type="Int32" />
				</SelectParameters>
			</asp:SqlDataSource>
			</td>
			<td style="width: 134px">
			<asp:DropDownList id="DropDownList4" runat="server" AutoPostBack="True" DataSourceID="fleet" DataTextField="Fleet" DataValueField="Fleet">
			</asp:DropDownList>
			<asp:SqlDataSource ID="fleet" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Fleet] FROM [Driver hours of service - hours for week] WHERE (([Year] = @Year) AND ([Week] = @Week)) ORDER BY [Fleet]">
				<SelectParameters>
					<asp:controlparameter ControlID="DropDownList1" Name="Year" PropertyName="SelectedValue" Type="Int32" />
					<asp:controlparameter ControlID="DropDownList3" Name="Week" PropertyName="SelectedValue" Type="Int32" />
				</SelectParameters>
			</asp:SqlDataSource>
			</td>
		</tr>
	</table>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Driver" HeaderText="Driver" SortExpression="Driver">
			</asp:boundfield>
			<asp:boundfield DataField="Count_of_Days" HeaderText="Count_of_Days" SortExpression="Count_of_Days">
				<ItemStyle HorizontalAlign="Center" />
			</asp:boundfield>
			<asp:boundfield DataField="Hours_of_Service" DataFormatString="{0:f1}" HeaderText="Hours_of_Service" SortExpression="Hours_of_Service">
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
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Driver], [Count of Days] AS Count_of_Days, [Hours of Service] AS Hours_of_Service FROM [Driver hours of service - hours for week] WHERE (([Year] = @Year) AND ([Week] = @Week) AND ([Fleet] = @Fleet))">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Year" PropertyName="SelectedValue" Type="Int32" />
			<asp:controlparameter ControlID="DropDownList3" Name="Week" PropertyName="SelectedValue" Type="Int32" />
			<asp:controlparameter ControlID="DropDownList4" Name="Fleet" PropertyName="SelectedValue" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
</form>

</body>

</html>
