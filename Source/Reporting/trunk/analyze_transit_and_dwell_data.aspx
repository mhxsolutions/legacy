<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Analyze Transit and Dwell Data</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Analyze Transit and Dwell Data - Actual Times (last 6 months)</h3>
	<div id="layer6" style="position: absolute; width: 341px; height: 15px; z-index: 6; left: 460px; top: 45px">
		Dwell Average from all Origins to this Destination.</div>
	<div id="layer1" style="position: absolute; width: 100px; height: 100px; z-index: 1">
		<asp:Calendar runat="server" id="Calendar1" BorderColor="#999999" CellPadding="4" Width="200px" Height="180px" BackColor="White" Font-Names="Verdana" Font-Size="8pt" DayNameFormat="Shortest" ForeColor="Black" Caption="Start Date">
			<SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
			<SelectorStyle BackColor="#CCCCCC" />
			<WeekendDayStyle BackColor="#FFFFCC" />
			<TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
			<OtherMonthDayStyle ForeColor="#808080" />
			<NextPrevStyle VerticalAlign="Bottom" />
			<DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
			<TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
		</asp:Calendar>
	</div>
	<div style="position: absolute; width: 100px; height: 100px; z-index: 2; left: 222px; top: 54px" id="layer2">
		<asp:Calendar runat="server" id="Calendar2" Width="200px" Height="180px" BorderColor="#999999" CellPadding="4" BackColor="White" Font-Names="Verdana" Font-Size="8pt" DayNameFormat="Shortest" ForeColor="Black" Caption="End Date">
			<SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
			<SelectorStyle BackColor="#CCCCCC" />
			<WeekendDayStyle BackColor="#FFFFCC" />
			<TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
			<OtherMonthDayStyle ForeColor="#808080" />
			<NextPrevStyle VerticalAlign="Bottom" />
			<DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
			<TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
		</asp:Calendar>
	</div>
	<div style="position: absolute; width: 413px; height: 87px; z-index: 3; left: 10px; top: 284px" id="layer3">
		<strong>(1) Destination :</strong>
		<asp:DropDownList runat="server" id="DropDownList2" DataTextField="Destination" DataSourceID="SqlDataSource2" DataValueField="Destination" AutoPostBack="True">
		</asp:DropDownList>
		<asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Destination] FROM [Agilis Work order Progression INFO] WHERE (([Plan Date] &gt;= @Plan_Date) AND ([Plan Date] &lt;= @Plan_Date2)) ORDER BY [Destination]">
			<SelectParameters>
				<asp:controlparameter ControlID="Calendar1" PropertyName="SelectedDate" Name="Plan_Date" Type="DateTime" />
				<asp:controlparameter ControlID="Calendar2" PropertyName="SelectedDate" Name="Plan_Date2" Type="DateTime" />
			</SelectParameters>
		</asp:SqlDataSource>
		<br />
		(2) Origin:
		<asp:DropDownList runat="server" id="DropDownList1" DataTextField="Origin" DataSourceID="SqlDataSource1" DataValueField="Origin" AutoPostBack="True">
		</asp:DropDownList>
		<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Origin] FROM [Agilis Work order Progression INFO] WHERE (([Plan Date] &gt;= @Plan_Date) AND ([Plan Date] &lt;= @Plan_Date2 AND [Destination]=@dest)) ORDER BY [Origin]">
			<SelectParameters>
				<asp:controlparameter ControlID="Calendar1" PropertyName="SelectedDate" Name="Plan_Date" Type="DateTime" />
				<asp:controlparameter ControlID="Calendar2" PropertyName="SelectedDate" Name="Plan_Date2" Type="DateTime" />
				<asp:controlparameter ControlID="DropDownList2" Name="dest" PropertyName="SelectedValue" />
			</SelectParameters>
		</asp:SqlDataSource>
		<br />
	</div>
	<div style="position: absolute; width: 776px; height: 306px; z-index: 4; left: 14px; top: 427px" id="layer4">
		<asp:GridView runat="server" id="GridView1" GridLines="None" ForeColor="#333333" CellPadding="4" DataSourceID="SqlDataSource3" AutoGenerateColumns="False" AllowSorting="True">
			<FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
			<RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
			<Columns>
				<asp:boundfield DataField="Plan_Date" DataFormatString="{0:d}" HeaderText="Plan_Date" HtmlEncode="False" SortExpression="Plan_Date">
				</asp:boundfield>
				<asp:boundfield DataField="Driver" HeaderText="Driver" ReadOnly="True" SortExpression="Driver">
				</asp:boundfield>
				<asp:boundfield DataField="Origin" HeaderText="Origin" ReadOnly="True" SortExpression="Origin">
				</asp:boundfield>
				<asp:boundfield DataField="Destination" HeaderText="Destination" ReadOnly="True" SortExpression="Destination">
				</asp:boundfield>
				<asp:boundfield DataField="Transit" HeaderText="Transit" ReadOnly="True" SortExpression="Transit">
				</asp:boundfield>
				<asp:boundfield DataField="Dwell" HeaderText="Dwell" ReadOnly="True" SortExpression="Dwell">
				</asp:boundfield>
			</Columns>
			<PagerStyle HorizontalAlign="Center" BackColor="#FFCC66" ForeColor="#333333" />
			<SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
			<HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
			<AlternatingRowStyle BackColor="White" />
		</asp:GridView>
		<asp:SqlDataSource runat="server" ID="SqlDataSource3" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Plan Date] AS Plan_Date, [Driver], [Origin], [Destination], [Transit], [Dwell] FROM [Agilis Work order Progression INFO] WHERE (([Plan Date] &gt;= @Plan_Date) AND ([Plan Date] &lt;= @Plan_Date2) AND ([Origin] = @Origin) AND ([Destination] = @Destination))">
			<SelectParameters>
				<asp:controlparameter ControlID="Calendar1" PropertyName="SelectedDate" Name="Plan_Date" Type="DateTime" />
				<asp:controlparameter ControlID="Calendar2" PropertyName="SelectedDate" Name="Plan_Date2" Type="DateTime" />
				<asp:controlparameter ControlID="DropDownList1" PropertyName="SelectedValue" Name="Origin" Type="String" />
				<asp:controlparameter ControlID="DropDownList2" PropertyName="SelectedValue" Name="Destination" Type="String" />
			</SelectParameters>
		</asp:SqlDataSource>
	</div>
	<div id="layer5" style="position: absolute; width: 326px; height: 320px; z-index: 5; left: 459px; top: 73px">
		<asp:GridView id="GridView2" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource4" ForeColor="#333333" GridLines="None">
			<FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
			<RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
			<Columns>
				<asp:boundfield DataField="Plan_Date" DataFormatString="{0:d}" HeaderText="Plan_Date" HtmlEncode="False" SortExpression="Plan_Date">
				</asp:boundfield>
				<asp:boundfield DataField="Average_Dwell" DataFormatString="{0:f1}" HeaderText="Average_Dwell" HtmlEncode="False" SortExpression="Average_Dwell">
				</asp:boundfield>
			</Columns>
			<PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
			<SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
			<HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
			<AlternatingRowStyle BackColor="White" />
		</asp:GridView>
		<asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Plan Date] AS Plan_Date, [Average Dwell] AS Average_Dwell FROM [Agilis Dwell Daily Average] WHERE (([Plan Date] &gt;= @Plan_Date) AND ([Plan Date] &lt;= @Plan_Date2) AND ([Destination] = @Destination)) ORDER BY [Plan Date] DESC">
			<SelectParameters>
				<asp:controlparameter ControlID="Calendar1" Name="Plan_Date" PropertyName="SelectedDate" Type="DateTime" />
				<asp:controlparameter ControlID="Calendar2" Name="Plan_Date2" PropertyName="SelectedDate" Type="DateTime" />
				<asp:controlparameter ControlID="DropDownList2" Name="Destination" PropertyName="SelectedValue" Type="String" />
			</SelectParameters>
		</asp:SqlDataSource>
	</div>
</form>

</body>

</html>
