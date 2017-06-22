<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true"
    Inherits="RFS_RfsStorageBillingEditAssignment" Title="BOPS | RFS Storage Rate Assignment" Codebehind="RfsStorageBillingEditAssignment.aspx.cs" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../Controls/PopupCalendarControl.ascx" TagName="PopupCalendarControl" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <%-- Necessary to use the AJAX Control Toolkit on the page. --%>
    
    <asp:ScriptManager ID="_ScriptManager1" runat="server">
    </asp:ScriptManager>

    <h2>RFS Storage Rate Assignment</h2>
        
    <p><a href="RfsStorageBillingRateAssignments.aspx">Click here to return to the full list of rate assignments.</a></p>
        
    <table>
        <tr>
            <td>Rate:</td>
            <td>
                <asp:DropDownList ID="_RateList" runat="server" DataSourceID="RateDatasource" DataTextField="Description" 
                    DataValueField="ID" Width="500">
                </asp:DropDownList><asp:SqlDataSource ID="RateDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                    SelectCommand="SELECT [RFS Storage Rates].[Rate Id] AS ID, CAST([RFS Storage Rates].[Rate Id] AS VARCHAR) + ' - ' + [DWS Rep Data].dbo.tbldestinationList.Destination + N': ' + [DWS Rep Data].dbo.tbldestinationList.City + N', ' + ISNULL([DWS Rep Data].dbo.tbldestinationList.State, N'') + N' (' + [RFS Storage Rates].Description + N')' AS Description FROM [RFS Storage Rates] INNER JOIN [RFS Storage Billing Types] ON [RFS Storage Rates].[Billing Type Ref] = [RFS Storage Billing Types].[Billing Type Id] INNER JOIN [DWS Rep Data].dbo.tbldestinationList ON [RFS Storage Rates].[Bill To Client Ref] = [DWS Rep Data].dbo.tbldestinationList.[Destination id] ORDER BY [DWS Rep Data].dbo.tbldestinationList.Destination">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>Profile:</td>
            <td>
                <asp:DropDownList ID="_ProfileList" runat="server" DataSourceID="ProfileDatasource" DataTextField="Description" 
                    DataValueField="ID" Width="500">
                </asp:DropDownList><asp:SqlDataSource ID="ProfileDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                    SelectCommand="SELECT [Product Profiles].[Profile ID] AS ID, CAST([Product Profiles].[Profile ID] AS VARCHAR) + ' - ' + tbldestinationList_1.Destination + N': ' + tbldestinationList_1.City + N', ' + ISNULL(tbldestinationList_1.State, N'') + ' (' + [Product Profiles].[Product Class Description] + ')' AS Description FROM [Product Profiles] INNER JOIN [DWS Rep Data].dbo.tbldestinationList AS tbldestinationList_1 ON [Product Profiles].[Receiving Client Ref] = tbldestinationList_1.[Destination id] ORDER BY tbldestinationList_1.Destination">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>Begin Date:</td>
            <td>
                <asp:TextBox ID="_BeginDateTextbox" runat="server"></asp:TextBox>
                <cc1:CalendarExtender ID="_BeginDateCalendarExtender" runat="server" TargetControlID="_BeginDateTextbox" 
                    PopupButtonID="_BeginDateCalendarImage" />
                <asp:Image ID="_BeginDateCalendarImage" runat="server" ImageUrl="~/Images/CalendarIcon16x16.png" />
            </td>
        </tr>
        <tr>
            <td>End Date:</td>
            <td>
                <asp:TextBox ID="_EndDateTextbox" runat="server"></asp:TextBox>
                <cc1:CalendarExtender ID="_EndDateCalendarExtender" runat="server" TargetControlID="_EndDateTextbox" 
                    PopupButtonID="_EndDateCalendarImage" />
                <asp:Image ID="_EndDateCalendarImage" runat="server" ImageUrl="~/Images/CalendarIcon16x16.png" />
            </td>
        </tr>
        <tr>
            <td>Description:</td>
            <td>
                <asp:TextBox ID="_DescriptionTextbox" runat="server" Width="500"></asp:TextBox>
            </td>
        </tr>
    </table>
    
    <p></p>
    <asp:Button ID="_SaveButton" runat="server" Text="Save" OnClick="_SaveButton_Click"/>
    
</asp:Content>
