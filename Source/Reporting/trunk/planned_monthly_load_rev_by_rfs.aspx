<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Planned Monthly Load Rev by RFS</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Planned Monthly Load Rev by RFS</h3>
	<p>Year:
	<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="Year" DataValueField="Year">
	</asp:DropDownList>
	&nbsp;Month:
	<asp:DropDownList id="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="Month" DataValueField="Month">
	</asp:DropDownList>
	</p>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Year] FROM [Load Rev Planned by RFS monthly] ORDER BY [Year] DESC">
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Month] FROM [Load Rev Planned by RFS monthly] WHERE ([Year] = @Year) ORDER BY [Month] DESC">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Year" PropertyName="SelectedValue" Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
	<p>NOTICE: this data is subject to driver phone errors and it does not 
	include pre/post trip times in throughput.</p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource3" ForeColor="#333333" GridLines="None">
		<FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
		<RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
		<Columns>
			<asp:boundfield DataField="Year" HeaderText="Year" SortExpression="Year">
			</asp:boundfield>
			<asp:boundfield DataField="Month" HeaderText="Month" SortExpression="Month">
				<ItemStyle HorizontalAlign="Center" />
			</asp:boundfield>
			<asp:boundfield DataField="Sales Person" HeaderText="Sales Person" SortExpression="Sales Person">
			</asp:boundfield>
			<asp:boundfield DataField="Client" HeaderText="Client" SortExpression="Client">
			</asp:boundfield>
			<asp:boundfield DataField="Rev" DataFormatString="{0:c0}" HeaderText="Rev" HtmlEncode="False" SortExpression="Rev">
			</asp:boundfield>
			<asp:boundfield DataField="Rev/Plan Min" DataFormatString="{0:c}" HeaderText="Rev/Plan Min" HtmlEncode="False" ReadOnly="True" SortExpression="Rev/Plan Min">
				<ItemStyle HorizontalAlign="Right" />
			</asp:boundfield>
			<asp:hyperlinkfield DataNavigateUrlFields="Year,Month,RFS ref" DataNavigateUrlFormatString="planned_load_revenue_detail.aspx?year={0}&amp;month={1}&amp;rfsref={2}" DataTextField="RFS ref" HeaderText="RFS" SortExpression="RFS ref">
			</asp:hyperlinkfield>
		</Columns>
		<PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
		<HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Load Rev Planned by RFS monthly] WHERE (([Month] = @Month) AND ([Year] = @Year)) ORDER BY [Client]">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList2" Name="Month" PropertyName="SelectedValue" Type="Int32" />
			<asp:controlparameter ControlID="DropDownList1" Name="Year" PropertyName="SelectedValue" Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
</form>

</body>

</html>
