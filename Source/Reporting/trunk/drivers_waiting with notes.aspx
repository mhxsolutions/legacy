<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<meta http-equiv="refresh" content="60" />
<title>Drivers Waiting with Notes</title>
<meta http-equiv="refresh" content="60" />
</head>

<body>

<form id="form1" runat="server">
	<h2>Drivers Waiting </h2>
	<p>
	<asp:GridView runat="server" id="GridView1" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" DataKeyNames="Client" ForeColor="#333333" CellPadding="4" GridLines="None" AllowSorting="True" Font-Size="X-Large" Width="741px" Font-Names="Arial, Helvetica, sans-serif">
		<FooterStyle BackColor="#1C5E55" ForeColor="White" Font-Bold="True" />
		<Columns>
			<asp:boundfield DataField="Driver" SortExpression="Driver" HeaderText="Driver">
			</asp:boundfield>
			<asp:boundfield ReadOnly="True" DataField="Client" SortExpression="Client" HeaderText="Client">
			</asp:boundfield>
			<asp:boundfield DataField="Wait" SortExpression="Wait" HeaderText="Wait">
			</asp:boundfield>
			<asp:boundfield DataField="Monitor Notes" SortExpression="Monitor Notes" HeaderText="Monitor Notes">
			</asp:boundfield>
		</Columns>
		<RowStyle BackColor="#E3EAEB" />
		<SelectedRowStyle BackColor="#C5BBAF" ForeColor="#333333" Font-Bold="True" />
		<PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
		<HeaderStyle BackColor="#1C5E55" ForeColor="White" Font-Bold="True" />
		<EditRowStyle BackColor="#7C6F57" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Drivers Waiting all destinations] ORDER BY [Wait] DESC">
	</asp:SqlDataSource>
	</p>
</form>

<p>&nbsp;</p>

</body>

</html>
