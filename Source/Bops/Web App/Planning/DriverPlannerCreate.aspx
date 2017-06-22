<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" Inherits="Planning_DriverPlannerCreate" 
    Title="BOPS | Planning | Create Driver Plan" Codebehind="DriverPlannerCreate.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h2>Create Driver Plan</h2>
    <p>To create a new plan for the specified date, provide a start time and click the "Create" button. 
    Or <a href="DriverPlanner.aspx">click here to return to the main driver planner page.</a></p>
    
    <table>
        <tr>
            <td>Driver:</td>
            <td><asp:Label ID="_DriverNameLabel" runat="server" /></td>
        </tr>
        <tr>
            <td>Plan Date:</td>
            <td><asp:Label ID="_PlanDateLabel" runat="server" /></td>
        </tr>
        <tr>
            <td>Start Time:</td>
            <td>
                <asp:TextBox ID="_StartTimeTextbox" runat="server" Text="08:00" />
                <asp:CustomValidator ID="_StartTimeCustomvalidator" runat="server" Display="Dynamic" ErrorMessage="Start time is invalid." 
                    ControlToValidate="_StartTimeTextbox" OnServerValidate="ServerValidateStartTime" ValidateEmptyText="True"/>
            </td>
        </tr>
        <tr>
            <td></td>
            <td><asp:Button ID="_CreateButton" runat="server" Text="Create" OnClick="_CreateButton_Click" /></td>
        </tr>
    </table>

</asp:Content>
