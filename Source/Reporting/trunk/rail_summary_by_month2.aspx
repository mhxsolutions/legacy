
<% @Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<script runat="server">
    int TotalCount = 0;
    int GetCount(int Count)
    {
        TotalCount += Count;
        return Count;
    }
    int GetTotalCount()
    {
        return TotalCount;
    }
</script>

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Rail Summary by Month and Terminal</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Rail Summary by Month and Terminal</h3>
	<p>&nbsp;</p>
	<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="Year" DataValueField="Year">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Year] FROM [Rail Summary by year and month] ORDER BY [Year] DESC">
	</asp:SqlDataSource>
	<asp:DropDownList id="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="Month" DataValueField="Month">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Month] FROM [Rail Summary by year and month] WHERE [Year] = @Year ORDER BY [Month] DESC">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Year" PropertyName="SelectedValue" Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:DropDownList id="DropDownList3" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource4" DataTextField="Terminal" DataValueField="Terminal">
		<asp:ListItem value="Fontana" selected="True">Fontana</asp:ListItem>
		<asp:ListItem value="New Jersey">New Jersey</asp:ListItem>
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Terminal] FROM [Rail Summary by year and month] WHERE (([Year] = @Year) AND ([Month] = @Month)) ORDER BY [Terminal]">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Year" PropertyName="SelectedValue" Type="Int32" />
			<asp:controlparameter ControlID="DropDownList2" Name="Month" PropertyName="SelectedValue" Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" 
	    DataSourceID="SqlDataSource3" ForeColor="#333333" GridLines="None" ShowFooter="True">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Client" HeaderText="Client" SortExpression="Client">
			</asp:boundfield>
			<asp:boundfield DataField="Shipper" HeaderText="Shipper" SortExpression="Shipper">
			</asp:boundfield>
			<asp:boundfield DataField="Commodity" HeaderText="Commodity" SortExpression="Commodity">
			</asp:boundfield>
			<asp:boundfield DataField="Carrier" HeaderText="Carrier" SortExpression="Carrier">
			</asp:boundfield>
            <asp:TemplateField HeaderText="Count" SortExpression="Count" FooterStyle-Font-Bold="True">
                <ItemTemplate>
                    <%# GetCount(int.Parse(Eval("Count").ToString())).ToString() %>
                </ItemTemplate>
                <FooterTemplate>
                    <%# GetTotalCount().ToString() %>
                </FooterTemplate>

<FooterStyle Font-Bold="True"></FooterStyle>
            </asp:TemplateField>
		</Columns>
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Rail Summary by year and month] WHERE (([Year] = @Year) AND ([Month] = @Month) AND ([Terminal] = @Terminal)) ORDER BY [Client], [Shipper], [Commodity]">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Year" PropertyName="SelectedValue" Type="Int32" />
			<asp:controlparameter ControlID="DropDownList2" Name="Month" PropertyName="SelectedValue" Type="Int32" />
			<asp:controlparameter ControlID="DropDownList3" Name="Terminal" PropertyName="SelectedValue" Type="string" />
		</SelectParameters>
	</asp:SqlDataSource>
</form>

</body>

</html>
