<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Planned Driver Revenue Detail</title>
</head>

<body>

<form id="form1" runat="server">
	<p>Select a date to review.</p>
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
	<p>Select a driver to review</p>
	<p>
	<asp:DropDownList runat="server" id="DropDownList1" DataTextField="Driver" DataSourceID="SqlDataSource1" DataValueField="Driver" AutoPostBack="True">
	</asp:DropDownList>
	<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Driver] FROM [Load Rev by Driver by day with detail] WHERE ([Plan Date] = @Plan_Date)">
		<SelectParameters>
			<asp:controlparameter ControlID="Calendar1" PropertyName="SelectedDate" Name="Plan_Date" Type="DateTime" />
		</SelectParameters>
	</asp:SqlDataSource>
	</p>
	<h3>Planned Revenue for Driver</h3>
	<asp:GridView runat="server" id="GridView1" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" GridLines="None" ForeColor="#333333" CellPadding="4" AllowSorting="True">
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Plan Date" DataFormatString="{0:d}" HeaderText="Plan Date" HtmlEncode="False" SortExpression="Plan Date">
			</asp:boundfield>
			<asp:boundfield DataField="Driver" HeaderText="Driver" ReadOnly="True" SortExpression="Driver">
			</asp:boundfield>
			<asp:boundfield DataField="Order" HeaderText="Order" SortExpression="Order">
			</asp:boundfield>
			<asp:boundfield DataField="Client" HeaderText="Client" ReadOnly="True" SortExpression="Client">
			</asp:boundfield>
			<asp:boundfield DataField="Dest" HeaderText="Dest" ReadOnly="True" SortExpression="Dest">
			</asp:boundfield>
			<asp:boundfield DataField="Planner Action" HeaderText="Planner Action" SortExpression="Planner Action">
			</asp:boundfield>
			<asp:boundfield DataField="Revenue" DataFormatString="{0:c}" HeaderText="Revenue" HtmlEncode="False" ReadOnly="True" SortExpression="Revenue">
			</asp:boundfield>
		</Columns>
		<PagerStyle HorizontalAlign="Center" BackColor="#2461BF" ForeColor="White" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Load Rev by Driver by day with detail] WHERE (([Driver] = @Driver) AND ([Plan Date] = @Plan_Date))">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" PropertyName="SelectedValue" Name="Driver" Type="String" />
			<asp:controlparameter ControlID="Calendar1" PropertyName="SelectedDate" Name="Plan_Date" Type="DateTime" />
		</SelectParameters>
	</asp:SqlDataSource>
</form>

</body>

</html>
