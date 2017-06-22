<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page Language="VB" %>
<html dir="ltr" xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Pending Railcars</title>
</head>

<body>

<form id="form1" runat="server">
<h3>Pending Railcars</h3>
	<asp:GridView id="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Status" HeaderText="Status" SortExpression="Status">
			</asp:boundfield>
			<asp:boundfield DataField="Shipper" HeaderText="Shipper" SortExpression="Shipper">
			</asp:boundfield>
			<asp:boundfield DataField="Product Type" HeaderText="Product Type" SortExpression="Product Type">
			</asp:boundfield>
			<asp:boundfield DataField="S" HeaderText="Load/Empty" SortExpression="S">
			</asp:boundfield>
			<asp:boundfield DataField="Dest" HeaderText="Destination" SortExpression="Dest">
			</asp:boundfield>
			<asp:boundfield DataField="bnsfuprr" HeaderText="Line" SortExpression="bnsfuprr">
			</asp:boundfield>
			<asp:boundfield DataField="Ct" HeaderText="Ct" SortExpression="Ct">
			</asp:boundfield>
		</Columns>
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" SelectCommand="SELECT * FROM wPendingRailCars">
	</asp:SqlDataSource>
</form>

</body>

</html>
