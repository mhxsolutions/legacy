<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Transit Times - City to City Ave</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Transit Times - City to City Average</h3>
	<p>Origin:
	<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="OCity" DataValueField="OCity">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [OCity] FROM [City Transit Averages] ORDER BY [OCity]">
	</asp:SqlDataSource>
	</p>
	<p>&nbsp;</p>
	<p>Destination:
	<asp:DropDownList id="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="DCity" DataValueField="DCity">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [DCity] FROM [City Transit Averages] WHERE ([OCity] = @OCity) ORDER BY [DCity]">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="OCity" PropertyName="SelectedValue" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	</p>
	<p>&nbsp;</p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="OCity,DCity" DataSourceID="SqlDataSource3" ForeColor="#333333" GridLines="None">
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="OCity" HeaderText="OCity" ReadOnly="True" SortExpression="OCity">
			</asp:boundfield>
			<asp:boundfield DataField="DCity" HeaderText="DCity" ReadOnly="True" SortExpression="DCity">
			</asp:boundfield>
			<asp:boundfield DataField="AvgTransit" DataFormatString="{0:f1}" HeaderText="AvgTransit" HtmlEncode="False" SortExpression="AvgTransit">
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
	<asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" SelectCommand="SELECT [OCity], [DCity], [AvgTransit], [Count] FROM [City Transit Averages] WHERE (([OCity] = @OCity) AND ([DCity] = @DCity)) ORDER BY [OCity], [DCity]">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="OCity" PropertyName="SelectedValue" Type="String" />
			<asp:controlparameter ControlID="DropDownList2" Name="DCity" PropertyName="SelectedValue" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
</form>

</body>

</html>
