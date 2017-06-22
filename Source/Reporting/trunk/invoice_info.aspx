<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Invoice INFO</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Invoice Info on Loads</h3>
	<p><a href="default.aspx">home</a>&nbsp;&nbsp;&nbsp; <a href="rick2.html">
	back</a></p>
	<table style="width: 100%">
		<tr>
			<td style="width: 233px"><strong>Fleet: </strong>
			<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="Fleet" DataValueField="Fleet">
			</asp:DropDownList>
			<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Fleet] FROM [RFS Invoice INFO] ORDER BY [Fleet]">
			</asp:SqlDataSource>
			</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td style="width: 233px"><strong>Start Date</strong></td>
			<td><strong>End Date</strong></td>
		</tr>
		<tr>
			<td style="width: 233px">
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
	<p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="LoadDate" DataFormatString="{0:d}" HeaderText="LoadDate" SortExpression="LoadDate">
			</asp:boundfield>
			<asp:boundfield DataField="Plan Date" DataFormatString="{0:d}" HeaderText="Plan Date" SortExpression="Plan Date">
			</asp:boundfield>
			<asp:boundfield DataField="Client Name" HeaderText="Client" SortExpression="Client Name">
			</asp:boundfield>
			<asp:boundfield DataField="Load" HeaderText="Load" SortExpression="Load">
			</asp:boundfield>
			<asp:boundfield DataField="Destination" HeaderText="Destination" SortExpression="Destination">
			</asp:boundfield>
			<asp:boundfield DataField="Item Total" DataFormatString="{0:c}" HeaderText="Item Total" SortExpression="Item Total">
			</asp:boundfield>
			<asp:boundfield DataField="Public FSC Revenue" DataFormatString="{0:c}" HeaderText="FSC portion" SortExpression="Public FSC Revenue">
			</asp:boundfield>
			<asp:boundfield DataField="RFS Invoice Id" HeaderText="Invoice" SortExpression="RFS Invoice Id">
			</asp:boundfield>
			<asp:checkboxfield DataField="Will Call" HeaderText="Will Call" SortExpression="Will Call">
			</asp:checkboxfield>
			<asp:boundfield DataField="Invoice Total" DataFormatString="{0:c}" HeaderText="Invoice Total" SortExpression="Invoice Total">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [RFS Invoice INFO] WHERE (([Fleet] = @Fleet) AND ([LoadDate] &gt;= @LoadDate) AND ([LoadDate] &lt;= @LoadDate2))">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Fleet" PropertyName="SelectedValue" Type="String" />
			<asp:controlparameter ControlID="Calendar1" Name="LoadDate" PropertyName="SelectedDate" Type="DateTime" />
			<asp:controlparameter ControlID="Calendar2" Name="LoadDate2" PropertyName="SelectedDate" Type="DateTime" />
		</SelectParameters>
	</asp:SqlDataSource>
	</p>
</form>

<p>This data is from actual INVOICES. If it has not been invoiced, no revenue 
will show. </p>
<p>This data is selected by LOAD DATE not plan date. It will not match exactly 
with monthly revenue. The load date was used to query all loads, not only those 
on the planner.</p>

</body>

</html>
