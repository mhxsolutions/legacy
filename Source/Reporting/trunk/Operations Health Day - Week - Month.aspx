<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Operations Health</title>
</head>

<body>

<form id="form1" runat="server">
	<table style="width: 100%">
		<tr>
			<td>
			<h3>Days</h3>
			</td>
		</tr>
		<tr>
			<td>
			<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
				<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
				<RowStyle BackColor="#EFF3FB" />
				<Columns>
					<asp:boundfield DataField="Date" HeaderText="Date" SortExpression="Date">
					</asp:boundfield>
					<asp:boundfield DataField="Rev/Driver" DataFormatString="{0:c}" HeaderText="Rev/Driver" HtmlEncode="False" ReadOnly="True" SortExpression="Rev/Driver">
					</asp:boundfield>
					<asp:boundfield DataField="Revenue" DataFormatString="{0:c}" HeaderText="Revenue" HtmlEncode="False" ReadOnly="True" SortExpression="Revenue">
					</asp:boundfield>
					<asp:boundfield DataField="Total Min" HeaderText="Total Min" SortExpression="Total Min">
					</asp:boundfield>
					<asp:boundfield DataField="Rev/Min" DataFormatString="{0:c}" HeaderText="Rev/Min" HtmlEncode="False" ReadOnly="True" SortExpression="Rev/Min">
					</asp:boundfield>
					<asp:boundfield DataField="Average Hr per Driver" HeaderText="Average Hr per Driver" ReadOnly="True" SortExpression="Average Hr per Driver">
					</asp:boundfield>
					<asp:boundfield DataField="Driver Ct" HeaderText="Driver Ct" SortExpression="Driver Ct">
					</asp:boundfield>
					<asp:boundfield DataField="weekday" HeaderText="weekday" ReadOnly="True" SortExpression="weekday">
					</asp:boundfield>
					<asp:boundfield DataField="Week" HeaderText="Week" ReadOnly="True" SortExpression="Week">
					</asp:boundfield>
					<asp:boundfield DataField="Pit Dwell" HeaderText="Pit Dwell" SortExpression="Pit Dwell">
					</asp:boundfield>
					<asp:boundfield DataField="Track 5 Dwell" HeaderText="Track 5 Dwell" SortExpression="Track 5 Dwell">
					</asp:boundfield>
					<asp:boundfield DataField="Yard Dwell" HeaderText="Yard Dwell" SortExpression="Yard Dwell">
					</asp:boundfield>
				</Columns>
				<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
				<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
				<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
				<EditRowStyle BackColor="#2461BF" />
				<AlternatingRowStyle BackColor="White" />
			</asp:GridView>
			<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Operations Health by Day (15 days)] ORDER BY [Date] DESC">
			</asp:SqlDataSource>
			</td>
		</tr>
		<tr>
			<td>
			<h3>Weeks</h3>
			</td>
		</tr>
		<tr>
			<td>
			<asp:GridView id="GridView2" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None">
				<FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
				<RowStyle BackColor="#E3EAEB" />
				<Columns>
					<asp:boundfield DataField="week" HeaderText="week" SortExpression="week">
					</asp:boundfield>
					<asp:boundfield DataField="Wk Avg Rev/Driver" DataFormatString="{0:c}" HeaderText="Wk Avg Rev/Driver" HtmlEncode="False" SortExpression="Wk Avg Rev/Driver">
					</asp:boundfield>
					<asp:boundfield DataField="Wk Avg Revenue" DataFormatString="{0:c}" HeaderText="Wk Avg Revenue" HtmlEncode="False" SortExpression="Wk Avg Revenue">
					</asp:boundfield>
					<asp:boundfield DataField="Wk Avg Total Min" HeaderText="Wk Avg Total Min" SortExpression="Wk Avg Total Min">
					</asp:boundfield>
					<asp:boundfield DataField="Wk Avg Rev/Min" DataFormatString="{0:c}" HeaderText="Wk Avg Rev/Min" HtmlEncode="False" SortExpression="Wk Avg Rev/Min">
					</asp:boundfield>
					<asp:boundfield DataField="Wk Avg Hr/Driver" HeaderText="Wk Avg Hr/Driver" SortExpression="Wk Avg Hr/Driver">
					</asp:boundfield>
					<asp:boundfield DataField="Wk Avg Driver Ct" HeaderText="Wk Avg Driver Ct" SortExpression="Wk Avg Driver Ct">
					</asp:boundfield>
					<asp:boundfield DataField="Wk Avg Pit Dwell" HeaderText="Wk Avg Pit Dwell" SortExpression="Wk Avg Pit Dwell">
					</asp:boundfield>
					<asp:boundfield DataField="Wk Avg Track 5 Dwell" HeaderText="Wk Avg Track 5 Dwell" SortExpression="Wk Avg Track 5 Dwell">
					</asp:boundfield>
					<asp:boundfield DataField="Wk Avg Yard Dwell" HeaderText="Wk Avg Yard Dwell" SortExpression="Wk Avg Yard Dwell">
					</asp:boundfield>
				</Columns>
				<PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
				<SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
				<HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
				<EditRowStyle BackColor="#7C6F57" />
				<AlternatingRowStyle BackColor="White" />
			</asp:GridView>
			<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Operations Health by Week] ORDER BY [week] DESC">
			</asp:SqlDataSource>
			</td>
		</tr>
		<tr>
			<td>
			<h3>Months</h3>
			</td>
		</tr>
		<tr>
			<td>
			<asp:GridView id="GridView3" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource3" ForeColor="#333333" GridLines="None">
				<FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
				<RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
				<Columns>
					<asp:boundfield DataField="Month" HeaderText="Month" SortExpression="Month">
					</asp:boundfield>
					<asp:boundfield DataField="Mo Avg Rev/Driver" DataFormatString="{0:c}" HeaderText="Mo Avg Rev/Driver" HtmlEncode="False" SortExpression="Mo Avg Rev/Driver">
					</asp:boundfield>
					<asp:boundfield DataField="Mo Avg Revenue" DataFormatString="{0:c}" HeaderText="Mo Avg Revenue" HtmlEncode="False" SortExpression="Mo Avg Revenue">
					</asp:boundfield>
					<asp:boundfield DataField="Mo Avg Total Min" HeaderText="Mo Avg Total Min" SortExpression="Mo Avg Total Min">
					</asp:boundfield>
					<asp:boundfield DataField="Mo Avg Rev/Min" DataFormatString="{0:c}" HeaderText="Mo Avg Rev/Min" HtmlEncode="False" SortExpression="Mo Avg Rev/Min">
					</asp:boundfield>
					<asp:boundfield DataField="Mo Avg Hr/Driver" DataFormatString="{0:f1}" HeaderText="Mo Avg Hr/Driver" HtmlEncode="False" SortExpression="Mo Avg Hr/Driver">
					</asp:boundfield>
					<asp:boundfield DataField="Mo Avg Driver Ct" HeaderText="Mo Avg Driver Ct" SortExpression="Mo Avg Driver Ct">
					</asp:boundfield>
				</Columns>
				<PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
				<SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
				<HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
				<AlternatingRowStyle BackColor="White" />
			</asp:GridView>
			<asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Operations Health by Month] ORDER BY [Month] DESC">
			</asp:SqlDataSource>
			</td>
		</tr>
	</table>
</form>

</body>

</html>
