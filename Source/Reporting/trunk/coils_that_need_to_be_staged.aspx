<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Coils That Need to be Staged</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Coils That Need to be Staged</h3>
	<asp:GridView runat="server" id="GridView1" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" ForeColor="#333333" CellPadding="4" GridLines="None" AllowSorting="True">
		<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<Columns>
			<asp:boundfield HtmlEncode="False" DataFormatString="{0:d}" DataField="Plan Date" SortExpression="Plan Date" HeaderText="Plan Date">
			</asp:boundfield>
			<asp:boundfield DataField="Coil Count" SortExpression="Coil Count" HeaderText="Coil Count">
			</asp:boundfield>
		</Columns>
		<RowStyle BackColor="#EFF3FB" />
		<EditRowStyle BackColor="#2461BF" />
		<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Coils Needing Stage Summary] ORDER BY [Plan Date]">
	</asp:SqlDataSource>
</form>
<p><a href="coils_that_need_to_be_staged_det.aspx">Detail</a></p>

</body>

</html>
