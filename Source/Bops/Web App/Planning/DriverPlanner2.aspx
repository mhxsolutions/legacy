
<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" Inherits="Planning_DriverPlanner2" 
    Title="BOPS | Planning | Driver Planner" Codebehind="DriverPlanner2.aspx.cs" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <%-- Necessary for the AJAX control toolkit --%>
    
    <asp:ScriptManager ID="_ScriptManager1" runat="server">
    </asp:ScriptManager>

    <h2>Driver Planner</h2>
    
    <asp:Panel ID="_DriverDatePanel" runat="server">
    
        Planning for Driver X on Date Y 
        <asp:LinkButton ID="_DriverDateLinkbutton" runat="server">
            <asp:Label ID="_PanelLabel" runat="server" Text="Sample Label" />
            <asp:Image ID="_DriverDatePanelExtenderImage" runat="server" />
        </asp:LinkButton>
        
        <p>Sample text for my driver date panel. Here's where we would put the controls that let the user
        select the driver and/or date, though I'm not sure what type of controls yet. I know this much: we
        need to support simplified switching back and forth of drivers and more straightforward selection
        of a date, the point being that the planner needs to be able to hop from one driver to another with
        minimal "friction".</p>
        
        <table>
            <tr>
                <td>Driver:</td>
                <td><asp:DropDownList ID="_DriverDropdownlist" runat="server" DataSourceID="_DriverDatasource" DataTextField="Name" DataValueField="EmployeeID" Width="200"/>
                <asp:SqlDataSource ID="_DriverDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                    SelectCommand="SELECT EmployeeID, FirstName + N' ' + LastName AS Name FROM tblDriverList WHERE ([Termination Date] IS NULL) AND (Agilis = 1) ORDER BY LastName, FirstName">
                </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td>Plan Date:</td>
                <td>
                    <asp:TextBox ID="_PlanDateTextbox" runat="server" Width="175"/>
                    <cc1:CalendarExtender ID="_PlanDateCalendarExtender" runat="server" TargetControlID="_PlanDateTextbox" 
                        PopupButtonID="_PlanDateCalendarImage" />
                    <asp:Image ID="_PlanDateCalendarImage" runat="server" ImageUrl="~/Images/CalendarIcon16x16.png" />
                    
                </td>
            </tr>
            <tr>
                <td></td>
                <td><asp:Button ID="_ChangeDriverDateButton" runat="server" Text="Switch Driver/Date" /></td>
            </tr>
        </table>
        
    </asp:Panel>
    
    <cc1:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="server"
        TargetControlID="_DriverDatePanel"
        CollapsedSize="35"
        ExpandedSize="300"
        Collapsed="True"
        ExpandControlID="_DriverDateLinkbutton"
        CollapseControlID="_DriverDateLinkbutton"
        AutoCollapse="False"
        AutoExpand="False"
        ScrollContents="True"
        TextLabelID="_PanelLabel"
        CollapsedText="Change Driver or Date"
        ExpandedText="Cancel Changes" 
        ImageControlID="_DriverDatePanelExtenderImage"
        ExpandedImage="~/Images/collapse_blue.jpg"
        CollapsedImage="~/Images/expand_blue.jpg"
        ExpandDirection="Vertical" />

    <asp:GridView ID="_PlanGridview" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="_DriverPlanDatasource" ForeColor="#333333" GridLines="None">
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:BoundField DataField="Order" HeaderText="Order" SortExpression="Order" >
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Origin" HeaderText="Origin" ReadOnly="True" SortExpression="Origin" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Destination" HeaderText="Destination" ReadOnly="True" SortExpression="Destination" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Load" HeaderText="Load" ReadOnly="True" SortExpression="Load" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="PlannerAction" HeaderText="Action" ReadOnly="True" SortExpression="PlannerAction" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Transit" HeaderText="Transit" ReadOnly="True" SortExpression="Transit" >
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Arrive" HeaderText="Arrive" SortExpression="Arrive" DataFormatString="{0:HH:mm}" >
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Dwell" HeaderText="Dwell" SortExpression="Dwell" >
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Depart" HeaderText="Depart" SortExpression="Depart" DataFormatString="{0:HH:mm}" >
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Notes" HeaderText="Notes" SortExpression="Notes" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:HyperLinkField DataNavigateUrlFields="PlanRef,DetailId" DataNavigateUrlFormatString="DriverPlannerCreateStep.aspx?PlanId={0}&InsertBefore={1}" Text="Insert" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:HyperLinkField>
            <asp:HyperLinkField DataNavigateUrlFields="PlanRef,DetailId" DataNavigateUrlFormatString="DriverPlannerEditStep.aspx?PlanId={0}&DetailId={1}" Text="Edit" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:HyperLinkField>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <a href="DriverPlannerDeleteStep.aspx?PlanId=<%# Eval("PlanRef") %>&DetailId=<%# Eval("DetailId") %>" 
                        onclick='return confirm("Are you sure you want to delete the plan step?");'>Delete</a>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>

    <asp:SqlDataSource ID="_DriverPlanDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Planner Detail].[Order], [DWS Rep Data].dbo.tbldestinationList.Destination + ': ' + [DWS Rep Data].dbo.tbldestinationList.City + ', ' + ISNULL([DWS Rep Data].dbo.tbldestinationList.State, '') AS Origin, tbldestinationList_1.Destination + ': ' + tbldestinationList_1.City + ', ' + ISNULL(tbldestinationList_1.State, '') AS Destination, [Planner Detail].[Load Ref] AS [Load], [Planner Detail].Transit, [Planner Detail].[Sch Arrive] AS Arrive, [Planner Detail].Detention AS Dwell, [Planner Detail].[Sch Depart] AS Depart, [Planner Detail].Notes, [Planner Detail Action].[Planner Action] AS PlannerAction, [Planner Detail].[Planner Ref] AS PlanRef, [Planner Detail].[Planner Detail ID] AS DetailId FROM [Planner Detail] INNER JOIN [DWS Rep Data].dbo.tbldestinationList ON [Planner Detail].[Origin Ref] = [DWS Rep Data].dbo.tbldestinationList.[Destination id] INNER JOIN [DWS Rep Data].dbo.tbldestinationList AS tbldestinationList_1 ON [Planner Detail].[Dest Ref] = tbldestinationList_1.[Destination id] INNER JOIN [Planner Detail Action] ON [Planner Detail].[Action ref] = [Planner Detail Action].[Planner Action ID] WHERE ([Planner Detail].[Planner Ref] = @PlanId) ORDER BY [Planner Detail].[Order]">
        <SelectParameters>
            <asp:QueryStringParameter Name="PlanId" QueryStringField="PlanId" />
        </SelectParameters>
    </asp:SqlDataSource>



</asp:Content>

