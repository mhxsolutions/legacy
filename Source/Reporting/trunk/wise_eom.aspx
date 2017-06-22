<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Wise EOM</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Wise EOM</h3>
	<p>
	<a href="wise_rail_and_returns.aspx">Rail Matrix</a></p>
	<p>
	Select Start Date:</p>
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
	<p>
	Select Location
	<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="Location" DataValueField="Location">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Location] FROM [Wise EOM matrix] ORDER BY [Location]">
	</asp:SqlDataSource>
	</p>
	<p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Plan Date" DataFormatString="{0:d}" HeaderText="Plan Date" HtmlEncode="False" SortExpression="Plan Date">
			</asp:boundfield>
			<asp:boundfield DataField="Location" HeaderText="Location" SortExpression="Location">
			</asp:boundfield>
			<asp:boundfield DataField="Gage-Width" HeaderText="Gage-Width" SortExpression="Gage-Width">
			</asp:boundfield>
			<asp:boundfield DataField="BOL to Whse" HeaderText="BOL to Whse" SortExpression="BOL to Whse">
			</asp:boundfield>
			<asp:boundfield DataField="BOL to Plant" HeaderText="BOL to Plant" SortExpression="BOL to Plant">
			</asp:boundfield>
			<asp:boundfield DataField="Coil#" HeaderText="Coil#" SortExpression="Coil#">
			</asp:boundfield>
			<asp:boundfield DataField="Weight" HeaderText="Weight" SortExpression="Weight">
			</asp:boundfield>
			<asp:boundfield DataField="Transfer to Whse" DataFormatString="{0:c}" HeaderText="Transfer to Whse" HtmlEncode="False" ReadOnly="True" SortExpression="Transfer to Whse">
			</asp:boundfield>
			<asp:boundfield DataField="Transload Fee" DataFormatString="{0:c}" HeaderText="Transload Fee" HtmlEncode="False" ReadOnly="True" SortExpression="Transload Fee">
			</asp:boundfield>
			<asp:boundfield DataField="Storage Fee" DataFormatString="{0:c}" HeaderText="Storage Fee" HtmlEncode="False" ReadOnly="True" SortExpression="Storage Fee">
			</asp:boundfield>
			<asp:boundfield DataField="Transfer to Plant" DataFormatString="{0:c}" HeaderText="Transfer to Plant" HtmlEncode="False" ReadOnly="True" SortExpression="Transfer to Plant">
			</asp:boundfield>
			<asp:boundfield DataField="Load to Budway" HeaderText="Load to Budway" HtmlEncode="False" SortExpression="Load to Budway">
			</asp:boundfield>
			<asp:boundfield DataField="Receiver ID" HeaderText="Receiver ID" SortExpression="Receiver ID">
			</asp:boundfield>
			<asp:boundfield DataField="Load to Plant" HeaderText="Load to Plant" SortExpression="Load to Plant">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Wise EOM matrix] WHERE (([Location] = @Location) AND ([Plan Date] &gt;= @Plan_Date))">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Location" PropertyName="SelectedValue" Type="String" />
			<asp:controlparameter ControlID="Calendar1" Name="Plan_Date" PropertyName="SelectedDate" Type="DateTime" />
		</SelectParameters>
	</asp:SqlDataSource>
	</p>
</form>

</body>

</html>
