<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Raritan - Load History</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Raritan - Load History</h3>
	<p>Filter Load Number:
	<asp:TextBox id="TextBox1" runat="server"></asp:TextBox>
	<asp:Button id="Button1" runat="server" Text="Filter List" />
	</p>
	<p>
	<asp:GridView id="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Load" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" PageSize="100">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Load" HeaderText="Load" ReadOnly="True" SortExpression="Load">
			</asp:boundfield>
			<asp:boundfield DataField="LoadDate" DataFormatString="{0:d}" HeaderText="LoadDate" SortExpression="LoadDate">
			</asp:boundfield>
			<asp:boundfield DataField="Destination" HeaderText="Destination" ReadOnly="True" SortExpression="Destination">
			</asp:boundfield>
			<asp:boundfield DataField="LogOutDate" DataFormatString="{0:d}" HeaderText="LogOutDate" SortExpression="LogOutDate">
			</asp:boundfield>
			<asp:boundfield DataField="POD Date" DataFormatString="{0:d}" HeaderText="POD Date" SortExpression="POD Date">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Raritan load history] WHERE ([Load] LIKE '%' + @Load + '%') ORDER BY [Load] DESC">
		<SelectParameters>
			<asp:controlparameter ControlID="TextBox1" Name="Load" PropertyName="Text" Type="String" DefaultValue="0" />
		</SelectParameters>
	</asp:SqlDataSource>
	</p>
</form>

</body>

</html>
