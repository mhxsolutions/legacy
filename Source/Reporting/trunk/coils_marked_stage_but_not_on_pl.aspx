<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Bad Staging</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Coils Marked Stage but Not On Plan</h3>
	<asp:GridView runat="server" id="GridView1" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" ForeColor="#333333" CellPadding="4" GridLines="None">
		<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<Columns>
			<asp:boundfield DataField="Bad_Stage" SortExpression="Bad_Stage" HeaderText="Bad_Stage">
			</asp:boundfield>
		</Columns>
		<RowStyle BackColor="#EFF3FB" />
		<EditRowStyle BackColor="#2461BF" />
		<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Bad Stage] AS Bad_Stage FROM [Coils staged but not on plan summary]">
	</asp:SqlDataSource>
	<h3>Details</h3>
	<asp:GridView runat="server" id="GridView2" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" DataKeyNames="COIL,LOAD" ForeColor="#333333" CellPadding="4" GridLines="None" AllowSorting="True">
		<FooterStyle BackColor="#1C5E55" ForeColor="White" Font-Bold="True" />
		<Columns>
			<asp:boundfield ReadOnly="True" DataField="COIL" SortExpression="COIL" HeaderText="COIL">
			</asp:boundfield>
			<asp:boundfield DataField="LOC" SortExpression="LOC" HeaderText="LOC">
			</asp:boundfield>
			<asp:boundfield ReadOnly="True" DataField="LOAD" SortExpression="LOAD" HeaderText="LOAD">
			</asp:boundfield>
			<asp:boundfield DataField="StageTime" SortExpression="StageTime" HeaderText="StageTime">
			</asp:boundfield>
		</Columns>
		<RowStyle BackColor="#E3EAEB" />
		<EditRowStyle BackColor="#7C6F57" />
		<SelectedRowStyle BackColor="#C5BBAF" ForeColor="#333333" Font-Bold="True" />
		<PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
		<HeaderStyle BackColor="#1C5E55" ForeColor="White" Font-Bold="True" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Coils Staged but not on plan]">
	</asp:SqlDataSource>
</form>

</body>

</html>
