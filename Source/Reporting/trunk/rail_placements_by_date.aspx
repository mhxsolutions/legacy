<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Rail Placements by Date</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Rail Placements by Date</h3>
	<p>&nbsp;</p>
	<p>&nbsp;</p>
	<p>&nbsp;</p>
	<p>&nbsp;</p>
	<p>&nbsp;</p>
	<p>&nbsp;</p>
	<p>&nbsp;</p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Client" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="PL Date" DataFormatString="{0:d}" HeaderText="PL Date" HtmlEncode="False" SortExpression="PL Date">
			</asp:boundfield>
			<asp:boundfield DataField="Terminal" HeaderText="Terminal" SortExpression="Terminal">
			</asp:boundfield>
			<asp:boundfield DataField="Client" HeaderText="Client" ReadOnly="True" SortExpression="Client">
			</asp:boundfield>
			<asp:boundfield DataField="Product Type" HeaderText="Product Type" SortExpression="Product Type">
			</asp:boundfield>
			<asp:boundfield DataField="Count" HeaderText="Count" SortExpression="Count">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Railcars by placement date] WHERE (([PL Date] &gt;= @PL_Date) AND ([PL Date] &lt;= @PL_Date2)) ORDER BY [PL Date], [Terminal], [Client]">
		<SelectParameters>
			<asp:controlparameter ControlID="Calendar1" Name="PL_Date" PropertyName="SelectedDate" Type="DateTime" />
			<asp:controlparameter ControlID="Calendar2" Name="PL_Date2" PropertyName="SelectedDate" Type="DateTime" />
		</SelectParameters>
	</asp:SqlDataSource>
	<div id="layer1" style="position: absolute; width: 230px; height: 234px; z-index: 1; left: 23px; top: 65px">
		Start Date<asp:Calendar id="Calendar1" runat="server" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" Width="220px">
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
	<div id="layer2" style="position: absolute; width: 232px; height: 229px; z-index: 1; left: 263px; top: 67px">
		End Date<asp:Calendar id="Calendar2" runat="server" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" Width="220px">
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
</form>

</body>

</html>
