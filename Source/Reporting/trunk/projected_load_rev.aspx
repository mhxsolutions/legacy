<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Projected Load Rev</title>
<meta http-equiv="refresh" content="300" />
<base target="_self" />
</head>

<body>

<form id="form1" runat="server">
	<h3>Projected Load Rev Delivery</h3>
	<p>
	<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="Fleet" DataValueField="Fleet">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Fleet] FROM [Load Rev Proj with Driver Ct] ORDER BY [Fleet]">
	</asp:SqlDataSource>
	</p>
	<asp:GridView runat="server" id="GridView1" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" ForeColor="#333333" CellPadding="4" GridLines="None" AllowSorting="True">
		<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Date" DataFormatString="{0:d}" HeaderText="Date" HtmlEncode="False" SortExpression="Date">
			</asp:boundfield>
			<asp:boundfield DataField="Revenue" DataFormatString="{0:c}" HeaderText="Revenue" HtmlEncode="False" ReadOnly="True" SortExpression="Revenue">
				<ItemStyle HorizontalAlign="Right" />
			</asp:boundfield>
			<asp:boundfield DataField="Rev Ct" HeaderText="Rev Ct" SortExpression="Rev Ct">
				<ItemStyle HorizontalAlign="Center" />
			</asp:boundfield>
			<asp:boundfield DataField="Load Ct" HeaderText="Load Ct" SortExpression="Load Ct">
				<ItemStyle HorizontalAlign="Center" />
			</asp:boundfield>
			<asp:boundfield DataField="Driver Ct" HeaderText="Driver Ct" SortExpression="Driver Ct">
				<ItemStyle HorizontalAlign="Center" />
			</asp:boundfield>
			<asp:boundfield DataField="Rev/Driver" DataFormatString="{0:c}" HeaderText="Rev/Driver" HtmlEncode="False" ReadOnly="True" SortExpression="Rev/Driver">
				<ItemStyle HorizontalAlign="Right" />
			</asp:boundfield>
			<asp:boundfield DataField="T/plan min" DataFormatString="{0:c}" HeaderText="T/plan min" SortExpression="T/plan min">
				<ItemStyle HorizontalAlign="Right" />
			</asp:boundfield>
		</Columns>
		<EditRowStyle BackColor="#2461BF" />
		<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Load Rev Proj with Driver Ct] WHERE ([Fleet] = @Fleet) ORDER BY [Date] DESC">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Fleet" PropertyName="SelectedValue" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
</form>
<p>source: Revenue currently calculated from Planned Loads with DLV action.</p>

<p><a href="projected_load_rev_detail.aspx">Show Detail Records</a></p>

<p><a href="planned_minutes_history.aspx">Show Planned Minutes Report</a></p>

</body>

</html>
