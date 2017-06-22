<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Planned Load Revenue Detail</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Planned Load Revenue Detail</h3>
	<asp:GridView id="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" PageSize="25">
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Plan Date" DataFormatString="{0:d}" HeaderText="Plan Date" HtmlEncode="False" SortExpression="Plan Date">
			</asp:boundfield>
			<asp:boundfield DataField="RFS ref" HeaderText="RFS ref" SortExpression="RFS ref">
			</asp:boundfield>
			<asp:boundfield DataField="Client" HeaderText="Client" ReadOnly="True" SortExpression="Client">
			</asp:boundfield>
			<asp:boundfield DataField="Origin" HeaderText="Origin" ReadOnly="True" SortExpression="Origin">
			</asp:boundfield>
			<asp:boundfield DataField="Destination" HeaderText="Destination" ReadOnly="True" SortExpression="Destination">
			</asp:boundfield>
			<asp:boundfield DataField="Rev" DataFormatString="{0:c}" HeaderText="Rev" HtmlEncode="False" SortExpression="Rev">
			</asp:boundfield>
			<asp:boundfield DataField="Rev/Min" DataFormatString="{0:c}" HeaderText="Rev/Min" HtmlEncode="False" ReadOnly="True" SortExpression="Rev/Min">
			</asp:boundfield>
		</Columns>
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Load Rev Planned by RFS detail] WHERE (([Year] = @Year) AND ([Month] = @Month) AND ([RFS ref] = @RFS_ref))">
		<SelectParameters>
			<asp:querystringparameter Name="Year" QueryStringField="year" Type="Int32" />
			<asp:querystringparameter Name="Month" QueryStringField="month" Type="Int32" />
			<asp:querystringparameter Name="RFS_ref" QueryStringField="rfsref" Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
</form>

<p>Note: This report is based on planned reposition + planned load dwell + 
planned transit + planned delivery dwell.</p>

</body>

</html>
