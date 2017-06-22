<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta content="en-us" http-equiv="Content-Language" />
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
<title>EQ Info</title>
</head>

<body>

<form id="form1" runat="server">
	<h3>EQ Info</h3>
	<p>
	<asp:GridView id="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="EquipmentID" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
		<RowStyle BackColor="#EFF3FB" />
		<Columns>
			<asp:boundfield DataField="Terminal" HeaderText="Terminal" SortExpression="Terminal">
			</asp:boundfield>
			<asp:boundfield DataField="EquipmentIdentifier" HeaderText="EQ Unit" SortExpression="EquipmentIdentifier">
			</asp:boundfield>
			<asp:boundfield DataField="VehicleType" HeaderText="VehicleType" SortExpression="VehicleType">
			</asp:boundfield>
			<asp:boundfield DataField="Year" HeaderText="Year" SortExpression="Year">
			</asp:boundfield>
			<asp:boundfield DataField="TrailerLength" HeaderText="TrailerLength" SortExpression="TrailerLength">
			</asp:boundfield>
			<asp:boundfield DataField="WheelBase" HeaderText="WheelBase" SortExpression="WheelBase">
			</asp:boundfield>
			<asp:checkboxfield DataField="HeadacheRack" HeaderText="HeadacheRack" SortExpression="HeadacheRack">
			</asp:checkboxfield>
			<asp:checkboxfield DataField="ABS" HeaderText="ABS" SortExpression="ABS">
			</asp:checkboxfield>
			<asp:checkboxfield DataField="SpreadAxel" HeaderText="SpreadAxel" SortExpression="SpreadAxel">
			</asp:checkboxfield>
			<asp:checkboxfield DataField="Slider" HeaderText="Slider" SortExpression="Slider">
			</asp:checkboxfield>
			<asp:checkboxfield DataField="LandingGear" HeaderText="LandingGear" SortExpression="LandingGear">
			</asp:checkboxfield>
			<asp:boundfield DataField="Weight-Light" HeaderText="Weight-Light" SortExpression="Weight-Light">
			</asp:boundfield>
			<asp:boundfield DataField="Weight-Equiped" HeaderText="Weight-Equiped" SortExpression="Weight-Equiped">
			</asp:boundfield>
			<asp:boundfield DataField="DeckType" HeaderText="DeckType" SortExpression="DeckType">
			</asp:boundfield>
			<asp:boundfield DataField="MFGName" HeaderText="MFGName" SortExpression="MFGName">
			</asp:boundfield>
			<asp:boundfield DataField="ModelName" HeaderText="ModelName" SortExpression="ModelName">
			</asp:boundfield>
			<asp:boundfield DataField="FrameType" HeaderText="FrameType" SortExpression="FrameType">
			</asp:boundfield>
			<asp:boundfield DataField="EngineType" HeaderText="EngineType" SortExpression="EngineType">
			</asp:boundfield>
			<asp:boundfield DataField="FrontWheelSize" HeaderText="FrontWheelSize" SortExpression="FrontWheelSize">
			</asp:boundfield>
			<asp:boundfield DataField="EquipmentComment" HeaderText="EquipmentComment" SortExpression="EquipmentComment">
			</asp:boundfield>
			<asp:boundfield DataField="ApplicationFor" HeaderText="ApplicationFor" SortExpression="ApplicationFor">
			</asp:boundfield>
			<asp:checkboxfield DataField="Jake Brake" HeaderText="Jake Brake" SortExpression="Jake Brake">
			</asp:checkboxfield>
			<asp:boundfield DataField="StatusText" HeaderText="StatusText" SortExpression="StatusText">
			</asp:boundfield>
			<asp:checkboxfield DataField="CrossFire" HeaderText="CrossFire" SortExpression="CrossFire">
			</asp:checkboxfield>
			<asp:checkboxfield DataField="Parked" HeaderText="Parked" SortExpression="Parked">
			</asp:checkboxfield>
			<asp:boundfield DataField="Dispatch Comment" HeaderText="Dispatch Comment" SortExpression="Dispatch Comment">
			</asp:boundfield>
			<asp:boundfield DataField="Restrictions" HeaderText="Restrictions" SortExpression="Restrictions">
			</asp:boundfield>
			<asp:boundfield DataField="Classifications" HeaderText="Classifications" SortExpression="Classifications">
			</asp:boundfield>
			<asp:boundfield DataField="VIN" HeaderText="VIN" SortExpression="VIN">
			</asp:boundfield>
			<asp:boundfield DataField="LICENCE" HeaderText="LICENCE" SortExpression="LICENCE">
			</asp:boundfield>
		</Columns>
		<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
		<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
		<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
		<EditRowStyle BackColor="#2461BF" />
		<AlternatingRowStyle BackColor="White" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:EQ ManagerConnectionString %>" SelectCommand="SELECT * FROM [EQinfo with location]">
	</asp:SqlDataSource>
	</p>
</form>

</body>

</html>
