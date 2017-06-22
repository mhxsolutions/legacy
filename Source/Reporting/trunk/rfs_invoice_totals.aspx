<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<meta name="viewport" content="width=320" />
<title>RFS Invoice Totals</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>RFS Invoice Totals by Client</h3>
	<p>This reports only includes revenue on invoices.</p>
	<p>
	<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="Year" DataValueField="Year">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Year] FROM [RFS Invoiced totals by client] ORDER BY [Year] DESC">
	</asp:SqlDataSource>
&nbsp;From:
	<asp:DropDownList id="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="Month" DataValueField="Month">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Month] FROM [RFS Invoiced totals by client] WHERE ([Year] = @Year) ORDER BY [Month] DESC">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Year" PropertyName="SelectedValue" Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
&nbsp;To:
	<asp:DropDownList id="DropDownList3" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource3" DataTextField="Month" DataValueField="Month">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Month] FROM [RFS Invoiced totals by client] WHERE ([Year] = @Year) ORDER BY [Month] DESC">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Year" PropertyName="SelectedValue" Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
	</p>
	<p>GL:
	<asp:DropDownList id="DropDownList4" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource4" DataTextField="GL_Code_Abr" DataValueField="GL_Code_Abr">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [GL Code Abr] AS GL_Code_Abr FROM [RFS Invoiced totals by client] ORDER BY [GL Code Abr]">
	</asp:SqlDataSource>
	</p>
	<p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource5" ForeColor="#333333" GridLines="None">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Fleet" HeaderText="Fleet" SortExpression="Fleet">
			</asp:boundfield>
			<asp:boundfield DataField="Client" HeaderText="Client" SortExpression="Client">
			</asp:boundfield>
			<asp:boundfield DataField="Year" HeaderText="Year" SortExpression="Year">
			</asp:boundfield>
			<asp:boundfield DataField="Month" HeaderText="Month" SortExpression="Month">
			</asp:boundfield>
			<asp:boundfield DataField="GL_Code_Abr" HeaderText="GL" SortExpression="GL_Code_Abr">
			</asp:boundfield>
			<asp:boundfield DataField="Total" DataFormatString="{0:c}" HeaderText="Total" HtmlEncode="False" SortExpression="Total">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Year], [Month], [Fleet], [Client], [GL Code Abr] AS GL_Code_Abr, [Total] FROM [RFS Invoiced totals by client] WHERE (([Year] = @Year) AND ([GL Code Abr] = @GL_Code_Abr) AND ([Month] &gt;= @Month) AND ([Month] &lt;= @Month2)) ORDER BY [Client], [Year], [Month] DESC">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Year" PropertyName="SelectedValue" Type="Int32" />
			<asp:controlparameter ControlID="DropDownList4" Name="GL_Code_Abr" PropertyName="SelectedValue" Type="String" />
			<asp:controlparameter ControlID="DropDownList2" Name="Month" PropertyName="SelectedValue" Type="Int32" />
			<asp:controlparameter ControlID="DropDownList3" Name="Month2" PropertyName="SelectedValue" Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
	</p>
	<p>This report does not include revenue billed but not invoiced.</p>
</form>

</body>

</html>
