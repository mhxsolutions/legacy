<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html dir="ltr" xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<title>Title up top</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="title_up_top.css" />
</head>

<body>

<form id="form1" runat="server">
	<div id="masthead">
		Title up top</div>
	<div id="top_nav">
	</div>
	<div id="container">
		<div id="left_col">
			<asp:GridView runat="server" id="GridView1" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" ForeColor="#333333" CellPadding="4" GridLines="None" AllowSorting="True">
				<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
				<Columns>
					<asp:boundfield DataField="Year" SortExpression="Year" HeaderText="Year">
					</asp:boundfield>
					<asp:boundfield DataField="Month" SortExpression="Month" HeaderText="Month">
					</asp:boundfield>
					<asp:boundfield DataField="Planned Min" SortExpression="Planned Min" HeaderText="Planned Min">
					</asp:boundfield>
					<asp:boundfield ReadOnly="True" DataField="Pln Avg Driver Hr" SortExpression="Pln Avg Driver Hr" HeaderText="Pln Avg Driver Hr">
					</asp:boundfield>
					<asp:boundfield DataField="Act Min" SortExpression="Act Min" HeaderText="Act Min">
					</asp:boundfield>
					<asp:boundfield ReadOnly="True" DataField="Act Avg Driver Hr" SortExpression="Act Avg Driver Hr" HeaderText="Act Avg Driver Hr">
					</asp:boundfield>
					<asp:boundfield ReadOnly="True" DataField="Ratio" SortExpression="Ratio" HeaderText="Ratio">
					</asp:boundfield>
				</Columns>
				<RowStyle BackColor="#EFF3FB" />
				<EditRowStyle BackColor="#2461BF" />
				<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True" />
				<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
				<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
				<AlternatingRowStyle BackColor="White" />
			</asp:GridView>
			<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Booked Hours to Actual Hours]">
			</asp:SqlDataSource>
		</div>
		<div id="page_content">
			<asp:GridView runat="server" id="GridView2" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" AllowSorting="True">
				<FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
				<Columns>
					<asp:boundfield DataField="Year" SortExpression="Year" HeaderText="Year">
					</asp:boundfield>
					<asp:boundfield DataField="Month" SortExpression="Month" HeaderText="Month">
					</asp:boundfield>
					<asp:boundfield DataField="column1" SortExpression="column1" HeaderText="column1">
					</asp:boundfield>
					<asp:boundfield ReadOnly="True" DataField="column2" SortExpression="column2" HeaderText="column2">
					</asp:boundfield>
					<asp:boundfield ReadOnly="True" DataField="column3" SortExpression="column3" HeaderText="column3">
					</asp:boundfield>
				</Columns>
				<RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
				<SelectedRowStyle BackColor="#738A9C" ForeColor="#F7F7F7" Font-Bold="True" />
				<PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
				<HeaderStyle BackColor="#4A3C8C" ForeColor="#F7F7F7" Font-Bold="True" />
				<AlternatingRowStyle BackColor="#F7F7F7" />
			</asp:GridView>
			<asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Year], [Month], [Avg Driver/Day] AS column1, [Avg Hr/Driver/Day] AS column2, [Avg Min/Day] AS column3 FROM [Booked Hours Monthly]">
			</asp:SqlDataSource>
		</div>
		<div id="right_col">
		</div>
	</div>
	<div id="footer">
	</div>
</form>

</body>

</html>
