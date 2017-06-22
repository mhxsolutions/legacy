<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Active Railcar Details</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Active Railcars with Pre-Receiver Information</h3>
	<p>&nbsp;</p>
	<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="Terminal" DataValueField="Terminal">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Terminal] FROM [Active Railcars with prereceiver info] ORDER BY [Terminal]">
	</asp:SqlDataSource>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Client" HeaderText="Client" SortExpression="Client">
			</asp:boundfield>
			<asp:boundfield DataField="Shipper" HeaderText="Shipper" SortExpression="Shipper">
			</asp:boundfield>
			<asp:boundfield DataField="Profile" HeaderText="Profile" SortExpression="Profile">
			</asp:boundfield>
			<asp:boundfield DataField="Car Number" HeaderText="Car Number" SortExpression="Car Number">
			</asp:boundfield>
			<asp:boundfield DataField="Line" HeaderText="Line" SortExpression="Line">
			</asp:boundfield>
			<asp:boundfield DataField="Product Group 1" HeaderText="Product Group 1" SortExpression="Product Group 1">
			</asp:boundfield>
			<asp:boundfield DataField="Status" HeaderText="Status" SortExpression="Status">
			</asp:boundfield>
			<asp:boundfield DataField="Currently" HeaderText="Currently" SortExpression="Currently">
			</asp:boundfield>
			<asp:boundfield DataField="ETA" DataFormatString="{0:d}" HeaderText="ETA" SortExpression="ETA">
			</asp:boundfield>
			<asp:boundfield DataField="Product Type" HeaderText="Product Type" SortExpression="Product Type">
			</asp:boundfield>
			<asp:boundfield DataField="Rail Wt" HeaderText="Rail Wt" SortExpression="Rail Wt">
			</asp:boundfield>
			<asp:boundfield DataField="Car Comments" HeaderText="Car Comments" SortExpression="Car Comments">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Active Railcars with prereceiver info] WHERE ([Terminal] = @Terminal) ORDER BY [Client], [Profile], [Car Number]">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Terminal" PropertyName="SelectedValue" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
</form>

</body>

</html>
