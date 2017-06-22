<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Evaluate Actual Time and Revenue</title>
<style type="text/css">
.style1 {
	color: #FF0000;
}
</style>
</head>

<body>

<form id="form1" runat="server">
	<h3>Evaluate Actual Time and Revenue</h3>
	<table style="width: 100%">
		<tr>
			<td style="width: 221px"><strong>Start Date</strong></td>
			<td><strong>End Date</strong></td>
		</tr>
		<tr>
			<td style="width: 221px">
	<asp:Calendar runat="server" id="Calendar1" BorderColor="#999999" CellPadding="4" Width="200px" Height="180px" BackColor="White" Font-Names="Verdana" Font-Size="8pt" DayNameFormat="Shortest" ForeColor="Black">
		<SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
		<SelectorStyle BackColor="#CCCCCC" />
		<WeekendDayStyle BackColor="#FFFFCC" />
		<TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
		<OtherMonthDayStyle ForeColor="#808080" />
		<NextPrevStyle VerticalAlign="Bottom" />
		<DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
		<TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
	</asp:Calendar>
			</td>
			<td>
			<asp:Calendar id="Calendar2" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" Width="200px">
				<SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
				<SelectorStyle BackColor="#CCCCCC" />
				<WeekendDayStyle BackColor="#FFFFCC" />
				<TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
				<OtherMonthDayStyle ForeColor="#808080" />
				<NextPrevStyle VerticalAlign="Bottom" />
				<DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
				<TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
			</asp:Calendar>
			</td>
		</tr>
	</table>
	<p>Select Load Destination</p>
	<asp:DropDownList runat="server" id="DropDownList1" DataTextField="Destination" DataSourceID="SqlDataSource1" DataValueField="Destination" AutoPostBack="True">
	</asp:DropDownList>
	<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Destination] FROM [Actual Time and Revenue by Driver by Load] WHERE (([Plan Date] &gt;= @Plan_Date) AND ([Plan Date] &lt;= @Plan_Date2))">
		<SelectParameters>
			<asp:controlparameter ControlID="Calendar1" PropertyName="SelectedDate" Name="Plan_Date" Type="DateTime" />
			<asp:controlparameter ControlID="Calendar2" Name="Plan_Date2" PropertyName="SelectedDate" Type="DateTime" />
		</SelectParameters>
	</asp:SqlDataSource>
	<p>Actual times as reported by drivers. <span class="style1">(MAY HAVE PHONE 
	ERRORS)</span></p>
	<p>Transit includes O/D transit + redirect. Dwell includes Origin load time 
	+ Destination unload time.</p>
	<asp:GridView runat="server" id="GridView1" GridLines="None" ForeColor="#333333" CellPadding="4" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" DataKeyNames="Load" AllowSorting="True">
		<FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
		<RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
		<Columns>
			<asp:boundfield DataField="Drivers" HeaderText="Drivers" ReadOnly="True" SortExpression="Drivers">
			</asp:boundfield>
			<asp:boundfield DataField="Load" HeaderText="Load" ReadOnly="True" SortExpression="Load">
			</asp:boundfield>
			<asp:boundfield DataField="FSC_Rev" DataFormatString="{0:c}" HeaderText="FSC_Rev" HtmlEncode="False" SortExpression="FSC_Rev">
			</asp:boundfield>
			<asp:boundfield DataField="Man_Rev" DataFormatString="{0:c}" HeaderText="Man_Rev" HtmlEncode="False" SortExpression="Man_Rev">
			</asp:boundfield>
			<asp:boundfield DataField="Transit_Minutes" HeaderText="Transit" SortExpression="Transit_Minutes">
			</asp:boundfield>
			<asp:boundfield DataField="Dwell_Minutes" HeaderText="Dwell" SortExpression="Dwell_Minutes">
			</asp:boundfield>
			<asp:boundfield DataField="column1" DataFormatString="{0:c}" HeaderText="Rev per Min" HtmlEncode="False" ReadOnly="True" SortExpression="column1">
			</asp:boundfield>
			<asp:boundfield DataField="RFS_ref" HeaderText="RFS" SortExpression="RFS_ref">
			</asp:boundfield>
		</Columns>
		<PagerStyle HorizontalAlign="Center" BackColor="#FFCC66" ForeColor="#333333" />
		<SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
		<HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Drivers], [Load], [FSC Rev] AS FSC_Rev, [Man Rev] AS Man_Rev, [Transit Minutes] AS Transit_Minutes, [Dwell Minutes] AS Dwell_Minutes, [Rev/Min] AS column1, [RFS ref] AS RFS_ref FROM [Actual Time and Revenue by Driver by Load] WHERE (([Destination] = @Destination) AND ([Plan Date] &gt;= @Plan_Date) AND ([Plan Date] &lt;= @Plan_Date2))">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" PropertyName="SelectedValue" Name="Destination" Type="String" />
			<asp:controlparameter ControlID="Calendar1" PropertyName="SelectedDate" Name="Plan_Date" Type="DateTime" />
			<asp:controlparameter ControlID="Calendar2" Name="Plan_Date2" PropertyName="SelectedDate" />
		</SelectParameters>
	</asp:SqlDataSource>
</form>

</body>

</html>
