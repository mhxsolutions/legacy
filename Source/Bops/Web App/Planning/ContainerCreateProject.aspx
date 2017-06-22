<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" Inherits="Planning_ContainerCreateProject" 
    Title="Create Container Project" Codebehind="ContainerCreateProject.aspx.cs" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <%-- Necessary for the AJAX control toolkit --%>
    
    <asp:ScriptManager ID="_ScriptManager1" runat="server">
    </asp:ScriptManager>


    <h2>Create Container Project</h2>
    <p>To create a new container project, provide the required information and click the "Create" button. Note well: the <em>origin</em> is intended to be the initial pickup
        point for the containers, to which they will subsequently be returned, while the
        <em>destination</em> is intended to be the client site where the containers will
        be delivered and later picked up for return.</p>
    
    <table>
        <tr>
            <td>Booking ID:</td>
            <td>
                <asp:TextBox ID="_BookingIdTextbox" runat="server" Width="100" MaxLength="50"></asp:TextBox>
                <asp:RequiredFieldValidator ID="_BookingIdRequiredValidator" runat="server" ControlToValidate="_BookingIdTextbox"
                    Display="Dynamic" ErrorMessage="Required field" />
            </td>
        </tr>
        
        
        <tr>
            <td>Berth:</td>
            <td>
                <asp:TextBox ID="_BerthTextbox" runat="server" Width="100" MaxLength="50" />
                <asp:RequiredFieldValidator ID="_BerthRequiredValidator" runat="server" ControlToValidate="_BerthTextbox"
                    Display="Dynamic" ErrorMessage="Required field" />
            </td>
        </tr>
        
        <tr>
            <td>Shipping Line:</td>
            <td>
                <asp:TextBox ID="_ShippingLineTextbox" runat="server" Width="100" MaxLength="100" />
                <asp:RequiredFieldValidator ID="_ShippingLineRequiredValidator" runat="server" ControlToValidate="_ShippingLineTextbox"
                    Display="Dynamic" ErrorMessage="Required field" />
            </td>
        </tr>
        
        <tr>
            <td>Begin Date:</td>
            <td>
                <asp:TextBox ID="_BeginDateTextbox" runat="server" Width="100" MaxLength="10" />
                <cc1:CalendarExtender ID="_BeginDateCalendarExtender" runat="server" TargetControlID="_BeginDateTextbox"  PopupButtonID="_PlanDateCalendarImage" />
                <asp:Image ID="_PlanDateCalendarImage" runat="server" ImageUrl="~/Images/CalendarIcon16x16.png" />
                <asp:RequiredFieldValidator ID="_BeginDateRequiredValidator" runat="server" ControlToValidate="_BeginDateTextbox"
                    Display="Dynamic" ErrorMessage="Required field" />
            </td>
        </tr>
        
        <tr>
            <td>Demurrage Days:</td>
            <td>
                <asp:TextBox ID="_DemurrageDaysTextbox" runat="server" Width="100" MaxLength="2" />
                <asp:RequiredFieldValidator ID="_DemurrageDaysRequiredValidator" runat="server" ControlToValidate="_DemurrageDaysTextbox"
                    Display="Dynamic" ErrorMessage="Required field" />
                <asp:CompareValidator ID="_DemurrageDaysNumberValidator" runat="server" ControlToValidate="_DemurrageDaysTextbox" Operator="DataTypeCheck" 
                    Type="Integer" Display="dynamic" ErrorMessage="Must be a whole number" />
                <asp:CompareValidator ID="_DemurrageDaysPositiveValidator" runat="server" ControlToValidate="_DemurrageDaysTextbox" ValueToCompare="0" Operator="GreaterThan" 
                    Display="dynamic" ErrorMessage="Must be greater than zero" />
        </tr>

        <tr>
            <td>Total Containers:</td>
            <td>
                <asp:TextBox ID="_TotalContainersTextbox" runat="server" Width="100" MaxLength="4" />
                <asp:RequiredFieldValidator ID="_TotalContainersRequiredValidator" runat="server" ControlToValidate="_TotalContainersTextbox"
                    Display="Dynamic" ErrorMessage="Required field" />
                <asp:CompareValidator ID="_TotalContainersNumberValidator" runat="server" ControlToValidate="_TotalContainersTextbox" Operator="DataTypeCheck" 
                    Type="Integer" Display="dynamic" ErrorMessage="Must be a whole number" />
                <asp:CompareValidator ID="_TotalContainersPositiveValidator" runat="server" ControlToValidate="_TotalContainersTextbox" ValueToCompare="0" Operator="GreaterThan" 
                    Display="dynamic" ErrorMessage="Must be greater than zero" />                   
            </td>
        </tr>

        <tr>
            <td>Description:</td>
            <td>
                <asp:TextBox ID="_DescriptionTextbox" runat="server" Width="100" MaxLength="300" />
                <asp:RequiredFieldValidator ID="_DescriptionRequiredValidator" runat="server" ControlToValidate="_DescriptionTextbox"
                    Display="Dynamic" ErrorMessage="Required field" />
            </td>
        </tr>
        
        <tr>
            <td>Bill-To Client:</td>
            <td><asp:DropDownList ID="_BillToClientDropdownlist" runat="server" DataSourceID="_BillToClientDatasource" DataTextField="Destination" 
                DataValueField="Destination id" Width="400"/>
                <asp:SqlDataSource ID="_BillToClientDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>"
                    SelectCommand="SELECT [Destination id], Destination + N': ' + City + N', ' + ISNULL(State, '') AS Destination FROM tbldestinationList">
                </asp:SqlDataSource>
            </td>
        </tr>
        
        <tr>
            <td>Origin:</td>
            <td><asp:DropDownList ID="_OriginDropdownlist" runat="server" DataSourceID="_OriginDatasource" DataTextField="Destination" 
                DataValueField="Destination id" Width="400"/>
                <asp:SqlDataSource ID="_OriginDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>"
                    SelectCommand="SELECT [Destination id], Destination + N': ' + City + N', ' + ISNULL(State, '') AS Destination FROM tbldestinationList">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>Destination:</td>
            <td><asp:DropDownList ID="_DestinationDropdownlist" runat="server" DataSourceID="_DestinationDatasource" DataTextField="Destination" 
                DataValueField="Destination id" Width="400"/> 
                <asp:SqlDataSource ID="_DestinationDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>"
                    SelectCommand="SELECT [Destination id], Destination + N': ' + City + N', ' + ISNULL(State, '') AS Destination FROM tbldestinationList">
                </asp:SqlDataSource>
            </td>
        </tr>
        
        <tr>
            <td valign="top">Notes:</td>
            <td><asp:TextBox ID="_NotesTextbox" runat="server" MaxLength="500" Width="400" Height="200px"/></td>
        </tr>
        <tr>
            <td></td>
            <td><asp:Button ID="_CreateButton" runat="server" Text="Create" OnClick="_CreateButton_Click" /></td>
        </tr>
    </table>
    

</asp:Content>

