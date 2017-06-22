<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" Inherits="Planning_DriverPlannerEditStep" 
    Title="BOPS | Planning | Edit Driver Plan Step" Codebehind="DriverPlannerEditStep.aspx.cs" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h2>Edit Driver Plan Step</h2>
    <h3><asp:Label ID="_PlanHeaderLabel" runat="server" /></h3>
    <p>To edit the driver plan step, make the desired changes and click the "Update" button.</p>
    
    <table>
        <tr>
            <td>Origin:</td>
            <td><asp:DropDownList ID="_OriginDropdownlist" runat="server" DataSourceID="_OriginDatasource" DataTextField="Destination" DataValueField="Destination id" />
                <asp:SqlDataSource ID="_OriginDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>"
                    SelectCommand="SELECT [Destination id], Destination + N': ' + City + N', ' + ISNULL(State, '') AS Destination FROM tbldestinationList">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>Destination:</td>
            <td><asp:DropDownList ID="_DestinationDropdownlist" runat="server" DataSourceID="_DestinationDatasource" DataTextField="Destination" DataValueField="Destination id" />
                <asp:SqlDataSource ID="_DestinationDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>"
                    SelectCommand="SELECT [Destination id], Destination + N': ' + City + N', ' + ISNULL(State, '') AS Destination FROM tbldestinationList">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>Load:</td>    
            <td>
                <asp:DropDownList ID="_LoadDropdownlist" runat="server" DataSourceID="_LoadDatasource" DataTextField="Load" DataValueField="Load" Width="200" 
                    AppendDataBoundItems="true">
                    <asp:ListItem Text="(none)" Value=""></asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource
                    ID="_LoadDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                    SelectCommand="SELECT tblPoscoLoads.[Load] FROM tblPoscoLoads LEFT OUTER JOIN [Planner Detail] ON tblPoscoLoads.[Load] = [Planner Detail].[Load Ref] WHERE (tblPoscoLoads.LogOutDate IS NULL) AND (tblPoscoLoads.LoadDate <= GETDATE()) AND ([Planner Detail].[Planner Detail ID] IS NULL) OR ([Planner Detail].[Planner Detail ID] = @DetailId)">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="DetailId" QueryStringField="DetailId" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>Action:</td>
            <td><asp:DropDownList ID="_ActionDropdownlist" runat="server" DataSourceID="_ActionDatasource" DataTextField="Planner_Action" DataValueField="Planner_Action_ID" Width="200" /><asp:SqlDataSource
                    ID="_ActionDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                    SelectCommand="SELECT [Planner Action ID] AS Planner_Action_ID, [Planner Action] AS Planner_Action FROM [Planner Detail Action] ORDER BY [Planner Action]">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>Notes:</td>
            <td><asp:TextBox ID="_NotesTextbox" runat="server" MaxLength="50" Width="200"/></td>
        </tr>
        <tr>
            <td></td>
            <td><asp:Button ID="_UpdateButton" runat="server" Text="Update" OnClick="_UpdateButton_Click"/></td>
        </tr>
    </table>

</asp:Content>
