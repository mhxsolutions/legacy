<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Invoice Totals by GL</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Invoice Totals by GL</h3>
	<p>Year:<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="Year" DataValueField="Year">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Year] FROM [Invoice totals by GL] ORDER BY [Year] DESC">
	</asp:SqlDataSource>
	</p>
	<p>Month:
	<asp:DropDownList id="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="Month" DataValueField="Month">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Month] FROM [Invoice totals by GL] WHERE ([Year] = @Year) ORDER BY [Month] DESC">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Year" PropertyName="SelectedValue" Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
	</p>
	<p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="RFS_Invoice_Id" DataSourceID="SqlDataSource3" ForeColor="#333333" GridLines="None">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="RFS_Invoice_Id" HeaderText="Invoice" ReadOnly="True" SortExpression="RFS_Invoice_Id">
			</asp:boundfield>
			<asp:boundfield DataField="Item_Total" DataFormatString="{0:c}" HeaderText="Total" SortExpression="Item_Total">
			</asp:boundfield>
			<asp:boundfield DataField="Cost_Ctr_Abr" HeaderText="Cost_Ctr" SortExpression="Cost_Ctr_Abr">
			</asp:boundfield>
			<asp:boundfield DataField="GL_Code_Abr" HeaderText="GL_Code" SortExpression="GL_Code_Abr">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [RFS Invoice Id] AS RFS_Invoice_Id, [Item Total] AS Item_Total, [Group Name] AS Group_Name, [Cost Ctr Abr] AS Cost_Ctr_Abr, [GL Code Abr] AS GL_Code_Abr FROM [Invoice totals by GL] WHERE (([Year] = @Year) AND ([Month] = @Month))">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Year" PropertyName="SelectedValue" Type="Int32" />
			<asp:controlparameter ControlID="DropDownList2" Name="Month" PropertyName="SelectedValue" Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
	</p>
</form>

</body>

</html>
