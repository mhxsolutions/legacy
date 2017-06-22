<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Load to RFS Invoice xref</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Load to RFS Invoice xref</h3>
	<p>Start Date:</p>
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
	<p>Client Filter
	<asp:DropDownList id="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource3" DataTextField="Client" DataValueField="Client">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Client] FROM [RFS Load to Invoice xref] ORDER BY [Client]">
	</asp:SqlDataSource>
	</p>
	<h3>&nbsp;</h3>
	<p>
	<asp:GridView id="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="RFS Invoice Id" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" PageSize="100">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Invoice Date" DataFormatString="{0:d}" HeaderText="Invoice Date" HtmlEncode="False" SortExpression="Invoice Date">
			</asp:boundfield>
			<asp:boundfield DataField="Load" HeaderText="Load" SortExpression="Load">
			</asp:boundfield>
			<asp:boundfield DataField="RFS Invoice Id" HeaderText="RFS Invoice Id" ReadOnly="True" SortExpression="RFS Invoice Id">
			</asp:boundfield>
			<asp:boundfield DataField="Client" HeaderText="Client" SortExpression="Client">
			</asp:boundfield>
			<asp:boundfield DataField="BOL" HeaderText="BOL" SortExpression="BOL">
			</asp:boundfield>
			<asp:boundfield DataField="Item Total" DataFormatString="{0:c}" HeaderText="Invoice Total" HtmlEncode="False" SortExpression="Item Total">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [RFS Load to Invoice xref] WHERE (([Client] = @Client) AND ([Invoice Date] &gt;= @Invoice_Date)) ORDER BY [Invoice Date], [Load]">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList2" Name="Client" PropertyName="SelectedValue" Type="String" />
			<asp:controlparameter ControlID="Calendar1" Name="Invoice_Date" PropertyName="SelectedDate" Type="DateTime" />
		</SelectParameters>
	</asp:SqlDataSource>
	</p>
</form>

</body>

</html>
