<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Wise HFI Viewer</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Wise HFI Viewer</h3>
	<p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Client,Location" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Date Received" DataFormatString="{0:d}" HeaderText="Date Received" HtmlEncode="False" SortExpression="Date Received">
			</asp:boundfield>
			<asp:boundfield DataField="Client" HeaderText="Client" ReadOnly="True" SortExpression="Client">
			</asp:boundfield>
			<asp:boundfield DataField="Location" HeaderText="Location" ReadOnly="True" SortExpression="Location">
			</asp:boundfield>
			<asp:boundfield DataField="Product Group 1" HeaderText="Product Group 1" SortExpression="Product Group 1">
			</asp:boundfield>
			<asp:boundfield DataField="Product Group 2" HeaderText="Product Group 2" SortExpression="Product Group 2">
			</asp:boundfield>
			<asp:boundfield DataField="Item ID" HeaderText="Item ID" SortExpression="Item ID">
			</asp:boundfield>
			<asp:boundfield DataField="Weight" DataFormatString="{0:d0}" HeaderText="Weight" HtmlEncode="False" SortExpression="Weight">
			</asp:boundfield>
			<asp:boundfield DataField="Product Profile Description" HeaderText="Product Profile Description" SortExpression="Product Profile Description">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Wise HFI inventory viewer]">
	</asp:SqlDataSource>
	</p>
</form>

</body>

</html>
