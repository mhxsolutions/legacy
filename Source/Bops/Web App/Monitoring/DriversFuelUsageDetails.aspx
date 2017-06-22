<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" Inherits="Monitoring_DriversFuelUsageDetails" Title="Untitled Page" Codebehind="DriversFuelUsageDetails.aspx.cs" %>

<%-- AJAX control and user control assembly registrations. --%>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../Controls/PopupCalendarControl.ascx" TagName="PopupCalendarControl" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <%-- Script manager is required for the AJAX controls. --%>
    
    <asp:ScriptManager ID="_ScriptManager1" runat="server">
    </asp:ScriptManager>

    <h2>Drivers Fuel Usage Details</h2>

    <p>The following shows the fuel usage details for all defined <a href="DriversFuelCards.aspx">driver fuel card assignments</a>.</p>

    <asp:Label ID="DatesLabel" runat="server" Text="Begin/End Dates:" />
    <asp:TextBox ID="BeginDateTextbox" runat="server" Width="60" />
    <cc1:CalendarExtender ID="BeginDateCalendarExtender" runat="server" TargetControlID="BeginDateTextbox" 
        PopupButtonID="BeginDateCalendarImage" />
    <asp:Image ID="BeginDateCalendarImage" runat="server" ImageUrl="~/Images/CalendarIcon16x16.png" />

    <asp:TextBox ID="EndDateTextbox" runat="server" Width="60" />
    <cc1:CalendarExtender ID="EndDateCalendarExtender" runat="server" TargetControlID="EndDateTextbox" 
        PopupButtonID="EndDateCalendarImage" />
    <asp:Image ID="EndDateCalendarImage" runat="server" ImageUrl="~/Images/CalendarIcon16x16.png" />
    <asp:Button ID="RefreshButton" runat="server" Text="Refresh" />

    <br /><br />

    <asp:GridView ID="DriverFuelUsageGridview" runat="server" AllowPaging="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="DriverFuelUsageDatasource" ForeColor="#333333" GridLines="None" PageSize="15" AllowSorting="True">
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:BoundField DataField="Timestamp" HeaderText="Time" ReadOnly="True" SortExpression="Timestamp" 
                DataFormatString="{0:MM-dd-yy HH:mm}" />
            <asp:BoundField DataField="Card Id" HeaderText="Card" SortExpression="Card Id" >
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Gallons" HeaderText="Gallons" SortExpression="Gallons" >
                <HeaderStyle HorizontalAlign="Right" />
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Driver" HeaderText="Driver" SortExpression="Driver" />
        </Columns>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="DriverFuelUsageDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [DWS Rep Data].dbo.[AFC Fuel Data Usage].[Transaction Number], DATEADD(n, DATEPART(n, [DWS Rep Data].dbo.[AFC Fuel Data Usage].TimeFueled), DATEADD(hh, DATEPART(hh, [DWS Rep Data].dbo.[AFC Fuel Data Usage].TimeFueled), [DWS Rep Data].dbo.[AFC Fuel Data Usage].DateFueled)) AS Timestamp, [DWS Rep Data].dbo.[AFC Fuel Data Usage].[Card Key] AS [Card Id], [DWS Rep Data].dbo.[AFC Fuel Data Usage].Quantity AS Gallons, tblDriverList.EmployeeID, tblDriverList.LastName + N', ' + tblDriverList.FirstName AS Driver FROM [Fuel Card Driver Assignments] INNER JOIN tblDriverList ON [Fuel Card Driver Assignments].[Driver Ref] = tblDriverList.EmployeeID RIGHT OUTER JOIN [DWS Rep Data].dbo.[AFC Fuel Data Usage] ON [Fuel Card Driver Assignments].[Card Id] = [DWS Rep Data].dbo.[AFC Fuel Data Usage].[Card Key] WHERE @BeginDate <= [DateFueled] AND [DateFueled] < @EndDate">
        <SelectParameters>
            <asp:ControlParameter ControlID="BeginDateTextbox" Name="BeginDate" PropertyName="Text" />
            <asp:ControlParameter ControlID="EndDateTextbox" Name="EndDate" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
