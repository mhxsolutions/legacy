<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<meta http-equiv="refresh" content="60" />
<title>Driver's Dwell</title>

<style type="text/css">
.style1 {
	text-align: left;
}
.style2 {
	text-align: center;
}
</style>

</head>

<body>

<form id="form1" runat="server">
	<h2>Drivers Waiting</h2>
	<p>
	<asp:GridView runat="server" id="GridView1" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" DataKeyNames="Client" ForeColor="#333333" CellPadding="4" GridLines="None" AllowSorting="True" Font-Size="X-Large">
		<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<Columns>
			<asp:boundfield DataField="Driver" SortExpression="Driver" HeaderText="Driver">
			</asp:boundfield>
			<asp:boundfield ReadOnly="True" DataField="Client" SortExpression="Client" HeaderText="Client">
			</asp:boundfield>
			<asp:boundfield DataField="Wait" SortExpression="Wait" HeaderText="Wait">
			</asp:boundfield>
		</Columns>
		<RowStyle BackColor="#EFF3FB" />
		<EditRowStyle BackColor="#2461BF" />
		<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Drivers Waiting all destinations] ORDER BY [Wait] DESC">
	</asp:SqlDataSource>
	</p>

<p><a target="_blank" href="drivers_waiting%20with%20notes.aspx">drivers_waiting 
with notes.aspx</a></p>

	<h2 class="style2">Fontana Coils Staged</h2>
	<p class="style1">
	<asp:DetailsView id="DetailsView1" runat="server" AutoGenerateRows="False" DataSourceID="SqlDataSource2" Height="50px" HorizontalAlign="Center" Width="125px">
		<RowStyle BackColor="Red" ForeColor="White" HorizontalAlign="Center" />
		<Fields>
			<asp:boundfield DataField="Percent_Staged" DataFormatString="{0:p0}" HeaderText="Percent_Staged" HtmlEncode="False" ReadOnly="True" ShowHeader="False" SortExpression="Percent_Staged">
				<ItemStyle Font-Bold="True" Font-Size="XX-Large" />
			</asp:boundfield>
		</Fields>
	</asp:DetailsView>
	</p>
	<h3 class="style2">of <a href="coils_shipped_vs_staged.aspx">all coils 
	shipped</a> today.</h3>
	<p>
	<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Percent Staged] AS Percent_Staged FROM [Coils Shipped v Staged Percent Today]">
	</asp:SqlDataSource>
	</p>
	<hr />

<h3 class="style2">Fontana Loads Staged</h3>

	<div class="style2">
	<asp:GridView id="GridView2" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource3" CellPadding="4" ForeColor="#333333" GridLines="None">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Date" DataFormatString="{0:d}" HeaderText="Date" HtmlEncode="False" SortExpression="Date">
			</asp:boundfield>
			<asp:boundfield DataField="Percent" DataFormatString="{0:p0}" HeaderText="Percent" HtmlEncode="False" ReadOnly="True" SortExpression="Percent">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	</div>

	<p class="style2">of loads completed.</p>
	<br />
	<asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Date], [Percent] FROM [Staged Loads Origin Fontana with percent] ORDER BY [Date] DESC">
	</asp:SqlDataSource>
</form>

</body>

</html>
