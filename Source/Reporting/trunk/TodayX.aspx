<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Today</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Today's Shipper Summary</h3>
    <p>
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2"
            DataTextField="fleet" DataValueField="fleet">
        </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT DISTINCT [fleet] FROM [webPlannerToday Grand Sum Today] ORDER BY [fleet]">
        </asp:SqlDataSource>
    </p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
            <asp:BoundField DataField="Plan_Date" DataFormatString="{0:d}" HeaderText="Plan_Date"
                HtmlEncode="False" SortExpression="Plan_Date" />
            <asp:BoundField DataField="Shipping_Client" HeaderText="Shipping_Client" SortExpression="Shipping_Client" />
            <asp:BoundField DataField="Count" HeaderText="Count" SortExpression="Count" />
		</Columns>
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Plan Date] AS Plan_Date, [Shipping Client] AS Shipping_Client, [Count] FROM [webPlannerToday Grand Sum Today] WHERE ([fleet] = @fleet)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="fleet" PropertyName="SelectedValue"
                Type="String" />
        </SelectParameters>
	</asp:SqlDataSource>
</form>

<h3><a href="Todays_Plan_Summary.aspx">Today's Destination Summary</a></h3>

</body>

</html>
