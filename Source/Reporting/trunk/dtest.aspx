<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Drivers' Loads Review</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Drivers' Loads Review</h3>
	<table style="width: 100%">
		<tr>
			<td style="width: 260px">Start Date</td>
			<td>End Date</td>
		</tr>
		<tr>
			<td style="width: 260px">
			<asp:Calendar id="Calendar1" runat="server" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" Width="220px">
				<DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
				<NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
				<OtherMonthDayStyle ForeColor="#999999" />
				<SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
				<SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
				<TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
				<TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
				<WeekendDayStyle BackColor="#CCCCFF" />
			</asp:Calendar>
			</td>
			<td>
			<asp:Calendar id="Calendar2" runat="server" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" Width="220px">
				<DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
				<NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
				<OtherMonthDayStyle ForeColor="#999999" />
				<SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
				<SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
				<TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
				<TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
				<WeekendDayStyle BackColor="#CCCCFF" />
			</asp:Calendar>
			</td>
		</tr>
	</table>
	<p>
	<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="Fleet" DataValueField="Fleet">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Fleet] FROM [Fleet] ORDER BY [Fleet]">
	</asp:SqlDataSource>
	</p>
	<p>
	<asp:GridView id="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" AllowSorting="True" CellPadding="4" ForeColor="#333333" GridLines="None">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Plan_Date" HeaderText="Plan_Date" SortExpression="Plan_Date">
			</asp:boundfield>
			<asp:BoundField DataField="Driver" HeaderText="Driver" SortExpression="Driver">
			</asp:BoundField>
			<asp:BoundField DataField="Order" HeaderText="Order" SortExpression="Order">
			</asp:BoundField>
			<asp:BoundField DataField="Destination" HeaderText="Destination" SortExpression="Destination">
			</asp:BoundField>
			<asp:BoundField DataField="Load_Ref" HeaderText="Load_Ref" SortExpression="Load_Ref">
			</asp:BoundField>
		</Columns>
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Fleet], [Driver], [Order], [Destination], [Load Ref] AS Load_Ref, [Plan Date] AS Plan_Date FROM [Planned loads by fleet and driver for today] WHERE (([Fleet] = @Fleet) AND ([control date] &gt;= @control_date) AND ([control date] &lt;= @control_date2)) ORDER BY [Driver], [control date], [Order]">
		<SelectParameters>
			<asp:ControlParameter ControlID="DropDownList1" Name="Fleet" PropertyName="SelectedValue" Type="String" />
			<asp:controlparameter ControlID="Calendar1" Name="control_date" PropertyName="SelectedDate" Type="DateTime" />
			<asp:controlparameter ControlID="Calendar2" Name="control_date2" PropertyName="SelectedDate" Type="DateTime" />
		</SelectParameters>
	</asp:SqlDataSource>
	</p>
</form>

</body>

</html>
