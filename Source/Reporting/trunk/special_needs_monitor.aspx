<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Special Needs Monitor</title>
<meta http-equiv="refresh" content="120" />

</head>

<body>

<form id="form1" runat="server">
	<h3>Special Needs Monitor (auto update)</h3>
	<p>Terminal:
	<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource3" DataTextField="Fleet" DataValueField="Fleet">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Fleet] FROM [Fleet] ORDER BY [Fleet ID]">
	</asp:SqlDataSource>
	</p>
	<asp:GridView runat="server" id="GridView1" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" ForeColor="#333333" CellPadding="4" GridLines="None" AllowSorting="True">
		<FooterStyle BackColor="#990000" ForeColor="White" Font-Bold="True" />
		<Columns>
			<asp:boundfield DataField="Special Need" SortExpression="Special Need" HeaderText="Special Need">
			</asp:boundfield>
			<asp:boundfield DataField="Client" SortExpression="Client" HeaderText="Client">
			</asp:boundfield>
			<asp:boundfield ReadOnly="True" DataField="Destination" SortExpression="Destination" HeaderText="Destination">
			</asp:boundfield>
			<asp:boundfield DataField="Load" SortExpression="Load" HeaderText="Load">
			</asp:boundfield>
			<asp:boundfield ReadOnly="True" DataField="Plan Date" SortExpression="Plan Date" HeaderText="Plan Date">
			</asp:boundfield>
			<asp:boundfield HtmlEncode="False" DataFormatString="{0:t}" DataField="Sch Arrive" SortExpression="Sch Arrive" HeaderText="Sch Arrive">
			</asp:boundfield>
			<asp:boundfield DataField="LoadNotes" SortExpression="LoadNotes" HeaderText="LoadNotes">
			</asp:boundfield>
			<asp:boundfield HtmlEncode="False" DataFormatString="{0:t}" DataField="LogOutTime" SortExpression="LogOutTime" HeaderText="LogOutTime">
			</asp:boundfield>
			<asp:boundfield HtmlEncode="False" DataFormatString="{0:t}" DataField="POD Time" SortExpression="POD Time" HeaderText="POD Time">
			</asp:boundfield>
		</Columns>
		<RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
		<SelectedRowStyle BackColor="#FFCC66" ForeColor="Navy" Font-Bold="True" />
		<PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
		<HeaderStyle BackColor="#990000" ForeColor="White" Font-Bold="True" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Special Needs Monitoring] WHERE ([Fleet] = @Fleet) ORDER BY [Special Need], [Client], [Destination]">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Fleet" PropertyName="SelectedValue" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	<h3>Special Needs Preview</h3>
	<asp:GridView runat="server" id="GridView2" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" GridLines="None" ForeColor="#333333" CellPadding="4" AllowSorting="True">
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Special Need" HeaderText="Special Need" SortExpression="Special Need">
			</asp:boundfield>
			<asp:boundfield DataField="Client" HeaderText="Client" SortExpression="Client">
			</asp:boundfield>
			<asp:boundfield DataField="Destination" HeaderText="Destination" ReadOnly="True" SortExpression="Destination">
			</asp:boundfield>
			<asp:boundfield DataField="Load" HeaderText="Load" SortExpression="Load">
			</asp:boundfield>
			<asp:boundfield DataField="Load Date" DataFormatString="{0:d}" HeaderText="Load Date" HtmlEncode="False" ReadOnly="True" SortExpression="Load Date">
			</asp:boundfield>
			<asp:boundfield DataField="Planned Arv" DataFormatString="{0:t}" HeaderText="Planned Arv" HtmlEncode="False" SortExpression="Planned Arv">
			</asp:boundfield>
			<asp:boundfield DataField="LoadNotes" HeaderText="LoadNotes" SortExpression="LoadNotes">
			</asp:boundfield>
		</Columns>
		<PagerStyle HorizontalAlign="Center" BackColor="#2461BF" ForeColor="White" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Special Needs Preview] WHERE ([Fleet] = @Fleet)">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Fleet" PropertyName="SelectedValue" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
</form>

</body>

</html>
