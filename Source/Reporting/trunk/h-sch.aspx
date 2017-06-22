<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Harbor Schedule</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Harbor Detail Schedule</h3>
	<p><a href="harbor_planner_summary.aspx">show summary</a></p>
	<p>Select Plan Date</p>
	<p>
	<asp:DropDownList id="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource3" DataTextField="Date" DataValueField="Date">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Date] FROM [vSYSharborArrivalsBB] ORDER BY [Date]">
	</asp:SqlDataSource>
	</p>
	<p>Select Load Origin</p>
	<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="column1" DataValueField="column1">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Load @] AS column1 FROM [vSYSharborArrivalsBB] WHERE ([Date] = @Date) ORDER BY [Load @]">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList2" Name="Date" PropertyName="SelectedValue" Type="DateTime" />
		</SelectParameters>
	</asp:SqlDataSource>
	<br />
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None">
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="column1" DataFormatString="{0:t}" HeaderText="Arrive @" HtmlEncode="False" SortExpression="column1">
			</asp:boundfield>
			<asp:boundfield DataField="column2" HeaderText="Load #" SortExpression="column2">
			</asp:boundfield>
			<asp:boundfield DataField="Driver" HeaderText="Driver" SortExpression="Driver">
			</asp:boundfield>
			<asp:boundfield DataField="Final_Dest" HeaderText="Dest" SortExpression="Final_Dest">
			</asp:boundfield>
		</Columns>
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Arrive @] AS column1, [Load #] AS column2, [Driver], [Dest], [Final Dest] AS Final_Dest FROM [vSYSharborArrivalsBB] WHERE (([Load @] = @column1) AND ([Date] = @Date)) ORDER BY [Arrive @]">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="column1" PropertyName="SelectedValue" Type="String" />
			<asp:controlparameter ControlID="DropDownList2" Name="Date" PropertyName="SelectedValue" Type="DateTime" />
		</SelectParameters>
	</asp:SqlDataSource>
</form>

</body>

</html>
