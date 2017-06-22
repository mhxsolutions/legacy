<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<meta http-equiv="refresh" content="60" />
<title>Budway Wait</title>
</head>

<body>

<form id="form1" runat="server">
	<h4>
	<strong>Budway Wait</strong></h4>
	<asp:GridView runat="server" id="GridView1" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" ForeColor="#333333" CellPadding="4" GridLines="None">
		<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<Columns>
			<asp:boundfield DataField="Driver" SortExpression="Driver" HeaderText="Driver">
			</asp:boundfield>
			<asp:boundfield DataField="Wait" SortExpression="Wait" HeaderText="Wait">
			</asp:boundfield>
			<asp:boundfield DataField="Arrive" SortExpression="Arrive" HeaderText="Arrive">
			</asp:boundfield>
		</Columns>
		<RowStyle BackColor="#EFF3FB" />
		<EditRowStyle BackColor="#2461BF" />
		<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Driver], [Wait], [Arrive] FROM [webDriverMonitorBudwayWait] ORDER BY [Wait] DESC">
	</asp:SqlDataSource>
</form>

<p><a href="budway_phonebased_dwell.asp">Budway Phone-based Dwell</a></p>

</body>

</html>
