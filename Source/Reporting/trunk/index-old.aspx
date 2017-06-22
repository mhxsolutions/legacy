<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>Untitled 1</title>
<base target="main" />
</head>

<body>

<form id="form1" runat="server">
	<asp:TreeView runat="server" id="TreeView1">
		<Nodes>
			<asp:treenode Text="Mobile" Value="Demurrage">
				<asp:treenode Text="Detention" Value="Detention">
					<asp:treenode NavigateUrl="budway_phonebased_dwell.asp" Text="Fontana" Value="Fontana">
						<asp:treenode NavigateUrl="budway_detention_excess.asp" Text="Excess" Value="Excess">
						</asp:treenode>
						<asp:treenode NavigateUrl="budway_detention_daily_average.asp" Text="Daily Avg" Value="Daily Avg">
						</asp:treenode>
						<asp:treenode NavigateUrl="budway_detention_weekly_average.asp" Text="Weekly Avg" Value="Weekly Avg">
						</asp:treenode>
					</asp:treenode>
					<asp:treenode NavigateUrl="excess_detention_15_day_x_top_30.asp" Text="Clients" Value="Clients">
						<asp:treenode Text="Harbor" Value="Harbor">
							<asp:treenode NavigateUrl="harbor_detention_monthly_average.asp" Text="Monthly" Value="Monthly">
							</asp:treenode>
							<asp:treenode NavigateUrl="harbor_detention_weekly_average.asp" Text="Weekly" Value="Weekly">
							</asp:treenode>
							<asp:treenode NavigateUrl="harbor_detention_driver_weekly_a.asp" Text="Driver" Value="Driver">
							</asp:treenode>
						</asp:treenode>
						<asp:treenode Text="Douglas" Value="Douglas">
						</asp:treenode>
						<asp:treenode Text="Lex West" Value="Lex West">
						</asp:treenode>
						<asp:treenode Text="W Tube" Value="W Tube">
						</asp:treenode>
					</asp:treenode>
				</asp:treenode>
				<asp:treenode Text="Planner" Value="Planner">
				</asp:treenode>
				<asp:treenode Text="Harbor" Value="Harbor">
				</asp:treenode>
				<asp:treenode Text="New Node" Value="New Node">
				</asp:treenode>
			</asp:treenode>
		</Nodes>
	</asp:TreeView>
</form>

</body>

</html>
