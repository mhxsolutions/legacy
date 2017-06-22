<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Planned Revenue per Minute</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Planned Revenue per Minute (next plan)</h3>
	<asp:GridView runat="server" id="GridView1" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" GridLines="None" ForeColor="#333333" CellPadding="4" AllowSorting="True">
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Date" DataFormatString="{0:d}" HeaderText="Date" HtmlEncode="False" SortExpression="Date">
			</asp:boundfield>
			<asp:boundfield DataField="Driver" HeaderText="Driver" SortExpression="Driver">
			</asp:boundfield>
			<asp:boundfield DataField="Hr" DataFormatString="{0:f1}" HeaderText="Hr" HtmlEncode="False" SortExpression="Hr">
				<ItemStyle HorizontalAlign="Right" />
			</asp:boundfield>
			<asp:boundfield DataField="Rev" DataFormatString="{0:c0}" HeaderText="Rev" HtmlEncode="False" SortExpression="Rev">
			</asp:boundfield>
			<asp:boundfield DataField="$/Min" DataFormatString="{0:c}" HeaderText="$/Min" HtmlEncode="False" ReadOnly="True" SortExpression="$/Min">
			</asp:boundfield>
			<asp:boundfield DataField="Missing" HeaderText="Missing" SortExpression="Missing">
			</asp:boundfield>
		</Columns>
		<PagerStyle HorizontalAlign="Center" BackColor="#2461BF" ForeColor="White" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Load Rev by Driver by day DLV no service driver Next Days Plan]">
	</asp:SqlDataSource>
</form>

</body>

</html>
