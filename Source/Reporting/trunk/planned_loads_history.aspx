<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Planned Loads History</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Planned Loads History</h3>
	<table style="width: 100%">
		<tr>
			<td><strong>Plan Date</strong></td>
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
		<tr>
			<td><strong>Fleet</strong>:
			<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="Fleet" DataValueField="Fleet">
			</asp:DropDownList>
			<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Fleet] FROM [Planned Loads by Fleet and Driver] WHERE ([Plan Date] = @Plan_Date) ORDER BY [Fleet]">
				<SelectParameters>
					<asp:controlparameter ControlID="Calendar1" Name="Plan_Date" PropertyName="SelectedDate" Type="DateTime" />
				</SelectParameters>
			</asp:SqlDataSource>
			</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
	</table>
	<p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Driver" HeaderText="Driver" SortExpression="Driver">
			</asp:boundfield>
			<asp:boundfield DataField="Destination" HeaderText="Destination" SortExpression="Destination">
			</asp:boundfield>
			<asp:boundfield DataField="Sch_Arrive" DataFormatString="{0:t}" HeaderText="Sch_Arrive" HtmlEncode="False" SortExpression="Sch_Arrive">
			</asp:boundfield>
			<asp:boundfield DataField="Load_Ref" HeaderText="Load_Ref" SortExpression="Load_Ref">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Driver], [Destination], [Sch Arrive] AS Sch_Arrive, [Load Ref] AS Load_Ref FROM [Planned Loads by Fleet and Driver] WHERE (([Plan Date] = @Plan_Date) AND ([Fleet] = @Fleet)) ORDER BY [Driver], [Order]">
		<SelectParameters>
			<asp:controlparameter ControlID="Calendar1" Name="Plan_Date" PropertyName="SelectedDate" Type="String" />
			<asp:controlparameter ControlID="DropDownList1" Name="Fleet" PropertyName="SelectedValue" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	</p>
</form>

</body>

</html>
