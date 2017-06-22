<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="Agilis_AgilisEquipmentTracking" Title="BOPS | Agilis | Equipment Tracking" Codebehind="AgilisEquipmentTracking.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1>
        Agilis Equipment Tracking
    </h1>
    <p>To filter the equipment list, select the limiting values from the drop down controls 
    at the top of the list. To return to the complete list, click the clear filters button.</p>
    <asp:Table ID="FilterTable" runat="server" CellPadding="3" BackColor="#507CD1">
        <asp:TableRow>
            <asp:TableCell Width="75">
                <asp:DropDownList ID="EquipmentIdFilterDropDownList" runat="server" AutoPostBack="true" OnPreRender="DropDownLists_PreRender"
                    DataSourceID="EquipmentIdDatasource" DataTextField="EquipmentIdentifier" DataValueField="EquipmentIdentifier"
                    Width="75">
                </asp:DropDownList>
            </asp:TableCell>
            <asp:TableCell Width="100">
                <asp:DropDownList ID="EquipmentTypeFilterDropDownList" runat="server" AutoPostBack="true" Width="100">
                    <asp:ListItem Value="*">All</asp:ListItem>
                    <asp:ListItem Value="Tractor">Tractor</asp:ListItem>
                    <asp:ListItem Value="Trailer">Trailer</asp:ListItem>
                </asp:DropDownList>
            </asp:TableCell>
            <asp:TableCell Width="180">
                <asp:DropDownList ID="DriverFilterDropDownList" runat="server" AutoPostBack="true" DataSourceID="DriverDatasource" 
                    OnPreRender="DropDownLists_PreRender" DataTextField="Name" DataValueField="Name" Width="180">
                </asp:DropDownList>
            </asp:TableCell>
            <asp:TableCell>
                <asp:Button ID="ClearFiltersButton" runat="server" Text="Clear Filters" OnClick="ClearFiltersButton_Click" />
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>
    <asp:GridView ID="GridView1" runat="server" DataSourceID="EquipmentDisposition" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None">
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <Columns>
            <asp:BoundField DataField="Equipment_ID" HeaderText="ID" SortExpression="Equipment_ID" >
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" Width="75px" />
                <ItemStyle VerticalAlign="Top" HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Equipment_Type" HeaderText="Type" SortExpression="Equipment_Type" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" Width="100px" />
                <ItemStyle VerticalAlign="Top" HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="Driver" HeaderText="Driver" SortExpression="Driver" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" Width="180px" />
                <ItemStyle VerticalAlign="Top" HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="Last_Event" HeaderText="Last Event" SortExpression="Last_Event" DataFormatString="{0:MM-dd-yy HH:mm}">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Work_Order_Number" HeaderText="Work Order" SortExpression="Work_Order_Number" >
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Current_Status" HeaderText="Status" SortExpression="Current_Status" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="Origin" HeaderText="Origin" SortExpression="Origin" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="Destination" HeaderText="Destination" SortExpression="Destination" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="Load_Ref" HeaderText="Load" SortExpression="Load_Ref" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" HorizontalAlign="Left" />
            </asp:BoundField>
        </Columns>
        <RowStyle BackColor="#EFF3FB" />
        <EditRowStyle BackColor="#2461BF" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="EquipmentDisposition" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
        SelectCommand="SELECT [Equipment ID] AS Equipment_ID, CAST([Equipment ID] AS VARCHAR(10)) AS EquipmentIdString, [Equipment Type] AS Equipment_Type, [First Name] + ' ' + [Last Name] AS Driver, [Last Event] AS Last_Event, [Work Order Number] AS Work_Order_Number, [Current Status] AS Current_Status, [Load Ref] AS Load_Ref, Origin, Destination FROM [Agilis Equipment Last Event Details]"
        FilterExpression="EquipmentIdString LIKE '{0}' AND Equipment_Type LIKE '{1}' AND Driver LIKE '%{2}%'">
        <FilterParameters>
            <asp:ControlParameter Name="Equipment_ID" ControlID="EquipmentIdFilterDropDownList" PropertyName="SelectedValue" DefaultValue="*" />
            <asp:ControlParameter Name="Equipment_Type" ControlID="EquipmentTypeFilterDropDownList" PropertyName="SelectedValue" DefaultValue="*" />
            <asp:ControlParameter Name="Driver" ControlID="DriverFilterDropDownList" PropertyName="SelectedValue" DefaultValue="*" />
        </FilterParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="EquipmentIdDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:EQ Manager ConnectionString %>"
        SelectCommand="SELECT DISTINCT EquipmentIdentifier FROM EquipmentTable WHERE (VehicleTypeID = 1 OR VehicleTypeID = 2) ORDER BY EquipmentIdentifier">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DriverDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT EmployeeID, FirstName + ' ' + LastName AS Name FROM tblDriverList WHERE (Agilis = 1) ORDER BY Name">
    </asp:SqlDataSource>
</asp:Content>
