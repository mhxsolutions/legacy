<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Driver Phone Time Reporting Audi</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Driver Phone Time Reporting Audit</h3>
	<p>Start/End Date</p>
	<p>
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
	</p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Fleet" HeaderText="Fleet" SortExpression="Fleet">
			</asp:boundfield>
			<asp:boundfield DataField="Plan Date" DataFormatString="{0:d}" HeaderText="Plan Date" HtmlEncode="False" SortExpression="Plan Date">
			</asp:boundfield>
			<asp:boundfield DataField="Drivers" HeaderText="Drivers" ReadOnly="True" SortExpression="Drivers">
			</asp:boundfield>
			<asp:boundfield DataField="Percent Reported" DataFormatString="{0:p}" HeaderText="Percent Reported" HtmlEncode="False" ReadOnly="True" SortExpression="Percent Reported">
			</asp:boundfield>
			<asp:checkboxfield DataField="Start Time" HeaderText="Start Time" SortExpression="Start Time">
			</asp:checkboxfield>
		</Columns>
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT        TOP (100) PERCENT dbo.[Drivers phone time audit for value summary by date and driver].[Plan Date], 
                         dbo.[Drivers phone time audit for value summary by date and driver].Fleet, dbo.[Drivers on Staff].Drivers, CONVERT(numeric, 
                         dbo.[Drivers phone time audit for value summary by date and driver].[Times Received]) / CONVERT(numeric, 
                         dbo.[Drivers phone time audit for value summary by date and driver].[Times Needed]) AS [Percent Reported], CONVERT(bit, 
                         dbo.[Drivers phone time audit for value summary by date and driver].[Start Time Good]) AS [Start Time]
FROM            dbo.[Drivers phone time audit for value summary by date and driver] INNER JOIN
                         dbo.[Drivers on Staff] ON dbo.[Drivers phone time audit for value summary by date and driver].[Driver Ref] = dbo.[Drivers on Staff].EmployeeID
WHERE        (dbo.[Drivers phone time audit for value summary by date and driver].[Plan Date] &gt;= @Plan_Date) AND 
                         (dbo.[Drivers phone time audit for value summary by date and driver].[Plan Date] &lt;= @Plan_Date2)
ORDER BY dbo.[Drivers phone time audit for value summary by date and driver].Fleet, dbo.[Drivers phone time audit for value summary by date and driver].[Plan Date], 
                         dbo.[Drivers on Staff].Drivers">
		<SelectParameters>
			<asp:controlparameter ControlID="Calendar1" Name="Plan_Date" PropertyName="SelectedDate" />
			<asp:controlparameter ControlID="Calendar2" Name="Plan_Date2" PropertyName="SelectedDate" />
		</SelectParameters>
	</asp:SqlDataSource>
	<div id="layer1" style="position: absolute; width: 100px; height: 100px; z-index: 1; left: 263px; top: 94px">
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
</form>

</body>

</html>
