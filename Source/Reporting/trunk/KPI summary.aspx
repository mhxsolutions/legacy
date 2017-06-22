<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<meta http-equiv="refresh" content="180" />
<meta name="viewport" content="width=320" />
<title>Today's Operation KPI</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Today's Operation KPI</h3>
	<p>
	<asp:DetailsView id="DetailsView1" runat="server" AutoGenerateRows="False" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SqlDataSource1" GridLines="Horizontal" Height="50px" Width="200px">
		<FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
		<RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
		<PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
		<Fields>
			<asp:boundfield DataField="Drivers w/out Tractor" HeaderText="Drivers w/out Tractor" SortExpression="Drivers w/out Tractor">
			</asp:boundfield>
			<asp:boundfield DataField="Drivers w/out Trailer" HeaderText="Drivers w/out Trailer" SortExpression="Drivers w/out Trailer">
			</asp:boundfield>
			<asp:boundfield DataField="Drivers with no phone times" HeaderText="Drivers with no phone times" SortExpression="Drivers with no phone times">
			</asp:boundfield>
			<asp:boundfield DataField="Coils Loaded but not staged" HeaderText="Coils Loaded but not staged" SortExpression="Coils Loaded but not staged">
			</asp:boundfield>
			<asp:boundfield DataField="Railcars without receivers" HeaderText="Railcars without receivers" SortExpression="Railcars without receivers">
			</asp:boundfield>
			<asp:boundfield DataField="Loads without RFS" HeaderText="Loads without RFS" SortExpression="Loads without RFS">
			</asp:boundfield>
			<asp:boundfield DataField="Loads without Revenue" HeaderText="Loads without Revenue" SortExpression="Loads without Revenue">
			</asp:boundfield>
			<asp:boundfield DataField="BOL without RFS" HeaderText="BOL without RFS" SortExpression="BOL without RFS">
			</asp:boundfield>
			<asp:boundfield DataField="BOL without Revenue" HeaderText="BOL without Revenue" SortExpression="BOL without Revenue">
			</asp:boundfield>
			<asp:boundfield DataField="Receivers without RFS" HeaderText="Receivers without RFS" SortExpression="Receivers without RFS">
			</asp:boundfield>
			<asp:boundfield DataField="Receivers without Revenue" HeaderText="Receivers without Revenue" SortExpression="Receivers without Revenue">
			</asp:boundfield>
			<asp:boundfield DataField="Bad Stage" HeaderText="Bad Stage" SortExpression="Bad Stage">
			</asp:boundfield>
		</Fields>
		<HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
		<EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
		<AlternatingRowStyle BackColor="#F7F7F7" />
	</asp:DetailsView>
	</p>
	<asp:SqlDataSource id="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [KPI today summary]">
	</asp:SqlDataSource>
</form>
<p>All KPI should equal zero.</p>
<p>Drivers Fontana Only</p>

</body>

</html>
