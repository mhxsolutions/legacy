<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page Language="VB" %>
<html dir="ltr" xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Driver Count Report</title>
<base target="rtop" />
</head>

<body>

<form id="form1" runat="server">
<h3>Driver Count Report</h3>
	<asp:GridView id="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="LogOutDate" DataFormatString="{0:MM/dd/yy}" HeaderText="Date" SortExpression="LogOutDate">
			</asp:boundfield>
			<asp:boundfield DataField="Staff Drivers" HeaderText="Staff Drivers" SortExpression="Staff Drivers">
			</asp:boundfield>
			<asp:boundfield DataField="Planned Drivers" HeaderText="Planned Drivers" SortExpression="Planned Drivers">
			</asp:boundfield>
			<asp:boundfield DataField="Active Drivers" HeaderText="Active Drivers" SortExpression="Active Drivers">
			</asp:boundfield>
		</Columns>
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM webDriverCounts">
	</asp:SqlDataSource>
</form>

</body>

</html>
