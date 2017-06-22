<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>Harbor Recap</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>Harbor Recap</h3>
	<p>Select Date:</p>
	<asp:DropDownList id="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="Date" DataValueField="Date">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Date] FROM [HOPS DR Entry INFO] ORDER BY [Date] DESC">
	</asp:SqlDataSource>
	<br />
	Select Berth:<br />
	<asp:DropDownList id="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="Berth_Abr" DataValueField="Berth_Abr">
	</asp:DropDownList>
	<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT DISTINCT [Berth Abr] AS Berth_Abr FROM [HOPS DR Entry INFO] WHERE ([Date] = @Date) ORDER BY [Berth Abr]">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList1" Name="Date" PropertyName="SelectedValue" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" DataKeyNames="DR" DataSourceID="SqlDataSource3" ForeColor="Black">
		<FooterStyle BackColor="#CCCCCC" />
		<RowStyle BackColor="White" Font-Size="Smaller" />
		<Columns>
			<asp:boundfield DataField="Vessel" HeaderText="Vessel" SortExpression="Vessel">
			</asp:boundfield>
			<asp:boundfield DataField="PUR" HeaderText="PUR" SortExpression="PUR">
			</asp:boundfield>
			<asp:boundfield DataField="Tractor" HeaderText="Tractor" SortExpression="Tractor">
			</asp:boundfield>
			<asp:boundfield DataField="DR" HeaderText="DR" ReadOnly="True" SortExpression="DR">
			</asp:boundfield>
			<asp:boundfield DataField="Gate_Pass" HeaderText="Gate_Pass" SortExpression="Gate_Pass">
			</asp:boundfield>
			<asp:boundfield DataField="Count" HeaderText="Count" SortExpression="Count">
			</asp:boundfield>
			<asp:boundfield DataField="Confirmed Ct" HeaderText="Confirmed Ct" SortExpression="Confirmed Ct">
			</asp:boundfield>
			<asp:boundfield DataField="Product_Type" HeaderText="Product_Type" SortExpression="Product_Type">
			</asp:boundfield>
			<asp:boundfield DataField="Weight" HeaderText="Weight" SortExpression="Weight">
			</asp:boundfield>
			<asp:boundfield DataField="Confirmed Wt" HeaderText="Confirmed Wt" SortExpression="Confirmed Wt">
			</asp:boundfield>
			<asp:boundfield DataField="Desc" HeaderText="Desc" SortExpression="Desc">
			</asp:boundfield>
			<asp:boundfield DataField="Desc_2" HeaderText="Desc_2" SortExpression="Desc_2">
			</asp:boundfield>
			<asp:boundfield DataField="Client" HeaderText="Destination" ReadOnly="True" SortExpression="Client">
			</asp:boundfield>
			<asp:boundfield DataField="PMBOL_Client_Number" HeaderText="Client Number" SortExpression="PMBOL_Client_Number">
			</asp:boundfield>
			<asp:boundfield DataField="Last_Update_Time" DataFormatString="{0:t}" HeaderText="Time" HtmlEncode="False" SortExpression="Last_Update_Time">
			</asp:boundfield>
			<asp:checkboxfield DataField="Finalized" HeaderText="Finalized" SortExpression="Finalized">
			</asp:checkboxfield>
		</Columns>
		<PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
		<SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
		<HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT     TOP (100) PERCENT dbo.[HOPS DR Entry INFO].Vessel, dbo.[HOPS DR Entry INFO].DR, dbo.[HOPS DR Entry INFO].PUR, 
                      dbo.[HOPS DR Entry INFO].[PMBOL Client Number] AS PMBOL_Client_Number, dbo.[HOPS DR Entry INFO].Tractor, 
                      dbo.[HOPS DR Entry INFO].[Gate Pass] AS Gate_Pass, dbo.[HOPS DR Entry INFO].[Product Type] AS Product_Type, dbo.[HOPS DR Entry INFO].[Desc], 
                      dbo.[HOPS DR Entry INFO].[Desc 2] AS Desc_2, dbo.[HOPS DR Entry INFO].Client, dbo.[HOPS DR Entry INFO].Count, 
                      dbo.[Project Manager DR].[PMDR CT] AS [Confirmed Ct], dbo.[HOPS DR Entry INFO].Weight, dbo.[Project Manager DR].[PMDR Wt] AS [Confirmed Wt], 
                      dbo.[HOPS DR Entry INFO].[Last Update Time] AS Last_Update_Time, dbo.[HOPS DR Entry INFO].Finalized
FROM         dbo.[HOPS DR Entry INFO] INNER JOIN
                      dbo.[Project Manager DR] ON dbo.[HOPS DR Entry INFO].DR = dbo.[Project Manager DR].PMDRID
WHERE     (dbo.[HOPS DR Entry INFO].[Berth Abr] = @Berth_Abr) AND (dbo.[HOPS DR Entry INFO].Date = @Date)
ORDER BY Last_Update_Time">
		<SelectParameters>
			<asp:controlparameter ControlID="DropDownList2" Name="Berth_Abr" PropertyName="SelectedValue" Type="String" />
			<asp:controlparameter ControlID="DropDownList1" Name="Date" PropertyName="SelectedValue" Type="String" />
		</SelectParameters>
	</asp:SqlDataSource>
</form>

</body>

</html>
