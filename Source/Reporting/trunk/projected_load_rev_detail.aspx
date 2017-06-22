<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Projected Load Rev Detail</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Projected Load Rev Detail</h3>
	<p><a href="default.aspx">home</a>&nbsp;&nbsp;&nbsp; <a href="rick2.html">
	back</a></p>
	<p><strong>Date to Review</strong><asp:Calendar id="Calendar1" runat="server" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" Width="220px">
		<SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
		<SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
		<WeekendDayStyle BackColor="#CCCCFF" />
		<TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
		<OtherMonthDayStyle ForeColor="#999999" />
		<NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
		<DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
		<TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
	</asp:Calendar>
	</p>
	<p><strong>Fleet:</strong>
	<asp:DropDownList id="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource3" DataTextField="Fleet" DataValueField="Fleet">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Fleet] FROM [Load Rev Projection Detail] WHERE ([Date] = @Date) ORDER BY [Fleet]">
		<SelectParameters>
			<asp:controlparameter ControlID="Calendar1" Name="Date" PropertyName="SelectedDate" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	</p>
	<asp:GridView runat="server" id="GridView1" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" DataKeyNames="Load" ForeColor="#333333" CellPadding="4" GridLines="None" AllowSorting="True">
		<FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<Columns>
			<asp:boundfield ReadOnly="True" DataField="Date" SortExpression="Date" HeaderText="Date" DataFormatString="{0:d}">
			</asp:boundfield>
			<asp:boundfield ReadOnly="True" DataField="Load" SortExpression="Load" HeaderText="Load">
			</asp:boundfield>
			<asp:boundfield DataField="RFS ref" HeaderText="RFS" SortExpression="RFS ref">
			</asp:boundfield>
			<asp:boundfield HtmlEncode="False" DataFormatString="{0:c}" ReadOnly="True" DataField="Load Rev" SortExpression="Load Rev" HeaderText="Load Rev">
			</asp:boundfield>
			<asp:boundfield ReadOnly="True" DataField="Origin" SortExpression="Origin" HeaderText="Origin">
			</asp:boundfield>
			<asp:boundfield ReadOnly="True" DataField="Destination" SortExpression="Destination" HeaderText="Destination">
			</asp:boundfield>
		</Columns>
		<RowStyle BackColor="#EFF3FB" />
		<EditRowStyle BackColor="#2461BF" />
		<SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<HeaderStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Load Rev Projection Detail] WHERE (([Date] = @Date) AND ([Fleet] = @Fleet))">
		<SelectParameters>
			<asp:controlparameter ControlID="Calendar1" Name="Date" PropertyName="SelectedDate" Type="String" />
			<asp:controlparameter ControlID="DropDownList2" Name="Fleet" PropertyName="SelectedValue" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
</form>

<p>&nbsp;</p>

</body>

</html>
