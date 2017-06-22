<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page Language="VB" %>
<html dir="ltr" xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Jeopardy</title>
<base target="_self" />
</head>

<body>

<form id="form1" runat="server">
<h3>Jeopardy</h3>
	<asp:GridView id="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Load" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Scheduled Arrival" HeaderText="Scheduled Arrival" SortExpression="Scheduled Arrival">
			</asp:boundfield>
			<asp:boundfield DataField="Close Time" HeaderText="Close Time" SortExpression="Close Time">
			</asp:boundfield>
			<asp:boundfield DataField="Driver" HeaderText="Driver" SortExpression="Driver">
			</asp:boundfield>
			<asp:boundfield DataField="Truck" HeaderText="Truck" SortExpression="Truck">
			</asp:boundfield>
			<asp:boundfield DataField="Destination" HeaderText="Destination" SortExpression="Destination">
			</asp:boundfield>
			<asp:boundfield DataField="Load" HeaderText="Load" ReadOnly="True" SortExpression="Load">
			</asp:boundfield>
			<asp:boundfield DataField="Log Out Time" HeaderText="Log Out Time" SortExpression="Log Out Time">
			</asp:boundfield>
			<asp:boundfield DataField="+Early/-Late" HeaderText="+Early/-Late" SortExpression="+Early/-Late">
			</asp:boundfield>
		</Columns>
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM vJeporadyToday">
	</asp:SqlDataSource>
</form>

</body>

</html>
