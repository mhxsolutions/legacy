<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>P2P Daily Breakout</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>P2P Daily Breakout</h3>
	<p>Select Year </p>
	<p>
	<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="year" DataValueField="year">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [year], [Month] FROM [P2P daily breakout] ORDER BY [year] DESC, [Month] DESC">
	</asp:SqlDataSource>
	</p>
	<p>Select Month</p>
	<p>
	<asp:DropDownList id="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="Month" DataValueField="Month">
	</asp:DropDownList>
	</p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None">
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Date" HeaderText="Date" SortExpression="Date">
			</asp:boundfield>
			<asp:boundfield DataField="Booked with PreTrip" HeaderText="Booked with PreTrip" ReadOnly="True" SortExpression="Booked with PreTrip">
				<ItemStyle HorizontalAlign="Right" />
			</asp:boundfield>
			<asp:boundfield DataField="Actual Min" HeaderText="Actual Min" SortExpression="Actual Min">
				<ItemStyle HorizontalAlign="Right" />
			</asp:boundfield>
			<asp:boundfield DataField="Driver Ct" HeaderText="Driver Ct" SortExpression="Driver Ct">
				<ItemStyle HorizontalAlign="Right" />
			</asp:boundfield>
			<asp:boundfield DataField="P2P" DataFormatString="{0:p0}" HeaderText="P2P" HtmlEncode="False" ReadOnly="True" SortExpression="P2P">
			</asp:boundfield>
			<asp:hyperlinkfield DataNavigateUrlFields="Date" DataNavigateUrlFormatString="p2p_daily_driver_breakout.aspx?sel_date={0}" NavigateUrl="p2p_daily_driver_breakout.aspx" Text="Show Drivers">
			</asp:hyperlinkfield>
			<asp:boundfield DataField="Est Rev" DataFormatString="{0:c0}" HeaderText="Est Rev" HtmlEncode="False" SortExpression="Est Rev">
			</asp:boundfield>
			<asp:boundfield DataField="T/Booked Min" DataFormatString="{0:c}" HeaderText="T/Booked Min" HtmlEncode="False" SortExpression="T/Booked Min">
			</asp:boundfield>
			<asp:boundfield DataField="T/Act Min" DataFormatString="{0:c}" HeaderText="T/Act Min" HtmlEncode="False" SortExpression="T/Act Min">
			</asp:boundfield>
		</Columns>
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [P2P daily breakout] WHERE (([year] = @year) AND ([Month] = @Month)) ORDER BY [Date] DESC">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="year" PropertyName="SelectedValue" Type="Int32" />
			<asp:controlparameter ControlID="DropDownList2" Name="Month" PropertyName="SelectedValue" Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
</form>
<p>&nbsp;</p>

</body>

</html>
