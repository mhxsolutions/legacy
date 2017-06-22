<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Drivers OD Pairs with Times</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Driver's OD pairs with times</h3>
	<table style="width: 100%">
		<tr>
			<td style="width: 262px"><strong>Start Date</strong></td>
			<td><strong>End Date</strong></td>
		</tr>
		<tr>
			<td style="width: 262px">
			<asp:Calendar id="Calendar1" runat="server" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" Width="220px">
				<SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
				<SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
				<WeekendDayStyle BackColor="#CCCCFF" />
				<TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
				<OtherMonthDayStyle ForeColor="#999999" />
				<NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
				<DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
				<TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
			</asp:Calendar>
			</td>
			<td>
			<asp:Calendar id="Calendar2" runat="server" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" Width="220px">
				<SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
				<SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
				<WeekendDayStyle BackColor="#CCCCFF" />
				<TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
				<OtherMonthDayStyle ForeColor="#999999" />
				<NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
				<DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
				<TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
			</asp:Calendar>
			</td>
		</tr>
	</table>
	<p>You may search back to 2006. DLV=deliver, MOV=empty move</p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="O Client,O City,D Client,D City" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Plan Date" DataFormatString="{0:d}" HeaderText="Plan Date" HtmlEncode="False" SortExpression="Plan Date">
			</asp:boundfield>
			<asp:boundfield DataField="Driver" HeaderText="Driver" ReadOnly="True" SortExpression="Driver">
			</asp:boundfield>
			<asp:boundfield DataField="Truck" HeaderText="Truck" SortExpression="Truck">
			</asp:boundfield>
			<asp:boundfield DataField="O Client" HeaderText="O Client" ReadOnly="True" SortExpression="O Client">
			</asp:boundfield>
			<asp:boundfield DataField="O City" HeaderText="O City" ReadOnly="True" SortExpression="O City">
			</asp:boundfield>
			<asp:boundfield DataField="D Client" HeaderText="D Client" ReadOnly="True" SortExpression="D Client">
			</asp:boundfield>
			<asp:boundfield DataField="D City" HeaderText="D City" ReadOnly="True" SortExpression="D City">
			</asp:boundfield>
			<asp:boundfield DataField="Planner Action" HeaderText="Planner Action" SortExpression="Planner Action">
			</asp:boundfield>
			<asp:boundfield DataField="Depart Origin" DataFormatString="{0:t}" HeaderText="Depart Origin" HtmlEncode="False" SortExpression="Depart Origin">
			</asp:boundfield>
			<asp:boundfield DataField="Arrive Destination" DataFormatString="{0:t}" HeaderText="Arrive Destination" HtmlEncode="False" SortExpression="Arrive Destination">
			</asp:boundfield>
			<asp:boundfield DataField="Depart Destination" DataFormatString="{0:t}" HeaderText="Depart Destination" HtmlEncode="False" SortExpression="Depart Destination">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Drivers OD pairs with times and dates] WHERE (([Plan Date] &gt;= @Plan_Date) AND ([Plan Date] &lt;= @Plan_Date2)) ORDER BY [Plan Date], [Driver], [Arrive Destination]">
		<SelectParameters>
			<asp:controlparameter ControlID="Calendar1" Name="Plan_Date" PropertyName="SelectedDate" Type="DateTime" />
			<asp:controlparameter ControlID="Calendar2" Name="Plan_Date2" PropertyName="SelectedDate" Type="DateTime" />
		</SelectParameters>
	</asp:SqlDataSource>
</form>

</body>

</html>
