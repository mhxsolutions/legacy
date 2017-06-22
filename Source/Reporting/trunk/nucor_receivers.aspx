<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Nucor Receivers</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Nucor Receivers</h3>
	<table style="width: 100%">
		<tr>
			<td style="width: 230px"><strong>Start Date</strong></td>
			<td><strong>End Date</strong></td>
		</tr>
		<tr>
			<td style="width: 230px">
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
	<p>&nbsp;</p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Receiver Type" HeaderText="Type" SortExpression="Receiver Type">
			</asp:boundfield>
			<asp:boundfield DataField="Date Received" DataFormatString="{0:d}" HeaderText="Date" HtmlEncode="False" SortExpression="Date Received">
			</asp:boundfield>
			<asp:boundfield DataField="Product Profile Description" HeaderText="Profile" SortExpression="Product Profile Description">
			</asp:boundfield>
			<asp:boundfield DataField="Pounds" HeaderText="Pounds" SortExpression="Pounds" DataFormatString="{0:d0}" HtmlEncode="False">
			</asp:boundfield>
			<asp:boundfield DataField="Receiver ID" HeaderText="Receiver ID" SortExpression="Receiver ID" ReadOnly="True">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Receivers from Nucor] WHERE (([Date Received] &gt;= @Date_Received) AND ([Date Received] &lt;= @Date_Received2))">
		<SelectParameters>
			<asp:controlparameter ControlID="Calendar1" Name="Date_Received" PropertyName="SelectedDate" Type="DateTime" />
			<asp:controlparameter ControlID="Calendar2" Name="Date_Received2" PropertyName="SelectedDate" Type="DateTime" />
		</SelectParameters>
	</asp:SqlDataSource>
</form>

</body>

</html>
