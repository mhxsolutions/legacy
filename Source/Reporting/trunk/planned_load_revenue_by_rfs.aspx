<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Planned Load Revenue by RFS</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Planned Load Revenue by RFS</h3>
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
	<div id="layer1" style="position: absolute; width: 237px; height: 195px; z-index: 1; left: 246px; top: 56px">
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
	</div>
	<p>(accurate times are only available for previous day's plans)</p>
	<p>NOTICE: this data is subject to driver phone errors and it does not 
	include pre/post trip times.</p>
	<asp:GridView runat="server" id="GridView1" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" AllowSorting="True" GridLines="None" ForeColor="#333333" CellPadding="4">
		<FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
		<RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
		<Columns>
			<asp:boundfield DataField="Plan Date" DataFormatString="{0:d}" HeaderText="Plan Date" HtmlEncode="False" SortExpression="Plan Date">
			</asp:boundfield>
			<asp:boundfield DataField="Client" HeaderText="Client" SortExpression="Client">
			</asp:boundfield>
			<asp:boundfield DataField="RFS ref" HeaderText="RFS" SortExpression="RFS ref">
			</asp:boundfield>
			<asp:boundfield DataField="Rev" DataFormatString="{0:c0}" HeaderText="Rev" HtmlEncode="False" SortExpression="Rev">
			</asp:boundfield>
			<asp:boundfield DataField="Rev/Plan Min" DataFormatString="{0:c}" HeaderText="Rev/Plan Min" HtmlEncode="False" ReadOnly="True" SortExpression="Rev/Plan Min">
			</asp:boundfield>
		</Columns>
		<PagerStyle HorizontalAlign="Center" BackColor="#FFCC66" ForeColor="#333333" />
		<SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
		<HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Load Rev Planned by RFS] WHERE (([Plan Date] &gt;= @Plan_Date) AND ([Plan Date] &lt;= @Plan_Date2))">
		<SelectParameters>
			<asp:controlparameter ControlID="Calendar1" PropertyName="SelectedDate" Name="Plan_Date" Type="DateTime" />
			<asp:controlparameter ControlID="Calendar2" Name="Plan_Date2" PropertyName="SelectedDate" Type="DateTime" />
		</SelectParameters>
	</asp:SqlDataSource>
</form>

</body>

</html>
