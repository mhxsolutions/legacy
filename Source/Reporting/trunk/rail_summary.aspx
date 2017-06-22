<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Rail Summary</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Rail Summary of Current Cars</h3>
	<p>&nbsp;<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="Status" DataValueField="Status">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Status] FROM [Rail Summary] ORDER BY [Status]">
	</asp:SqlDataSource>
	<asp:DropDownList id="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource3" DataTextField="Terminal" DataValueField="Terminal">
		<asp:ListItem value="Fontana" selected="True">Fontana</asp:ListItem>
		<asp:ListItem value="New Jersey">New Jersey</asp:ListItem>
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Terminal] FROM [Rail Summary] WHERE ([Status] = @Status) ORDER BY [Terminal]">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Status" PropertyName="SelectedValue" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	</p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Terminal" HeaderText="Terminal" SortExpression="Terminal">
			</asp:boundfield>
			<asp:boundfield DataField="Count" HeaderText="Count" SortExpression="Count">
			</asp:boundfield>
			<asp:boundfield DataField="Status" HeaderText="Status" SortExpression="Status">
			</asp:boundfield>
			<asp:boundfield DataField="Client" HeaderText="Client" SortExpression="Client">
			</asp:boundfield>
			<asp:boundfield DataField="Commodity" HeaderText="Commodity" SortExpression="Commodity">
			</asp:boundfield>
			<asp:boundfield DataField="Carrier" HeaderText="Carrier" SortExpression="Carrier">
			</asp:boundfield>
		</Columns>
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Rail Summary] WHERE ([Status] = @Status AND [Terminal] = @Terminal) ORDER BY [Terminal], [Status], [Client]">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Status" PropertyName="SelectedValue" Type="String" />
			<asp:controlparameter ControlID="DropDownList2" Name="Terminal" PropertyName="SelectedValue" Type="string" />
		</SelectParameters>
	</asp:SqlDataSource>
</form>

</body>

</html>
