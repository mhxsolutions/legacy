<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Driver Sch Status</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Driver Status</h3>
	<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="Driver" DataValueField="Driver">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Driver] FROM [Driver Work Order Progression Today] ORDER BY [Driver]">
	</asp:SqlDataSource>
	<asp:GridView id="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None">
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Plan Date" DataFormatString="{0:d}" HeaderText="Plan Date" HtmlEncode="False" SortExpression="Plan Date">
			</asp:boundfield>
			<asp:boundfield DataField="Origin" HeaderText="Origin" SortExpression="Origin">
			</asp:boundfield>
			<asp:boundfield DataField="Destination" HeaderText="Destination" SortExpression="Destination">
			</asp:boundfield>
			<asp:boundfield DataField="Sch Arrive" DataFormatString="{0:t}" HeaderText="Sch Arrive" HtmlEncode="False" SortExpression="Sch Arrive">
			</asp:boundfield>
			<asp:boundfield DataField="Arrive" DataFormatString="{0:t}" HeaderText="Arrive" HtmlEncode="False" SortExpression="Arrive">
			</asp:boundfield>
			<asp:boundfield DataField="End" DataFormatString="{0:t}" HeaderText="End" HtmlEncode="False" SortExpression="End">
			</asp:boundfield>
			<asp:boundfield DataField="WorkPhone" HeaderText="WorkPhone" SortExpression="WorkPhone">
			</asp:boundfield>
		</Columns>
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Driver Work Order Progression Today] WHERE ([Driver] = @Driver) ORDER BY [Plan Date], [Order]">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Driver" PropertyName="SelectedValue" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
</form>

</body>

</html>
