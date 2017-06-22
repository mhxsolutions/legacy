
<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="Planning_ContainerProjectRailcars" Title="BOPS | Container Project Railcars" Codebehind="ContainerProjectRailcars.aspx.cs" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h2>Container Project Railcars</h2>
    <p>There are two ways to assign railcars to a container project:</p>

    <ol>
        <li>Find the railcar in the list of available railcars on the left and click the link to make the assignment and move it to the right.</li>
        <li><a href='<% Response.Write(string.Format("ContainerProjectRailcarsFromProject.aspx?ProjectId={0}", Request.QueryString["ProjectId"])); %>'>
                Click here to assign the same railcars used in another project.</a></li>
    </ol>        
    
    <h3>Project Details</h3>
    <asp:GridView ID="_ProjectsGridview" runat="server" CellPadding="4" DataSourceID="_ProjectsDatasource" ForeColor="#333333" GridLines="None" 
        AutoGenerateColumns="False" DataKeyNames="Project Id" AllowPaging="True" PageSize="20" EmptyDataText="The container project details could not be located.">
        <RowStyle BackColor="#EFF3FB" />
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="Project Id" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="Project Id">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Bill To Client" HeaderText="Bill To" ReadOnly="True" SortExpression="Bill To Client">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Booking Id" HeaderText="Booking" SortExpression="Booking Id">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Berth" HeaderText="Berth" SortExpression="Berth">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Shipping Line" HeaderText="Shipping Line" SortExpression="Shipping Line">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Default Origin" HeaderText="Origin" ReadOnly="True" SortExpression="Default Origin">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Default Destination" HeaderText="Destination" ReadOnly="True"
                SortExpression="Default Destination">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Begin Date" HeaderText="Begin Date" SortExpression="Begin Date" DataFormatString="{0:MM-dd-yyyy}">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Demurrage Days" HeaderText="Days" SortExpression="Demurrage Days">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Total Containers" HeaderText="Containers" SortExpression="Total Containers">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Complete" HeaderText="Complete" ReadOnly="True" SortExpression="Complete">
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
            </asp:BoundField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="_ProjectsDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [CPS Projects].[Project Id], [DWS Rep Data].dbo.tbldestinationList.Destination + ': ' + [DWS Rep Data].dbo.tbldestinationList.City + ', ' + ISNULL([DWS Rep Data].dbo.tbldestinationList.State, '') AS [Bill To Client], [CPS Projects].[Booking Id], [CPS Projects].Description, [CPS Projects].Berth, [CPS Projects].[Shipping Line], tbldestinationList_1.Destination + ': ' + tbldestinationList_1.City + ', ' + ISNULL(tbldestinationList_1.State, '') AS [Default Origin], tbldestinationList_2.Destination + ': ' + tbldestinationList_2.City + ', ' + ISNULL(tbldestinationList_2.State, '') AS [Default Destination], [CPS Projects].[Begin Date], [CPS Projects].[Demurrage Days], [CPS Projects].[Total Containers], CASE WHEN [Complete] = 1 THEN 'Yes' ELSE 'No' END AS Complete FROM [CPS Projects] INNER JOIN [DWS Rep Data].dbo.tbldestinationList ON [CPS Projects].[Bill To Client Ref] = [DWS Rep Data].dbo.tbldestinationList.[Destination id] INNER JOIN [DWS Rep Data].dbo.tbldestinationList AS tbldestinationList_1 ON [CPS Projects].[Default Origin Ref] = tbldestinationList_1.[Destination id] INNER JOIN [DWS Rep Data].dbo.tbldestinationList AS tbldestinationList_2 ON [CPS Projects].[Default Destination Ref] = tbldestinationList_2.[Destination id] WHERE ([CPS Projects].[Project Id] = @ProjectId)">
        <SelectParameters>
            <asp:QueryStringParameter Name="ProjectId" QueryStringField="ProjectId" />
        </SelectParameters>
    </asp:SqlDataSource>

    <table cellpadding="4">
        <tr>
            <td valign="top">
                <h3>Available Railcars</h3>
                <asp:GridView ID="_AvailableGridview" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="UKEY" DataSourceID="_AvailableDatasource" 
                    ForeColor="#333333" GridLines="None" EmptyDataText="There are no railcars available to assign." AllowPaging="True" PageSize="20">
                    <RowStyle BackColor="#EFF3FB" />
                    <Columns>
                        <asp:BoundField DataField="Car Number" HeaderText="Railcar" SortExpression="Car Number">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                        </asp:BoundField>
                        <asp:HyperLinkField DataNavigateUrlFields="ProjectId,UKEY" DataNavigateUrlFormatString="ContainerProjectAssignRailcar.aspx?ProjectId={0}&amp;Ukey={1}"
                            Text="Assign" />
                    </Columns>
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <EditRowStyle BackColor="#2461BF" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:GridView>
                <asp:SqlDataSource ID="_AvailableDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>"
                    SelectCommand="SELECT @ProjectId AS ProjectId, ATSF.UKEY, ATSF.[Car Number] FROM ATSF INNER JOIN [ATSF Product Type] ON ATSF.[Product Type Ref] = [ATSF Product Type].[ATSF Product ID] WHERE ([ATSF Product Type].[BIS Enable] = 1) AND (ATSF.UKEY NOT IN (SELECT [Railcar Ref] FROM [DWS No Rep Data].dbo.[CPS Project Railcars] WHERE ([Project Ref] = @ProjectId))) AND (ATSF.[Status Flag] IN (1, 2, 3, 4))">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="ProjectId" QueryStringField="ProjectId" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <img src="../Images/arrow_bullet_1.gif" alt="Right Arrow" />
            </td>
            <td valign="top">
                <h3>Assigned Railcars</h3>
                <asp:GridView ID="_AssignedGridview" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Id,UKEY" DataSourceID="_AssignedDatasource" 
                    ForeColor="#333333" GridLines="None" EmptyDataText="There are no railcars assigned to the project." OnRowDeleted="_AssignedGridview_RowDeleted">
                    <RowStyle BackColor="#EFF3FB" />
                    <Columns>
                        <asp:BoundField DataField="Railcar" HeaderText="Railcar" SortExpression="Railcar">
                            <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                        </asp:BoundField>
                        <asp:CommandField ShowDeleteButton="True" >
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle VerticalAlign="Top" />
                        </asp:CommandField>
                    </Columns>
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <EditRowStyle BackColor="#2461BF" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:GridView>
                <asp:SqlDataSource ID="_AssignedDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                    SelectCommand="SELECT [CPS Projects].[Project Id] AS Id, [CPS Projects].[Booking Id] AS Booking, [DWS Rep Data].dbo.ATSF.[Car Number] AS Railcar, [DWS Rep Data].dbo.ATSF.UKEY FROM [CPS Projects] INNER JOIN [CPS Project Railcars] ON [CPS Projects].[Project Id] = [CPS Project Railcars].[Project Ref] INNER JOIN [DWS Rep Data].dbo.ATSF ON [CPS Project Railcars].[Railcar Ref] = [DWS Rep Data].dbo.ATSF.UKEY WHERE ([CPS Projects].[Project Id] = @ProjectId)"
                    DeleteCommand="DELETE FROM [CPS Project Railcars] WHERE [Project Ref]=@Id AND [Railcar Ref]=@UKEY">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="ProjectId" QueryStringField="ProjectId" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:Parameter Name="Id" />
                        <asp:Parameter Name="Ukey" />
                    </DeleteParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>

</asp:Content>
