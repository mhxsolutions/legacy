<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Evaluate Planed Revenue</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Evaluate Planned Revenue</h3>
	<asp:Calendar runat="server" id="Calendar1" BorderColor="#3366CC" CellPadding="1" Width="220px" BorderWidth="1px" Height="200px" BackColor="White" Font-Names="Verdana" Font-Size="8pt" DayNameFormat="Shortest" ForeColor="#003399">
		<SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
		<SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
		<WeekendDayStyle BackColor="#CCCCFF" />
		<TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
		<OtherMonthDayStyle ForeColor="#999999" />
		<NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
		<DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
		<TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
	</asp:Calendar>
	<p>&nbsp;</p>
	<asp:DropDownList runat="server" id="DropDownList1" DataTextField="Destination" DataSourceID="SqlDataSource1" DataValueField="Destination" AutoPostBack="True">
	</asp:DropDownList>
	<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Destination] FROM [Plan Time and Revenue by Driver by Load] WHERE ([Plan Date] = @Plan_Date) ORDER BY [Destination]">
		<SelectParameters>
			<asp:controlparameter ControlID="Calendar1" PropertyName="SelectedDate" Name="Plan_Date" Type="DateTime" />
		</SelectParameters>
	</asp:SqlDataSource>
	<p>&nbsp;</p>
	<asp:GridView runat="server" id="GridView1" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" DataKeyNames="Load" GridLines="None" ForeColor="#333333" CellPadding="4" AllowSorting="True">
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Drivers" HeaderText="Drivers" ReadOnly="True" SortExpression="Drivers">
			</asp:boundfield>
			<asp:boundfield DataField="Load" HeaderText="Load" ReadOnly="True" SortExpression="Load">
			</asp:boundfield>
			<asp:boundfield DataField="FSC_Rev" DataFormatString="{0:c}" HeaderText="FSC_Rev" HtmlEncode="False" SortExpression="FSC_Rev">
			</asp:boundfield>
			<asp:boundfield DataField="Man_Rev" DataFormatString="{0:c}" HeaderText="Man_Rev" HtmlEncode="False" SortExpression="Man_Rev">
			</asp:boundfield>
			<asp:boundfield DataField="Plan_Transit_Minutes" HeaderText="Plan Transit" SortExpression="Plan_Transit_Minutes">
			</asp:boundfield>
			<asp:boundfield DataField="Plan_Dwell_Minutes" HeaderText="Plan Dwell" SortExpression="Plan_Dwell_Minutes">
			</asp:boundfield>
			<asp:boundfield DataField="column1" DataFormatString="{0:c}" HeaderText="Rev per Min" HtmlEncode="False" ReadOnly="True" SortExpression="Drivers">
			</asp:boundfield>
		</Columns>
		<PagerStyle HorizontalAlign="Center" BackColor="#2461BF" ForeColor="White" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Drivers], [Load], [FSC Rev] AS FSC_Rev, [Man Rev] AS Man_Rev, [Plan Transit Minutes] AS Plan_Transit_Minutes, [Plan Dwell Minutes] AS Plan_Dwell_Minutes, [Rev/Min] AS column1 FROM [Plan Time and Revenue by Driver by Load] WHERE (([Plan Date] = @Plan_Date) AND ([Destination] = @Destination)) ORDER BY [Drivers]">
		<SelectParameters>
			<asp:controlparameter ControlID="Calendar1" PropertyName="SelectedDate" Name="Plan_Date" Type="DateTime" />
			<asp:controlparameter ControlID="DropDownList1" PropertyName="SelectedValue" Name="Destination" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
</form>

</body>

</html>
