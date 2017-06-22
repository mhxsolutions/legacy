
<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="Monitoring_DriversFuelUsageSummary" Title="BOPS | Monitoring | Drivers Fuel Usage Summary" Codebehind="DriversFuelUsageSummary.aspx.cs" %>

<%-- AJAX control and user control assembly registrations. --%>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../Controls/PopupCalendarControl.ascx" TagName="PopupCalendarControl" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <%-- Script manager is required for the AJAX controls. --%>
    
    <asp:ScriptManager ID="_ScriptManager1" runat="server">
    </asp:ScriptManager>

    <h2>Drivers Fuel Usage Summary</h2>

    <p>The following shows the fuel usage summary for all defined <a href="DriversFuelCards.aspx">driver fuel card assignments</a>.
    Driver fuel usage details <a href="DriversFuelUsageDetails.aspx">are available here</a>.</p>

    <table>
        <tr>
            <td><asp:Label ID="DatesLabel" runat="server" Text="Begin/End Dates:" /></td>
            <td>
                <asp:TextBox ID="BeginDateTextbox" runat="server" Width="60" />
                <cc1:CalendarExtender ID="BeginDateCalendarExtender" runat="server" TargetControlID="BeginDateTextbox" 
                    PopupButtonID="BeginDateCalendarImage" />
                <asp:Image ID="BeginDateCalendarImage" runat="server" ImageUrl="~/Images/CalendarIcon16x16.png" />

                <asp:TextBox ID="EndDateTextbox" runat="server" Width="60" />
                <cc1:CalendarExtender ID="EndDateCalendarExtender" runat="server" TargetControlID="EndDateTextbox" 
                    PopupButtonID="EndDateCalendarImage" />
                <asp:Image ID="EndDateCalendarImage" runat="server" ImageUrl="~/Images/CalendarIcon16x16.png" />            
            </td>
            <td><asp:Button ID="RefreshButton" runat="server" Text="Refresh" /><br /></td>
        </tr>
        <tr>
            <td style="height: 26px"><asp:Label ID="PriceLabel" runat="server" Text="Price / Gallon:" /></td>
            <td style="height: 26px"><asp:TextBox ID="PriceTextbox" runat="server" Text="1.40" /></td>
        </tr>
    </table>

    <asp:GridView ID="DriverFuelUsageGridview" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="DriverFuelUsageDatasource" ForeColor="#333333" GridLines="None" PageSize="15" AllowSorting="True" OnRowDataBound="DriverFuelUsageGridview_RowDataBound">
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:BoundField DataField="Card Id" HeaderText="Card" SortExpression="Card Id" >
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Driver" SortExpression="Driver">
                <ItemTemplate>
                    <asp:Label ID="DriverLabel" runat="server" Text='<%# Bind("Driver") %>'/>
                    <asp:LinkButton ID="AssignLinkbutton" runat="Server" Text="(assign driver)" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Gallons" HeaderText="Gallons" SortExpression="Gallons" >
                <HeaderStyle HorizontalAlign="Right" />
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Cost" HeaderText="Cost" SortExpression="Cost" DataFormatString="{0:c}">
                <HeaderStyle HorizontalAlign="Right" />
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
        </Columns>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    
    <asp:SqlDataSource ID="DriverFuelUsageDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [DWS Rep Data].dbo.[AFC Fuel Data Usage].[Card Key] AS [Card Id], SUM([DWS Rep Data].dbo.[AFC Fuel Data Usage].Quantity) AS Gallons, SUM(CAST([DWS Rep Data].dbo.[AFC Fuel Data Usage].Quantity AS FLOAT) * @PricePerGallon) AS Cost, tblDriverList.LastName + N', ' + tblDriverList.FirstName AS Driver FROM [Fuel Card Driver Assignments] INNER JOIN tblDriverList ON [Fuel Card Driver Assignments].[Driver Ref] = tblDriverList.EmployeeID RIGHT OUTER JOIN [DWS Rep Data].dbo.[AFC Fuel Data Usage] ON [Fuel Card Driver Assignments].[Card Id] = [DWS Rep Data].dbo.[AFC Fuel Data Usage].[Card Key] WHERE ([DWS Rep Data].dbo.[AFC Fuel Data Usage].DateFueled > @BeginDate) AND ([DWS Rep Data].dbo.[AFC Fuel Data Usage].DateFueled < @EndDate) GROUP BY [DWS Rep Data].dbo.[AFC Fuel Data Usage].[Card Key], tblDriverList.EmployeeID, tblDriverList.LastName + N', ' + tblDriverList.FirstName">
        <SelectParameters>
            <asp:ControlParameter ControlID="PriceTextbox" Name="PricePerGallon" PropertyName="Text" />
            <asp:ControlParameter ControlID="BeginDateTextbox" Name="BeginDate" PropertyName="Text" />
            <asp:ControlParameter ControlID="EndDateTextbox" Name="EndDate" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
