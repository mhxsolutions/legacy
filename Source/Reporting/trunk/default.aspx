<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<meta name="viewport" content="width=640" />
<title>Budway Reports</title>
<base target="main" />
<style type="text/css">
.style1 {
	margin-right: 5px;
}
</style>
</head>

<body>

<form id="form1" runat="server">
	<h2>Budway Reports</h2>
	<asp:TreeView runat="server" id="TreeView1" Width="382px" CssClass="style1" ExpandDepth="1">
		<ParentNodeStyle Font-Bold="True" />
		<Nodes>
			<asp:treenode Text="Dashboards" Value="Dashboards" NavigateUrl="http://budwaydirect.com/dashboards/">
				<asp:treenode NavigateUrl="Frames Page.htm" Target="main" Text="Dispatch" Value="Dispatch">
				</asp:treenode>
				<asp:treenode NavigateUrl="Budway kpi2.htm" Text="Load Revenue" Value="Load Revenue">
				</asp:treenode>
				<asp:treenode NavigateUrl="Budway kpi.htm" Text="Budway KPI" Value="Budway KPI">
				</asp:treenode>
				<asp:treenode NavigateUrl="OPSKPI.htm" Text="Operations KPI" Value="Operations KPI">
				</asp:treenode>
				<asp:treenode NavigateUrl="http://budwaydirect.com/dashboards" Text="Gages Menu" Value="Gages">
				</asp:treenode>
			</asp:treenode>
			<asp:treenode Text="Links" Value="Links">
				<asp:treenode NavigateUrl="http://webmail.mailtrust.com" Text="New Email" Value="New Email">
				</asp:treenode>
				<asp:treenode NavigateUrl="Mobile.htm" Text="Mobile Reports" Value="Mobile Reports">
				</asp:treenode>
				<asp:treenode NavigateUrl="rick2.html" Text="Planner Review Tools" Value="Planner Review Tools">
				</asp:treenode>
			</asp:treenode>
			<asp:treenode SelectAction="Expand" Text="Gages" Value="Gages" NavigateUrl="/dahsboards">
				<asp:treenode NavigateUrl="/Dashboards/DashboardRealTimeDwellTimes.aspx" Text="Dwell @ Fontana" Value="Dwell @ Fontana">
				</asp:treenode>
				<asp:treenode NavigateUrl="/Dashboards/DashboardKpiThroughputDwellAndRevenue.aspx" Text="Revenue" Value="Revenue">
				</asp:treenode>
			</asp:treenode>
			<asp:treenode Text="SOP" Value="SOP">
				<asp:treenode NavigateUrl="Invoice Error flow chart.htm" Text="Credit Invoice" Value="Credit Invoice">
				</asp:treenode>
			</asp:treenode>
			<asp:treenode Text="Status" Value="Status">
				<asp:treenode NavigateUrl="Driver Status.htm" Text="Drivers" Value="Drivers">
				</asp:treenode>
				<asp:treenode NavigateUrl="rfs_invoice_process_summary.aspx" Text="Invoicing" Value="Invoicing">
				</asp:treenode>
			</asp:treenode>
			<asp:treenode Text="Systems" Value="Systems">
				<asp:treenode NavigateUrl="http://budwaydirect.com/accweb" Text="Accounting Web" Value="Accounting Web">
				</asp:treenode>
				<asp:treenode NavigateUrl="http://budwaydirect.com/bopsweb" Text="BOPS - Budway Operations" Value="BOPS - Budway Operations">
				</asp:treenode>
				<asp:treenode NavigateUrl="http://budwaydirect.com/copsweb" Text="COPS - Customer Site" Value="COPS - Customer Site">
				</asp:treenode>
			</asp:treenode>
			<asp:treenode Text="Reports" Value="Reports" SelectAction="Expand">
				<asp:treenode NavigateUrl="planned_minutes_by_month.aspx" Text="Booked Minutes" Value="Booked Minutes">
				</asp:treenode>
				<asp:treenode NavigateUrl="booked_throughput.aspx" Text="Booked Thruput" Value="Booked Thruput">
				</asp:treenode>
				<asp:treenode NavigateUrl="driver_meal_breaks.aspx" Text="Drivers' Breaks" Value="Driver Breaks">
				</asp:treenode>
				<asp:treenode NavigateUrl="drivers_hours_of_service.aspx" Text="Drivers' Hours of Service" Value="Drivers' Hours of Service">
				</asp:treenode>
				<asp:TreeNode NavigateUrl="driver_loads_review.aspx" Text="Drivers' Loads Review" Value="Drivers' Loads Review">
				</asp:TreeNode>
				<asp:treenode NavigateUrl="drivermin.aspx" Text="Drivers' Minutes" Value="Driver's Minutes">
				</asp:treenode>
				<asp:treenode NavigateUrl="driver_phone_time_reporting_audi.aspx" Text="Drivers' Missing Phone times" Value="Drivers missing Phone times">
				</asp:treenode>
				<asp:treenode NavigateUrl="driver_revenue.aspx" Text="Drivers' Revenue by Day" Value="Drivers' Revenue">
				</asp:treenode>
				<asp:treenode NavigateUrl="driver_revenue_by_period.aspx" Text="Drivers' Revenue by Period" Value="Drivers' Revenue by Period">
				</asp:treenode>
				<asp:treenode NavigateUrl="driver_performance.aspx" Text="Drivers Under/Over Plan" Value="Drivers Under/Over Plan">
				</asp:treenode>
				<asp:treenode NavigateUrl="error check driver match.aspx" Text="Error Chk - Planned Driver &lt;&gt; Assigned Driver" Value="Error Chk - Planned Driver &lt;&gt; Assigned Driver">
				</asp:treenode>
				<asp:treenode NavigateUrl="rfs_assigned_to_loads_wout_rev.aspx" Text="Error Chk - RFS without Load Rev" Value="RFS without Load Rev">
				</asp:treenode>
				<asp:treenode NavigateUrl="eq_info.aspx" Text="EQ Info" Value="EQ Info">
				</asp:treenode>
				<asp:treenode Text="Inventory by Client" Value="Inventory by Client" Expanded="True">
					<asp:treenode NavigateUrl="current_inv.aspx" Text="with pending BOLs" Value="Inventory by Client with pending BOLs">
					</asp:treenode>
					<asp:treenode NavigateUrl="current_inventory_summary.aspx" Text="with pending BOLs Summary with LnFt" Value="Inventory by Client with pending BOLs summarized">
					</asp:treenode>
					<asp:treenode NavigateUrl="current_inventory_summary_locations.aspx" Text="with pending BOLs Summary by Location" Value="Inventory by Client with pending BOL by Location">
					</asp:treenode>
				</asp:treenode>
				<asp:treenode NavigateUrl="invoice_info.aspx" Text="Invoice Information by Date" Value="Invoice Information by Date">
				</asp:treenode>
				<asp:treenode NavigateUrl="invoice_with_upi_bol_detail.aspx" Text="Invoice with UPI BOL Detail" Value="Invoice with UPI BOL Detail">
				</asp:treenode>
				<asp:treenode NavigateUrl="KPI summary.aspx" Text="KPI Ops Zero Summary" Value="KPI Ops Summary">
				</asp:treenode>
				<asp:treenode NavigateUrl="load count.aspx" Text="Load Count by Day and Terminal" Value="Load Count">
				</asp:treenode>
				<asp:treenode NavigateUrl="load_to_rfs_invoice_xref.aspx" Text="Load to RFS Invoice xref" Value="Load to RFS Invoice xref">
				</asp:treenode>
				<asp:treenode NavigateUrl="loads_for_delivery.aspx" Text="Loads Pending Delivery" Value="Loads For Delivery" ToolTip="no log out">
				</asp:treenode>
				<asp:treenode NavigateUrl="special_needs_monitor.aspx" Text="Loads with Special Needs" Value="Loads with Special Needs">
				</asp:treenode>
				<asp:treenode NavigateUrl="nucor_receivers.aspx" Text="Nucor Receiver Data" Value="Nucor Receiver Data">
				</asp:treenode>
				<asp:treenode NavigateUrl="analyze_transit_and_dwell_data.aspx" Text="O/D pair Actual Times" Value="O/D pair Actual Times">
				</asp:treenode>
				<asp:treenode NavigateUrl="audit_od_pair_transit_and_dwell.aspx" Text="O/D pair Planned Times" Value="O/D pair Planned Times">
				</asp:treenode>
				<asp:treenode NavigateUrl="opsdetail.aspx" Text="Operations Audit Data" Value="Operations Audit Data">
				</asp:treenode>
				<asp:treenode NavigateUrl="p2p_daily_breakout.aspx" Text="P2P Daily Breakout" Value="P2P Daily Breakout">
				</asp:treenode>
				<asp:treenode NavigateUrl="evaluate_actual_time_and_revenue.aspx" Text="Performance Evaluation by Destination" Value="Performance Evaluation">
				</asp:treenode>
				<asp:treenode NavigateUrl="plan.aspx" Text="Plan by Fleet" Value="Plan by Terminal">
				</asp:treenode>
				<asp:treenode NavigateUrl="planned_loads_history.aspx" Text="Plan History by Fleet" Value="Plan History by Fleet">
				</asp:treenode>
				<asp:treenode NavigateUrl="planinfo.aspx" Text="Plan Info" Value="Plan Info">
				</asp:treenode>
				<asp:treenode NavigateUrl="evaluate_planed_revenue.aspx" Text="Plan Transit, Dwell, Throughput Evaluation by Destination" Value="Plan Evaluation">
				</asp:treenode>
				<asp:treenode NavigateUrl="audit_od_pair_transit_and_dwell.aspx" Text="Planned Load Revenue by Driver" Value="Planned Revenue by Driver">
				</asp:treenode>
				<asp:treenode NavigateUrl="planned_load_revenue_by_rfs.aspx" Text="Planned Load Revenue by RFS" Value="Planned Revenue by RFS">
				</asp:treenode>
				<asp:treenode NavigateUrl="planned_monthly_load_rev_by_rfs.aspx" Text="Planned Load Revenue by RFS (monhly)" Value="Planned Revenue by RFS (monhly)">
				</asp:treenode>
				<asp:treenode NavigateUrl="projected_load_rev_detail.aspx" Text="Planned Load Revenue Detail" Value="Planned Load Revenue Detail">
				</asp:treenode>
				<asp:treenode NavigateUrl="compare actual plan to saved plan.aspx" Text="Planned Load Shipper Summary" Value="Planned Load Shipper Summary">
				</asp:treenode>
				<asp:treenode NavigateUrl="planned_minutes_by_month.aspx" Text="Planned Minutes" Value="Planned Minutes">
				</asp:treenode>
				<asp:treenode Text="Rail Reports" Value="Rail Reports" Expanded="True" SelectAction="SelectExpand" ShowCheckBox="False">
					<asp:treenode NavigateUrl="rail__client_preferred_date.aspx" Text="Client Preferred Date" Value="Client Preferred Date">
					</asp:treenode>
					<asp:treenode NavigateUrl="active_railcars_with_prereceive.aspx" Text="Rail Details - Current" Value="Railcar Details - Current">
					</asp:treenode>
					<asp:treenode NavigateUrl="rail_placements_by_date.aspx" Text="Rail Placement by Date" Value="Rail Placement by Date">
					</asp:treenode>
					<asp:treenode NavigateUrl="rail_detail.aspx" Text="Rail Preferred Date" Value="Rail Preferred Date">
					</asp:treenode>
					<asp:treenode NavigateUrl="rail_summary.aspx" Text="Rail Summary - Current" Value="Rail Summary">
					</asp:treenode>
					<asp:treenode NavigateUrl="rail_summary_by_month2.aspx" Text="Rail Summary by Month" Value="Rail Summary by Month">
					</asp:treenode>
					<asp:treenode NavigateUrl="railcars_without_receivers.aspx" Text="Railcars without Receivers" Value="Railcars without Receivers">
					</asp:treenode>
				</asp:treenode>
				<asp:treenode Text="Raritan" Value="Raritan" Expanded="True">
					<asp:treenode NavigateUrl="raritan_inventory.aspx" Text="Inventory" Value="Raritan Inventory">
					</asp:treenode>
					<asp:treenode NavigateUrl="raritan_load_history.aspx" Text="Load History" Value="Load History">
					</asp:treenode>
					<asp:treenode NavigateUrl="raritan__missing_pods.aspx" Text="Missing PODs" Value="Raritan - Missing PODs">
					</asp:treenode>
					<asp:treenode NavigateUrl="raritan_open_bols.aspx" Text="Open BOLs" Value="Raritan - Open BOLs">
					</asp:treenode>
					<asp:treenode NavigateUrl="raritan_receivers.aspx" Text="Receivers" Value="Receivers">
					</asp:treenode>
				</asp:treenode>
				<asp:treenode NavigateUrl="rfs_audit.aspx" Text="RFS Audit" Value="RFS Audit">
				</asp:treenode>
				<asp:treenode NavigateUrl="rfs_list_with_expiration.aspx" Text="RFS Expirations" Value="RFS Expirations">
				</asp:treenode>
				<asp:treenode NavigateUrl="rfs_invoice_totals.aspx" Text="RFS Invoice Totals by Client" Value="RFS Invoice Totals by Client">
				</asp:treenode>
				<asp:treenode NavigateUrl="rfs_invoice_process_summary.aspx" Text="RFS Revenue by GL" Value="RFS Revenue by GL">
				</asp:treenode>
				<asp:treenode NavigateUrl="rfs_invoice_process_summary.aspx" Text="Sales by GL" Value="Sales by GL">
				</asp:treenode>
				<asp:treenode NavigateUrl="invoice_totals_by_gl.aspx" Text="Sales by GL Detail" Value="Sales by GL Detail">
				</asp:treenode>
				<asp:treenode NavigateUrl="special_needs_monitor.aspx" Text="Special Needs Loads" Value="Special Needs Loads">
				</asp:treenode>
				<asp:treenode NavigateUrl="staged_loads_in_fontana.aspx" Text="Staged Loads in Fontana" Value="Staged Loads in Fontana">
				</asp:treenode>
				<asp:treenode NavigateUrl="coils_shipped_vs_staged.aspx" Text="Staging Detail" Value="Staging Detail">
				</asp:treenode>
				<asp:treenode NavigateUrl="booked_throughput.aspx" Text="Throughput/Planned Min" Value="Throughput/Planned Min">
				</asp:treenode>
				<asp:treenode NavigateUrl="evaluate_planed_revenue.aspx" Text="Time and Rev (Planned) Detail" Value="Planned Time and Rev Detail">
				</asp:treenode>
				<asp:treenode NavigateUrl="evaluate_actual_time_and_revenue.aspx" Text="Time and Rev (Actual) Detail" Value="Time and Rev (Actual) Detail">
				</asp:treenode>
				<asp:treenode NavigateUrl="todays_plan_summary.aspx" Text="Today's Destination Summary" Value="Today's Destination Summary">
				</asp:treenode>
				<asp:treenode NavigateUrl="plan.aspx" Text="Today's Plan" Value="Today's Plan">
				</asp:treenode>
				<asp:treenode NavigateUrl="todayX.aspx" Text="Today's Shipper Summary" Value="Today's Shipper Summary">
				</asp:treenode>
				<asp:treenode NavigateUrl="transit_times__city_to_city_ave.aspx" Text="Transit Times - City to City Average" Value="Transit Times - City to City Average">
				</asp:treenode>
				<asp:treenode NavigateUrl="upi_super_summary.aspx" Text="UPI Super Summary" Value="UPI Super Summary">
				</asp:treenode>
				<asp:treenode NavigateUrl="warehouse_monthly_revenue_by_rfs.aspx" Text="Warehouse Monthly Revenue by RFS" Value="Warehouse Monthly Revenue by RFS">
				</asp:treenode>
				<asp:treenode NavigateUrl="warehouse_revenue.aspx" Text="Warehouse Monthly Revenue Summary" Value="Warehouse Revenue">
				</asp:treenode>
				<asp:treenode NavigateUrl="will_call_history_detail.aspx" Text="Will Call Detail by Date" Value="Will Call Detail by Date">
				</asp:treenode>
				<asp:treenode NavigateUrl="will_call_history.aspx" Text="Will Call History" Value="Will Call History">
				</asp:treenode>
				<asp:treenode NavigateUrl="wise_delivery_by_week.aspx" Text="Wise Delivery by Week" Value="Wise Delivery by Week">
				</asp:treenode>
				<asp:treenode NavigateUrl="today.aspx" Text="Worst Leg by Day" Value="Worst Leg by Day">
				</asp:treenode>
			</asp:treenode>
		</Nodes>
		<RootNodeStyle Font-Bold="True" />
	</asp:TreeView>
</form>

</body>

</html>
