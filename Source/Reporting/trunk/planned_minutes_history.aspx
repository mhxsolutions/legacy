<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Planned Minutes History</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Planned Minutes History</h3>
	<asp:GridView runat="server" id="GridView1" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" AllowSorting="True" ForeColor="#333333" CellPadding="4" GridLines="None" Width="561px">
		<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<Columns>
			<asp:boundfield DataField="Plan Date" SortExpression="Plan Date" HeaderText="Plan Date">
			</asp:boundfield>
			<asp:boundfield DataField="Driver Ct" SortExpression="Driver Ct" HeaderText="Driver Ct">
			</asp:boundfield>
			<asp:boundfield HtmlEncode="False" DataFormatString="{0:n0}" DataField="Total Min" SortExpression="Total Min" HeaderText="Total Min">
			</asp:boundfield>
			<asp:boundfield ReadOnly="True" DataField="Average Hr per Driver" SortExpression="Average Hr per Driver" HeaderText="Average Hr per Driver">
			</asp:boundfield>
			<asp:boundfield DataField="Orig Driver Ct" SortExpression="Orig Driver Ct" HeaderText="Orig Driver Ct">
			</asp:boundfield>
			<asp:boundfield HtmlEncode="False" DataFormatString="{0:n0}" DataField="Orig Total Min" SortExpression="Orig Total Min" HeaderText="Orig Total Min">
			</asp:boundfield>
			<asp:boundfield ReadOnly="True" DataField="Orig Hr per Driver" SortExpression="Orig Hr per Driver" HeaderText="Orig Hr per Driver">
			</asp:boundfield>
			<asp:boundfield HtmlEncode="False" DataFormatString="{0:p0}" ReadOnly="True" DataField="Dispatch Performance Ratio" SortExpression="Dispatch Performance Ratio" HeaderText="Dispatch Performance Ratio">
			</asp:boundfield>
		</Columns>
		<RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
		<EditRowStyle BackColor="#2461BF" />
		<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Booked Min Dispatch Performance] ORDER BY [Plan Date] DESC">
	</asp:SqlDataSource>
</form>
<p>&nbsp;</p>

</body>

</html>
