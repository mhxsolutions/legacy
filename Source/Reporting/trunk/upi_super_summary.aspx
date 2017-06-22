<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>UPI Super Summary</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>UPI Super Summary</h3>
	<p>
	<asp:GridView id="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="For_Date" DataFormatString="{0:d}" HeaderText="For_Date" HtmlEncode="False" SortExpression="For_Date">
			</asp:boundfield>
			<asp:boundfield DataField="UPI_Load_Count" HeaderText="UPI Ct" SortExpression="UPI_Load_Count">
			</asp:boundfield>
			<asp:boundfield DataField="Will_Call" HeaderText="W/Call" SortExpression="Will_Call">
			</asp:boundfield>
			<asp:boundfield DataField="Budway_Loads" HeaderText="Budway" ReadOnly="True" SortExpression="Budway_Loads">
			</asp:boundfield>
			<asp:boundfield DataField="Planned_Loads" HeaderText="Planned" ReadOnly="True" SortExpression="Planned_Loads">
			</asp:boundfield>
			<asp:boundfield DataField="Total_Delivered" HeaderText="Delivered" SortExpression="Total_Delivered">
			</asp:boundfield>
		</Columns>
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [For Date] AS For_Date, [UPI Load Count] AS UPI_Load_Count, [Will Call] AS Will_Call, [Budway Loads] AS Budway_Loads, [Planned Loads] AS Planned_Loads, [Total Delivered] AS Total_Delivered FROM [webUPITomorrow p2]">
	</asp:SqlDataSource>
	</p>
</form>

</body>

</html>
