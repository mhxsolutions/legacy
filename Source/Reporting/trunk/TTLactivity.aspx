<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>TTL Activity</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>TTL Activity</h3>
	<table style="width: 100%">
		<tr>
			<td style="width: 252px">Start Date</td>
			<td>End Date</td>
		</tr>
		<tr>
			<td style="width: 252px">
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
	<p>&nbsp;</p>
	<table style="width: 100%">
		<tr>
			<td>Receivers</td>
			<td>BOLs</td>
		</tr>
		<tr>
			<td valign="top">
			<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SqlDataSource1" GridLines="Horizontal">
				<RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
				<Columns>
					<asp:boundfield DataField="Client" HeaderText="Client" ReadOnly="True" SortExpression="Client">
					</asp:boundfield>
					<asp:boundfield DataField="Date Received" DataFormatString="{0:d}" HeaderText="Date Received" SortExpression="Date Received">
					</asp:boundfield>
					<asp:boundfield DataField="Receiver ID" HeaderText="Receiver ID" SortExpression="Receiver ID">
					</asp:boundfield>
					<asp:boundfield DataField="Receiver Type" HeaderText="Receiver Type" SortExpression="Receiver Type">
					</asp:boundfield>
					<asp:boundfield DataField="RFS ID" HeaderText="RFS ID" SortExpression="RFS ID">
					</asp:boundfield>
					<asp:boundfield DataField="Work Description" HeaderText="Work Description" SortExpression="Work Description">
					</asp:boundfield>
					<asp:boundfield DataField="Wt" DataFormatString="{0:n0}" HeaderText="Wt" SortExpression="Wt">
					</asp:boundfield>
				</Columns>
				<FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
				<PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
				<SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
				<HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
				<AlternatingRowStyle BackColor="#F7F7F7" />
			</asp:GridView>
			<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [TTL receivers with RFS ref] WHERE (([Date Received] &gt;= @Date_Received) AND ([Date Received] &lt;= @Date_Received2)) ORDER BY [Client], [Receiver ID]">
				<SelectParameters>
					<asp:controlparameter ControlID="Calendar1" Name="Date_Received" PropertyName="SelectedDate" Type="DateTime" />
					<asp:controlparameter ControlID="Calendar2" Name="Date_Received2" PropertyName="SelectedDate" Type="DateTime" />
				</SelectParameters>
			</asp:SqlDataSource>
			</td>
			<td valign="top">
			<asp:GridView id="GridView2" runat="server" AllowSorting="True" AutoGenerateColumns="False" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" DataSourceID="SqlDataSource2" ForeColor="Black" GridLines="None">
				<Columns>
					<asp:boundfield DataField="Client" HeaderText="Client" ReadOnly="True" SortExpression="Client">
					</asp:boundfield>
					<asp:boundfield DataField="Shipment Date" DataFormatString="{0:d}" HeaderText="Shipment Date" SortExpression="Shipment Date">
					</asp:boundfield>
					<asp:boundfield DataField="Load ID" HeaderText="Load ID" SortExpression="Load ID">
					</asp:boundfield>
					<asp:boundfield DataField="Load Type" HeaderText="Load Type" SortExpression="Load Type">
					</asp:boundfield>
					<asp:boundfield DataField="RFS ID" HeaderText="RFS ID" SortExpression="RFS ID">
					</asp:boundfield>
					<asp:boundfield DataField="Work Description" HeaderText="Work Description" SortExpression="Work Description">
					</asp:boundfield>
					<asp:boundfield DataField="Wt" DataFormatString="{0:n0}" HeaderText="Wt" SortExpression="Wt">
					</asp:boundfield>
				</Columns>
				<FooterStyle BackColor="Tan" />
				<PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
				<SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
				<HeaderStyle BackColor="Tan" Font-Bold="True" />
				<AlternatingRowStyle BackColor="PaleGoldenrod" />
			</asp:GridView>
			<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [TTL BOLs with RFS ref] WHERE (([Shipment Date] &gt;= @Shipment_Date) AND ([Shipment Date] &lt;= @Shipment_Date2)) ORDER BY [Client], [Load ID]">
				<SelectParameters>
					<asp:controlparameter ControlID="Calendar1" Name="Shipment_Date" PropertyName="SelectedDate" Type="DateTime" />
					<asp:controlparameter ControlID="Calendar2" Name="Shipment_Date2" PropertyName="SelectedDate" Type="DateTime" />
				</SelectParameters>
			</asp:SqlDataSource>
			</td>
		</tr>
	</table>
</form>

</body>

</html>
