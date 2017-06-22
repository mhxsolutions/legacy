<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Driver Revenue</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Driver Revenue by Day</h3>
	<p><a href="default.aspx">home</a>&nbsp;&nbsp;&nbsp; <a href="rick2.html">
	back</a></p>
	<table style="width: 100%">
		<tr>
			<td>Date</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>
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
			<td>&nbsp;</td>
		</tr>
	</table>
	<p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Fleet" HeaderText="Fleet" SortExpression="Fleet">
			</asp:boundfield>
			<asp:boundfield DataField="Driver" HeaderText="Driver" SortExpression="Driver">
			</asp:boundfield>
			<asp:boundfield DataField="Revenue" DataFormatString="{0:c}" HeaderText="Revenue" HtmlEncode="False" SortExpression="Revenue">
			</asp:boundfield>
			<asp:boundfield DataField="Throughput" DataFormatString="{0:c}" HeaderText="Rev/Plan Min" HtmlEncode="False" ReadOnly="True" SortExpression="Throughput">
			</asp:boundfield>
			<asp:boundfield DataField="Driver_Pay" DataFormatString="{0:c}" HeaderText="Driver_Pay" HtmlEncode="False" SortExpression="Driver_Pay">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Fleet], [Driver], [Revenue], [Throughput], [Driver Pay] AS Driver_Pay FROM [Plan Time and Revenue by Driver summary] WHERE ([Plan Date] = @Plan_Date) ORDER BY [Fleet], [Driver]">
		<SelectParameters>
			<asp:controlparameter ControlID="Calendar1" Name="Plan_Date" PropertyName="SelectedDate" Type="DateTime" />
		</SelectParameters>
	</asp:SqlDataSource>
	</p>
</form>
<p>Note: This report does not calculate loads missing revenue.</p>

</body>

</html>
