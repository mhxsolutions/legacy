<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Operations Audit Data</title>
<meta http-equiv="refresh" content="600" />

</head>

<body>

<form id="form1" runat="server">
	<table style="width: 100%">
		<tr>
			<td style="width: 305px">
			<asp:DataList id="DataList2" runat="server" DataSourceID="SqlDataSource2" RepeatLayout="Flow" ShowFooter="False" ShowHeader="False">
				<ItemTemplate>
					Loads without Revenue:
					<asp:label id="Loads_without_RevenueLabel" runat="server" Text='<%# Eval("Loads_without_Revenue") %>' Font-Bold="True" />
					<br />
					<br />
				</ItemTemplate>
			</asp:DataList>
			<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Loads without Revenue] AS Loads_without_Revenue FROM [Load Rev Summary count of loads without revenue]">
			</asp:SqlDataSource>
			</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td style="width: 305px">
			<asp:DataList id="DataList1" runat="server" DataSourceID="SqlDataSource1" RepeatLayout="Flow" ShowFooter="False" ShowHeader="False">
				<ItemTemplate>
					<a href="railcars_without_receivers.aspx">Railcars</a> 
					without receivers: &nbsp;<asp:label id="Count_of_RC_wout_recvLabel" runat="server" Font-Bold="True" Font-Size="Medium" Text='<%# Eval("Count_of_RC_wout_recv") %>' />
					<br />
					<br />
				</ItemTemplate>
			</asp:DataList>
			</td>
			<td>
			<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>" SelectCommand="SELECT [Count of RC wout recv] AS Count_of_RC_wout_recv FROM [railcars without receivers count]">
			</asp:SqlDataSource>
			</td>
		</tr>
		<tr>
			<td style="width: 305px">&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td style="width: 305px">&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td style="width: 305px">&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td style="width: 305px">&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td style="width: 305px">&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td style="width: 305px">&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
	</table>
</form>

</body>

</html>
