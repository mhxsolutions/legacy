<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta name="viewport" content="width=640" />
<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />

<title>RFS Invoice Process Summary</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>RFS Invoice Process Summary</h3>
	<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="Year" DataValueField="Year">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Year] FROM [RFS Invoice Process Summary] ORDER BY [Year] DESC">
	</asp:SqlDataSource>
	<asp:DropDownList id="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="Month" DataValueField="Month">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Month] FROM [RFS Invoice Process Summary] WHERE ([Year] = @Year) ORDER BY [Month] DESC">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Year" PropertyName="SelectedValue" Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
	<br />
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource3" ForeColor="#333333" GridLines="None">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Status" HeaderText="Status" SortExpression="Status">
			</asp:boundfield>
			<asp:boundfield DataField="Cost Center" HeaderText="Cost Center" SortExpression="Cost Center">
			</asp:boundfield>
			<asp:boundfield DataField="GL Code" HeaderText="GL Code" SortExpression="GL Code">
			</asp:boundfield>
			<asp:boundfield DataField="Total" DataFormatString="{0:c0}" HeaderText="Total" HtmlEncode="False" SortExpression="Total">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<a href="rfs_invoice_process_detail.aspx">detail</a><br />
	<br />
	<asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [RFS Invoice Process Summary] WHERE (([Year] = @Year) AND ([Month] = @Month)) ORDER BY [Status], [Cost Center], [GL Code]">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Year" PropertyName="SelectedValue" Type="Int32" />
			<asp:controlparameter ControlID="DropDownList2" Name="Month" PropertyName="SelectedValue" Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:GridView id="GridView2" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource4" ForeColor="#333333" GridLines="None" AllowSorting="True">
		<RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
		<Columns>
			<asp:boundfield DataField="Cost_Center" HeaderText="Cost_Center" SortExpression="Cost_Center">
			</asp:boundfield>
			<asp:boundfield DataField="GL_Code" HeaderText="GL_Code" SortExpression="GL_Code">
			</asp:boundfield>
			<asp:boundfield DataField="Total" DataFormatString="{0:c0}" HeaderText="Total" HtmlEncode="False" SortExpression="Total">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#999999" />
		<AlternatingRowStyle BackColor="White" ForeColor="#284775" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Cost Center] AS Cost_Center, [GL Code] AS GL_Code, [Total] FROM [RFS sum] WHERE (([Year] = @Year) AND ([Month] = @Month)) ORDER BY [Cost Center], [GL Code]">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Year" PropertyName="SelectedValue" Type="Int32" />
			<asp:controlparameter ControlID="DropDownList2" Name="Month" PropertyName="SelectedValue" Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
	<br />
	<hr />Less Pass-Thru Revenue<hr /><br />
	<asp:GridView id="GridView4" runat="server" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataSourceID="SqlDataSource6">
		<RowStyle BackColor="White" ForeColor="#003399" />
		<Columns>
			<asp:boundfield DataField="Cost_Center" HeaderText="Cost_Center" SortExpression="Cost_Center">
			</asp:boundfield>
			<asp:boundfield DataField="Total" DataFormatString="{0:c0}" HeaderText="Total" HtmlEncode="False" SortExpression="Total">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
		<PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
		<SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
		<HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Cost Center] AS Cost_Center, [Total] FROM [RFS Sum by Cost Center by Month] WHERE (([Year] = @Year) AND ([Month] = @Month)) ORDER BY [Cost Center]">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Year" PropertyName="SelectedValue" Type="Int32" />
			<asp:controlparameter ControlID="DropDownList2" Name="Month" PropertyName="SelectedValue" Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
	<br />
	<asp:GridView id="GridView3" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataSourceID="SqlDataSource5">
		<RowStyle BackColor="White" ForeColor="#003399" />
		<Columns>
			<asp:boundfield DataField="Total" DataFormatString="{0:c0}" HeaderText="Total" HtmlEncode="False" SortExpression="Total">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
		<PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
		<SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
		<HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Total] FROM [RFS Sum by Month] WHERE (([Year] = @Year) AND ([Month] = @Month))">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Year" PropertyName="SelectedValue" Type="Int32" />
			<asp:controlparameter ControlID="DropDownList2" Name="Month" PropertyName="SelectedValue" Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
</form>

</body>

</html>
