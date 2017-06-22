<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page Language="VB" %>
<html dir="ltr" xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Tomorrow's Plan</title>
</head>

<body>

<form id="form2" runat="server">
<h1>Tomorrow's Plan</h1>

	<asp:GridView id="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Shipping Client" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Plan Date" DataFormatString="{0:MM/dd/yy}" HeaderText="Plan Date" SortExpression="Plan Date">
			</asp:boundfield>
			<asp:boundfield DataField="Shipping Client" HeaderText="Shipping Client" ReadOnly="True" SortExpression="Shipping Client">
			</asp:boundfield>
			<asp:boundfield DataField="Count" HeaderText="Count" SortExpression="Count">
			</asp:boundfield>
		</Columns>
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [webPlannerToday Grand Sum Tomorrow]">
	</asp:SqlDataSource>
</form>

</body>

</html>
