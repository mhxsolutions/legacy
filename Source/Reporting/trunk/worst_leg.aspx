<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Driver's Worst Leg</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Driver's Worst Leg</h3>
	<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="Date" DataValueField="Date">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Date] FROM [Driver Performance to Plan for Today worst leg] ORDER BY [Date] DESC">
	</asp:SqlDataSource>
	<br />
	<asp:GridView id="GridView2" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
		<RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
		<Columns>
			<asp:boundfield DataField="Date" HeaderText="Date" SortExpression="Date">
			</asp:boundfield>
			<asp:boundfield DataField="Drivers" HeaderText="Drivers" ReadOnly="True" SortExpression="Drivers">
			</asp:boundfield>
			<asp:boundfield DataField="Off Sch" HeaderText="Off Sch" SortExpression="Off Sch">
			</asp:boundfield>
			<asp:boundfield DataField="Ending Leg" HeaderText="Ending Leg" ReadOnly="True" SortExpression="Ending Leg">
			</asp:boundfield>
			<asp:boundfield DataField="Departing" HeaderText="Departing" ReadOnly="True" SortExpression="Departing">
			</asp:boundfield>
		</Columns>
		<PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
		<HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Driver Performance to Plan for Today worst leg] WHERE ([Date] = @Date) ORDER BY [Off Sch] DESC">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Date" PropertyName="SelectedValue" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
</form>

</body>

</html>
