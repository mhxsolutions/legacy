<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Wise Rail and Returns</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Wise Rail and Returns</h3>
	<p><a href="wise_eom.aspx">Load Matrix</a></p>
	<p>Select Start Date:</p>
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
	<p>Select Location:
	<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="Location" DataValueField="Location">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Location] FROM [Wise matrix for rail shipments] ORDER BY [Location]">
	</asp:SqlDataSource>
	</p>
	<p>
	<asp:GridView id="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None" PageSize="100">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Plan Date" DataFormatString="{0:d}" HeaderText="Plan Date" HtmlEncode="False" SortExpression="Plan Date">
			</asp:boundfield>
			<asp:boundfield DataField="Location" HeaderText="Location" SortExpression="Location">
			</asp:boundfield>
			<asp:boundfield DataField="Release Number" HeaderText="Release Number" SortExpression="Release Number">
			</asp:boundfield>
			<asp:boundfield DataField="Type" HeaderText="Type" SortExpression="Type">
			</asp:boundfield>
			<asp:boundfield DataField="Item ID" HeaderText="Item ID" SortExpression="Item ID">
			</asp:boundfield>
			<asp:boundfield DataField="Weight" HeaderText="Weight" SortExpression="Weight">
			</asp:boundfield>
			<asp:boundfield DataField="Transfer from Plant" DataFormatString="{0:c}" HeaderText="Transfer from Plant" HtmlEncode="False" ReadOnly="True" SortExpression="Transfer from Plant">
				<ItemStyle HorizontalAlign="Right" />
			</asp:boundfield>
			<asp:boundfield DataField="Rail Transload Fee" DataFormatString="{0:c}" HeaderText="Rail Transload Fee" HtmlEncode="False" ReadOnly="True" SortExpression="Rail Transload Fee">
				<ItemStyle HorizontalAlign="Right" />
			</asp:boundfield>
			<asp:boundfield DataField="Railroad Fee" DataFormatString="{0:c}" HeaderText="Railroad Fee" HtmlEncode="False" SortExpression="Railroad Fee">
				<ItemStyle HorizontalAlign="Right" />
			</asp:boundfield>
			<asp:boundfield DataField="Budway Load in" HeaderText="Budway Load in" SortExpression="Budway Load in">
				<ItemStyle HorizontalAlign="Right" />
			</asp:boundfield>
			<asp:boundfield DataField="Budway Receiver" HeaderText="Budway Receiver" SortExpression="Budway Receiver">
				<ItemStyle HorizontalAlign="Right" />
			</asp:boundfield>
			<asp:boundfield DataField="Budway BOL" HeaderText="Budway BOL" SortExpression="Budway BOL">
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
	<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Wise matrix for rail shipments] WHERE (([Plan Date] &gt;= @Plan_Date) AND ([Location] = @Location)) ORDER BY [Plan Date], [Release Number]">
		<SelectParameters>
			<asp:controlparameter ControlID="Calendar1" Name="Plan_Date" PropertyName="SelectedDate" Type="DateTime" />
			<asp:controlparameter ControlID="DropDownList1" Name="Location" PropertyName="SelectedValue" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	</p>
</form>

</body>

</html>
