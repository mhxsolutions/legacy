<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>P2P Daily Driver Breakout</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>P2P Daily Driver Breakout</h3>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Date" HeaderText="Date" ReadOnly="True" SortExpression="Date">
			</asp:boundfield>
			<asp:boundfield DataField="Driver" HeaderText="Driver" ReadOnly="True" SortExpression="Driver">
			</asp:boundfield>
			<asp:boundfield DataField="Actual Min" HeaderText="Actual Min" ReadOnly="True" SortExpression="Actual Min">
			</asp:boundfield>
			<asp:boundfield DataField="Booked Min" HeaderText="Booked Min" SortExpression="Booked Min">
			</asp:boundfield>
			<asp:boundfield DataField="P2P Driver" DataFormatString="{0:p2}" HeaderText="P2P Driver" HtmlEncode="False" ReadOnly="True" SortExpression="P2P Driver">
			</asp:boundfield>
		</Columns>
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [P2P Driver Daily Breakout] WHERE ([Date] = @Date)">
		<SelectParameters>
			<asp:querystringparameter Name="Date" QueryStringField="sel_date" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
</form>

</body>

</html>
