<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>RFS List with Expiration</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>RFS List with Expiration</h3>
	<p>Search Client:
	<asp:TextBox id="TextBox1" runat="server"></asp:TextBox>
	</p>
	<p>&nbsp;</p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="RFS ID" DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None">
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="RFS ID" HeaderText="RFS ID" ReadOnly="True" SortExpression="RFS ID">
			</asp:boundfield>
			<asp:boundfield DataField="Effective" DataFormatString="{0:d}" HeaderText="Effective" HtmlEncode="False" SortExpression="Effective">
			</asp:boundfield>
			<asp:boundfield DataField="Expiration" DataFormatString="{0:d}" HeaderText="Expiration" HtmlEncode="False" SortExpression="Expiration">
			</asp:boundfield>
			<asp:boundfield DataField="Client" HeaderText="Client" ReadOnly="True" SortExpression="Client">
			</asp:boundfield>
			<asp:boundfield DataField="Work Description" HeaderText="Work Description" SortExpression="Work Description">
			</asp:boundfield>
			<asp:boundfield DataField="Work Type" HeaderText="Work Type" SortExpression="Work Type">
			</asp:boundfield>
			<asp:boundfield DataField="Status" HeaderText="Status" SortExpression="Status">
			</asp:boundfield>
		</Columns>
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [RFS list with expiration date] WHERE ([Client] LIKE '%' + @Client + '%') ORDER BY [Expiration] DESC, [RFS ID]">
		<SelectParameters>
			<asp:controlparameter ControlID="TextBox1" DefaultValue="%" Name="Client" PropertyName="Text" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
</form>

</body>

</html>
