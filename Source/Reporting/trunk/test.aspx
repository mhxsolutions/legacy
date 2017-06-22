<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>test</title>
</head>

<body>

<form id="form1" runat="server">
	<p>test</p>
	<p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="ID" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:commandfield ShowEditButton="True">
			</asp:commandfield>
			<asp:boundfield DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID">
			</asp:boundfield>
			<asp:checkboxfield DataField="flag" HeaderText="flag" SortExpression="flag">
			</asp:checkboxfield>
			<asp:boundfield DataField="note" HeaderText="note" ReadOnly="True" SortExpression="note">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" DeleteCommand="DELETE FROM [a test table] WHERE [ID] = @original_ID AND (([flag] = @original_flag) OR ([flag] IS NULL AND @original_flag IS NULL)) AND (([note] = @original_note) OR ([note] IS NULL AND @original_note IS NULL))" InsertCommand="INSERT INTO [a test table] ([flag], [note]) VALUES (@flag, @note)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [a test table]" UpdateCommand="UPDATE [a test table] SET [flag] = @flag, [note] = @note WHERE [ID] = @original_ID AND (([flag] = @original_flag) OR ([flag] IS NULL AND @original_flag IS NULL)) AND (([note] = @original_note) OR ([note] IS NULL AND @original_note IS NULL))">
		<DeleteParameters>
			<asp:parameter Name="original_ID" Type="Int32" />
			<asp:parameter Name="original_flag" Type="Boolean" />
			<asp:parameter Name="original_note" Type="String" />
		</DeleteParameters>
		<UpdateParameters>
			<asp:parameter Name="flag" Type="Boolean" />
			<asp:parameter Name="note" Type="String" />
			<asp:parameter Name="original_ID" Type="Int32" />
			<asp:parameter Name="original_flag" Type="Boolean" />
			<asp:parameter Name="original_note" Type="String" />
		</UpdateParameters>
		<InsertParameters>
			<asp:parameter Name="flag" Type="Boolean" />
			<asp:parameter Name="note" Type="String" />
		</InsertParameters>
	</asp:SqlDataSource>
	</p>
</form>

</body>

</html>
