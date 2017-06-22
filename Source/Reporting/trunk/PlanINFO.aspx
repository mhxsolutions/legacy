<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>PlanINFO</title>
</head>

<body>

<form id="form1" runat="server">
	<asp:GridView runat="server" id="GridView1" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" DataKeyNames="Client Name" AllowSorting="True" GridLines="None" ForeColor="#333333" CellPadding="4">
		<FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
		<RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
		<Columns>
			<asp:boundfield DataField="Plan Date" DataFormatString="{0:d}" HeaderText="Plan Date" HtmlEncode="False" SortExpression="Plan Date">
			</asp:boundfield>
			<asp:boundfield DataField="Client Name" HeaderText="Client Name" ReadOnly="True" SortExpression="Client Name">
			</asp:boundfield>
			<asp:boundfield DataField="Average Dwell" HeaderText="Average Dwell" SortExpression="Average Dwell">
			</asp:boundfield>
			<asp:boundfield DataField="Sch Arrive" DataFormatString="{0:t}" HeaderText="Sch Arrive" HtmlEncode="False" SortExpression="Sch Arrive">
			</asp:boundfield>
			<asp:boundfield DataField="Driver" HeaderText="Driver" ReadOnly="True" SortExpression="Driver">
			</asp:boundfield>
		</Columns>
		<PagerStyle HorizontalAlign="Center" BackColor="#284775" ForeColor="White" />
		<SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#999999" />
		<AlternatingRowStyle BackColor="White" ForeColor="#284775" />
	</asp:GridView>
	<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT * FROM [PlanInfo] ORDER BY [Plan Date], [Client Name], [Sch Arrive]">
	</asp:SqlDataSource>
</form>

</body>

</html>
