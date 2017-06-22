<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Planned Rev Per Driver</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Plan Review</h3>
	<p><a href="default.aspx">home</a>&nbsp;&nbsp;&nbsp; <a href="rick2.html">
	back</a></p>
	Select a date to review.<br />
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
	<br />
&nbsp;<table style="width: 100%">
		<tr>
			<td style="width: 520px"><strong>Planned Revenue and Throughput by Day<br />
			</strong>Fleet:
	<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="Fleet" DataValueField="Fleet">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Fleet] FROM [Load Rev by driver by day DLV only no service drivers with Fleet] WHERE ([Plan Date] = @Plan_Date) ORDER BY [Fleet]">
		<SelectParameters>
			<asp:controlparameter ControlID="Calendar1" Name="Plan_Date" PropertyName="SelectedDate" Type="DateTime" />
		</SelectParameters>
	</asp:SqlDataSource>
			</td>
			<td><strong>Driver Plan Details<br />
			</strong>Driver:<strong> </strong>
			<asp:DropDownList id="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource4" DataTextField="Driver" DataValueField="Driver">
			</asp:DropDownList>
			<asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Driver] FROM [Driver Plan with Load Rev] WHERE (([Plan Date] = @Plan_Date) AND ([Fleet] = @Fleet)) ORDER BY [Driver]">
				<SelectParameters>
					<asp:controlparameter ControlID="Calendar1" Name="Plan_Date" PropertyName="SelectedDate" Type="DateTime" />
					<asp:controlparameter ControlID="DropDownList1" Name="Fleet" PropertyName="SelectedValue" Type="String" />
				</SelectParameters>
			</asp:SqlDataSource>
			</td>
		</tr>
		<tr>
			<td valign="top" style="width: 520px">
	<asp:GridView runat="server" id="GridView1" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" AllowSorting="True" GridLines="None" ForeColor="#333333" CellPadding="4">
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<RowStyle BackColor="#EFF3FB" Wrap="False" />
		<Columns>
			<asp:boundfield DataField="Driver" HeaderText="Driver" SortExpression="Driver">
			</asp:boundfield>
			<asp:boundfield DataField="Planned_Hr" HeaderText="Planned_Hr" SortExpression="Planned_Hr" DataFormatString="{0:f1}">
				<ItemStyle HorizontalAlign="Center" />
			</asp:boundfield>
			<asp:boundfield DataField="Revenue" DataFormatString="{0:c}" HeaderText="Revenue" SortExpression="Revenue">
				<ItemStyle HorizontalAlign="Right" />
			</asp:boundfield>
			<asp:boundfield DataField="Rev_per_Min" DataFormatString="{0:c}" HeaderText="Rev/Plan Min" SortExpression="Rev_per_Min" ReadOnly="True">
				<ItemStyle HorizontalAlign="Right" />
			</asp:boundfield>
			<asp:boundfield DataField="Ld_Missing_Rev" HeaderText="Missing Rev" SortExpression="Ld_Missing_Rev">
				<ItemStyle HorizontalAlign="Center" />
			</asp:boundfield>
		</Columns>
		<PagerStyle HorizontalAlign="Center" BackColor="#2461BF" ForeColor="White" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Driver], [Planned Hr] AS Planned_Hr, [Revenue], [Rev per Min] AS Rev_per_Min, [Ld Missing Rev] AS Ld_Missing_Rev FROM [Load Rev by driver by day DLV only no service drivers with Fleet] WHERE (([Plan Date] = @Plan_Date) AND ([Fleet] = @Fleet)) ORDER BY [Driver]">
		<SelectParameters>
			<asp:controlparameter ControlID="Calendar1" PropertyName="SelectedDate" Name="Plan_Date" Type="DateTime" />
			<asp:controlparameter ControlID="DropDownList1" Name="Fleet" PropertyName="SelectedValue" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
			</td>
			<td valign="top">
			<asp:GridView id="GridView2" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource3" ForeColor="#333333" GridLines="None" AllowSorting="True">
				<RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
				<Columns>
					<asp:boundfield DataField="Order" HeaderText="Order" SortExpression="Order">
					</asp:boundfield>
					<asp:boundfield DataField="Client" HeaderText="Client" ReadOnly="True" SortExpression="Client">
					</asp:boundfield>
					<asp:boundfield DataField="Dest" HeaderText="Dest" ReadOnly="True" SortExpression="Dest">
					</asp:boundfield>
					<asp:boundfield DataField="Transit" HeaderText="Transit" SortExpression="Transit">
						<ItemStyle HorizontalAlign="Center" />
					</asp:boundfield>
					<asp:boundfield DataField="Dwell" HeaderText="Dwell" SortExpression="Dwell">
						<ItemStyle HorizontalAlign="Center" />
					</asp:boundfield>
					<asp:boundfield DataField="Planner_Action" HeaderText="Action" SortExpression="Planner_Action">
					</asp:boundfield>
					<asp:boundfield DataField="Revenue" HeaderText="Revenue" SortExpression="Revenue" DataFormatString="{0:c}">
					</asp:boundfield>
				</Columns>
				<FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
				<PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
				<SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
				<HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
				<EditRowStyle BackColor="#999999" />
				<AlternatingRowStyle BackColor="White" ForeColor="#284775" />
			</asp:GridView>
			<asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Order], [Client], [Dest], [Transit], [Planner Action] AS Planner_Action, [Revenue], [Dwell] FROM [Driver Plan with Load Rev] WHERE (([Plan Date] = @Plan_Date) AND ([Driver] = @Driver) AND ([Fleet] = @Fleet)) ORDER BY [Order]">
				<SelectParameters>
					<asp:controlparameter ControlID="Calendar1" Name="Plan_Date" PropertyName="SelectedDate" Type="DateTime" />
					<asp:controlparameter ControlID="DropDownList2" Name="Driver" PropertyName="SelectedValue" Type="String" />
					<asp:controlparameter ControlID="DropDownList1" Name="Fleet" PropertyName="SelectedValue" Type="String" />
				</SelectParameters>
			</asp:SqlDataSource>
			</td>
		</tr>
		<tr>
			<td valign="top" style="width: 520px">
			&nbsp;</td>
			<td valign="top">
			<a href="audit_od_pair_transit_and_dwell.aspx">Review O/D pairs</a></td>
		</tr>
	</table>
</form>

<p>Does not include pretrip time.</p>
<p>All data based on Plan Time.</p>

</body>

</html>
