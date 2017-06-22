<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Harbor Schedule</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Harbor Schedule</h3>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Date" DataFormatString="{0:MM/dd/yy}" HeaderText="Date" SortExpression="Date">
			</asp:boundfield>
			<asp:boundfield DataField="Load @" HeaderText="Load @" SortExpression="Load @">
			</asp:boundfield>
			<asp:boundfield DataField="Will Arrive @" DataFormatString="{0:HH:mm}" HeaderText="Will Arrive @" SortExpression="Will Arrive @">
			</asp:boundfield>
			<asp:boundfield DataField="Destination" HeaderText="Destination" SortExpression="Destination">
			</asp:boundfield>
			<asp:boundfield DataField="Load #" HeaderText="Load #" SortExpression="Load #">
			</asp:boundfield>
			<asp:boundfield DataField="Driver" HeaderText="Driver" SortExpression="Driver">
			</asp:boundfield>
			<asp:boundfield DataField="Unit" HeaderText="Unit" SortExpression="Unit">
			</asp:boundfield>
			<asp:boundfield DataField="Vessel" HeaderText="Vessel" SortExpression="Vessel">
			</asp:boundfield>
			<asp:boundfield DataField="Proj Client" HeaderText="Proj Client" SortExpression="Proj Client">
			</asp:boundfield>
			<asp:boundfield DataField="Final Dest" HeaderText="Final Dest" SortExpression="Final Dest">
			</asp:boundfield>
		</Columns>
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM vSYSharborArrivals ORDER BY Date ASC,[Load @] ASC,[Proj Client] ASC,[Will Arrive @] ASC">
	</asp:SqlDataSource>
</form>

</body>

</html>
