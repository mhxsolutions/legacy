<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Today's Plan by Fleet and Driver</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Today's Plan by Driver</h3>
	<p>Date:
	<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="Plan_Date" DataValueField="Plan_Date">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Plan Date] AS Plan_Date FROM [Planned loads by fleet and driver for today] ORDER BY [Plan Date] DESC">
	</asp:SqlDataSource>
	</p>
	<p>Fleet:
	<asp:DropDownList id="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="Fleet" DataValueField="Fleet">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Fleet] FROM [Planned loads by fleet and driver for today] WHERE ([Plan Date] = @Plan_Date)">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Plan_Date" PropertyName="SelectedValue" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	</p>
	<p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" DataSourceID="SqlDataSource3" ForeColor="Black">
		<RowStyle BackColor="White" />
		<Columns>
			<asp:boundfield DataField="Driver" HeaderText="Driver" SortExpression="Driver">
			</asp:boundfield>
			<asp:boundfield DataField="Destination" HeaderText="Destination" SortExpression="Destination">
			</asp:boundfield>
			<asp:boundfield DataField="Sch_Arrive" DataFormatString="{0:t}" HeaderText="Sch Arrive" HtmlEncode="False" SortExpression="Sch_Arrive">
			</asp:boundfield>
			<asp:boundfield DataField="Load_Ref" HeaderText="Load" SortExpression="Load_Ref">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#CCCCCC" />
		<PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
		<SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
		<HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Driver], [Destination], [Sch Arrive] AS Sch_Arrive, [Load Ref] AS Load_Ref FROM [Planned loads by fleet and driver for today] WHERE (([Plan Date] = @Plan_Date) AND ([Fleet] = @Fleet))">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Plan_Date" PropertyName="SelectedValue" Type="String" />
			<asp:controlparameter ControlID="DropDownList2" Name="Fleet" PropertyName="SelectedValue" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	</p>
</form>
<p>&nbsp;</p>

</body>

</html>
