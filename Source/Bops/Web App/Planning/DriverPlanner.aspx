<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" Inherits="Planning_DriverPlanner" 
    Title="BOPS | Planning | Driver Planner" Codebehind="DriverPlanner.aspx.cs" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <%-- Necessary for the AJAX control toolkit --%>
    
    <asp:ScriptManager ID="_ScriptManager1" runat="server">
    </asp:ScriptManager>

    <h2>Driver Planner</h2>
    <p>To get started with the driver planner, choose a driver and start date and click the "Next" button.</p>
    <table>
        <tr>
            <td>Driver:</td>
            <td><asp:DropDownList ID="_DriverDropdownlist" runat="server" DataSourceID="_DriverDatasource" DataTextField="Name" DataValueField="EmployeeID" Width="200"/>
            <asp:SqlDataSource ID="_DriverDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                SelectCommand="SELECT EmployeeID, FirstName + N' ' + LastName AS Name FROM tblDriverList WHERE ([Termination Date] IS NULL) AND (Agilis = 1) AND ([Fleet ref] IS NOT NULL) ORDER BY LastName, FirstName">
            </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>Plan Date:</td>
            <td>
                <asp:TextBox ID="_PlanDateTextbox" runat="server" Width="200"/>
                <cc1:CalendarExtender ID="_PlanDateCalendarExtender" runat="server" TargetControlID="_PlanDateTextbox" 
                    PopupButtonID="_PlanDateCalendarImage" />
                <asp:Image ID="_PlanDateCalendarImage" runat="server" ImageUrl="~/Images/CalendarIcon16x16.png" />
                
            </td>
        </tr>
        <tr>
            <td></td>
            <td><asp:Button ID="_NextButton" runat="server" Text="Next" OnClick="_NextButton_Click"/></td>
        </tr>
    </table>
</asp:Content>
