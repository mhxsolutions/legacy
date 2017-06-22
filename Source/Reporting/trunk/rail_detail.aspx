<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Rail Detail</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Rail Detail</h3>
	<p>Terminal:
	<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="terminals" DataTextField="Terminal" DataValueField="Terminal">
	</asp:DropDownList>
	<asp:SqlDataSource ID="terminals" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Terminal] FROM [Rail Detail] ORDER BY [Terminal]">
	</asp:SqlDataSource>
	</p>
	<p>Client:
	<asp:DropDownList id="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="client" DataTextField="Client" DataValueField="Client">
	</asp:DropDownList>
	<asp:SqlDataSource ID="client" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Client] FROM [Rail Detail] WHERE ([Terminal] = @Terminal) ORDER BY [Client]">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Terminal" PropertyName="SelectedValue" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	</p>
	<p>&nbsp;</p>
	<asp:GridView id="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="detail" ForeColor="#333333" GridLines="None" PageSize="100">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Client Preferred Date" DataFormatString="{0:d}" HeaderText="Client Preferred Date" HtmlEncode="False" SortExpression="Client Preferred Date">
				<HeaderStyle HorizontalAlign="Left" Width="1in" />
			</asp:boundfield>
			<asp:boundfield DataField="Car" HeaderText="Car" SortExpression="Car">
			</asp:boundfield>
			<asp:boundfield DataField="Commodity" HeaderText="Commodity" SortExpression="Commodity">
			</asp:boundfield>
			<asp:boundfield DataField="Product" HeaderText="Product" SortExpression="Product">
			</asp:boundfield>
			<asp:boundfield DataField="Carrier" HeaderText="Carrier" SortExpression="Carrier">
			</asp:boundfield>
			<asp:boundfield DataField="E T A" DataFormatString="{0:d}" HeaderText="E T A" HtmlEncode="False" SortExpression="E T A">
			</asp:boundfield>
			<asp:boundfield DataField="Status" HeaderText="Status" SortExpression="Status">
			</asp:boundfield>
			<asp:boundfield DataField="Rail Yard" DataFormatString="{0:d}" HeaderText="Rail Yard" HtmlEncode="False" SortExpression="Rail Yard">
			</asp:boundfield>
			<asp:boundfield DataField="Days in yard" HeaderText="Days in yard" SortExpression="Days in yard">
				<ItemStyle HorizontalAlign="Center" />
			</asp:boundfield>
			<asp:boundfield DataField="Start Demurrage" DataFormatString="{0:d}" HeaderText="Start Demurrage" HtmlEncode="False" SortExpression="Start Demurrage">
			</asp:boundfield>
			<asp:boundfield DataField="Placed" DataFormatString="{0:d}" HeaderText="Placed" HtmlEncode="False" SortExpression="Placed">
			</asp:boundfield>
			<asp:boundfield DataField="Unloaded" DataFormatString="{0:d}" HeaderText="Unloaded" HtmlEncode="False" SortExpression="Unloaded">
			</asp:boundfield>
			<asp:boundfield DataField="Car Comments" HeaderText="Comments" SortExpression="Car Comments">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="detail" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Rail Detail] WHERE (([Terminal] = @Terminal) AND ([Client] = @Client)) ORDER BY [Client], [E T A], [Car]">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Terminal" PropertyName="SelectedValue" Type="String" />
			<asp:controlparameter ControlID="DropDownList2" Name="Client" PropertyName="SelectedValue" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
</form>

</body>

</html>
