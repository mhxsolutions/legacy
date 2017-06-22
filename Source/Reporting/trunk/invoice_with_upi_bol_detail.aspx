<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Invoice with UPI BOL Detail</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Invoice with UPI BOL Detail</h3>
	<p>BOL:
	<asp:DropDownList id="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource3" DataTextField="BOL" DataValueField="BOL">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [BOL] FROM [Invoice with UPI BOL detail] ORDER BY [BOL]">
	</asp:SqlDataSource>
	</p>
	<asp:GridView id="GridView2" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="RFS Invoice Id" DataSourceID="SqlDataSource4" ForeColor="#333333" GridLines="None">
		<RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
		<Columns>
			<asp:boundfield DataField="RFS Invoice Id" HeaderText="Invoice" ReadOnly="True" SortExpression="RFS Invoice Id">
			</asp:boundfield>
			<asp:boundfield DataField="Status" HeaderText="Status" SortExpression="Status">
			</asp:boundfield>
			<asp:boundfield DataField="Invoice Date" DataFormatString="{0:d}" HeaderText="Invoice Date" HtmlEncode="False" SortExpression="Invoice Date">
			</asp:boundfield>
			<asp:boundfield DataField="BOL" HeaderText="BOL" SortExpression="BOL">
			</asp:boundfield>
			<asp:boundfield DataField="Item Total" HeaderText="Item Total" SortExpression="Item Total">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#999999" />
		<AlternatingRowStyle BackColor="White" ForeColor="#284775" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Invoice with UPI BOL detail] WHERE ([BOL] = @BOL)">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList2" Name="BOL" PropertyName="SelectedValue" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	<p>&nbsp;</p>
	<p>Select Invoice&nbsp;
	<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="RFS_Invoice_Id" DataValueField="RFS_Invoice_Id">
	</asp:DropDownList>
	</p>
	<p>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [RFS Invoice Id] AS RFS_Invoice_Id FROM [Invoice with UPI BOL detail] ORDER BY [RFS Invoice Id]">
	</asp:SqlDataSource>
	</p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="RFS Invoice Id" DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="RFS Invoice Id" HeaderText="Invoice" ReadOnly="True" SortExpression="RFS Invoice Id">
			</asp:boundfield>
			<asp:boundfield DataField="Status" HeaderText="Status" SortExpression="Status">
			</asp:boundfield>
			<asp:boundfield DataField="Invoice Date" DataFormatString="{0:d}" HeaderText="Invoice Date" HtmlEncode="False" SortExpression="Invoice Date">
			</asp:boundfield>
			<asp:boundfield DataField="BOL" HeaderText="BOL" SortExpression="BOL">
			</asp:boundfield>
			<asp:boundfield DataField="Item Total" DataFormatString="{0:c}" HeaderText="Item Total" HtmlEncode="False" SortExpression="Item Total">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Invoice with UPI BOL detail] WHERE ([RFS Invoice Id] = @RFS_Invoice_Id)">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="RFS_Invoice_Id" PropertyName="SelectedValue" Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
</form>

</body>

</html>
