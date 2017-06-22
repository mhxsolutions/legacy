<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Driver Revenue by Period</title>
<style type="text/css">
.style1 {
	margin-left: 0px;
}
</style>
</head>

<body>

<form id="form1" runat="server">
	<h3>Driver Revenue by Period</h3>
	<table style="width: 100%">
		<tr>
			<td style="width: 229px"><strong>Fleet</strong></td>
			<td>
			<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="Fleet" DataValueField="Fleet">
			</asp:DropDownList>
			<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Fleet] FROM [Fleet] ORDER BY [Fleet]">
			</asp:SqlDataSource>
			</td>
		</tr>
		<tr>
			<td style="width: 229px"><strong>Start Date</strong></td>
			<td><strong>End Date</strong></td>
		</tr>
		<tr>
			<td style="width: 229px">
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
			<asp:Calendar id="Calendar2" runat="server" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" CssClass="style1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" Width="220px">
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
	<p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Week" HeaderText="Week" SortExpression="Week">
			</asp:boundfield>
			<asp:boundfield DataField="Start_Week" DataFormatString="{0:d}" HeaderText="Start_Week" HtmlEncode="False" SortExpression="Start_Week">
			</asp:boundfield>
			<asp:boundfield DataField="Driver" HeaderText="Driver" SortExpression="Driver">
			</asp:boundfield>
			<asp:boundfield DataField="Revenue" DataFormatString="{0:c}" HeaderText="Revenue" HtmlEncode="False" SortExpression="Revenue">
			</asp:boundfield>
			<asp:boundfield DataField="Throughput" DataFormatString="{0:c}" HeaderText="Throughput" HtmlEncode="False" ReadOnly="True" SortExpression="Throughput">
				<HeaderStyle HorizontalAlign="Center" />
				<ItemStyle HorizontalAlign="Center" />
			</asp:boundfield>
			<asp:boundfield DataField="Driver_Pay" DataFormatString="{0:c}" HeaderText="Driver_Pay" HtmlEncode="False" SortExpression="Driver_Pay">
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
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Week], [Start Week] AS Start_Week, [Driver], [Revenue], [Throughput], [Driver Pay] AS Driver_Pay FROM [Plan Time and Revenue by week by driver summary] WHERE (([Start Week] &gt;= @Start_Week) AND ([Start Week] &lt;= @Start_Week2) AND ([Fleet] = @Fleet)) ORDER BY [Week], [Driver]">
		<SelectParameters>
			<asp:controlparameter ControlID="Calendar1" Name="Start_Week" PropertyName="SelectedDate" Type="DateTime" />
			<asp:controlparameter ControlID="Calendar2" Name="Start_Week2" PropertyName="SelectedDate" Type="DateTime" />
			<asp:controlparameter ControlID="DropDownList1" Name="Fleet" PropertyName="SelectedValue" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	</p>
</form>
<p>Note: This report does not calculate loads missing revenue.</p>
<p>Note: This report totals all data from a week.</p>
<p>&nbsp;</p>

</body>

</html>
