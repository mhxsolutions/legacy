<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" Inherits="Planning_ContainerPlanner" 
    Title="BOPS | Container Project Planner" Codebehind="ContainerPlanner.aspx.cs" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Container Project Planner</h2>
    <asp:GridView ID="_ProjectsGridview" runat="server" CellPadding="4" DataSourceID="_ProjectsDatasource" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False" DataKeyNames="Project Id" AllowPaging="True" AllowSorting="True" PageSize="20" Font-Size="Smaller">
        <EmptyDataTemplate>
            There are no container projects at the present time.
        </EmptyDataTemplate>
        <RowStyle BackColor="#EFF3FB" Wrap="False" />
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" Wrap="False" />
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:HyperLink ID="_AssignRailcarsHyperlink" runat="server" NavigateUrl='<%# Eval("Project Id","ContainerProjectRailcars.aspx?ProjectId={0}") %>' 
                        Visible='<%#Eval("Complete").ToString().Equals("No")%>' Text="Railcars" />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:TemplateField>
            <asp:HyperLinkField Text="View Moves" DataNavigateUrlFields="Project Id" DataNavigateUrlFormatString="ContainerMoveHistory.aspx?ProjectId={0}">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:HyperLinkField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:HyperLink ID="_EnterMovesHyperlink" runat="server" NavigateUrl='<%# Eval("Project Id","ContainerMoveEntry.aspx?ProjectId={0}") %>' 
                        Visible='<%#Eval("Complete").ToString().Equals("No")%>' Text="Enter Moves" />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:TemplateField>
            <asp:BoundField DataField="Project Id" HeaderText="Proj ID" InsertVisible="False" ReadOnly="True" SortExpression="Project Id">
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
            <asp:BoundField DataField="Begin Date" HeaderText="Begin" SortExpression="Begin Date" DataFormatString="{0:MM-dd-yy}">
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
        SelectCommand="SELECT [CPS Projects].[Project Id], [DWS Rep Data].dbo.tbldestinationList.Destination + ': ' + [DWS Rep Data].dbo.tbldestinationList.City + ', ' + ISNULL([DWS Rep Data].dbo.tbldestinationList.State, '') AS [Bill To Client], [CPS Projects].[Booking Id], [CPS Projects].Description, [CPS Projects].Berth, [CPS Projects].[Shipping Line], tbldestinationList_1.Destination + ': ' + tbldestinationList_1.City + ', ' + ISNULL(tbldestinationList_1.State, '') AS [Default Origin], tbldestinationList_2.Destination + ': ' + tbldestinationList_2.City + ', ' + ISNULL(tbldestinationList_2.State, '') AS [Default Destination], [CPS Projects].[Begin Date], [CPS Projects].[Demurrage Days], [CPS Projects].[Total Containers], CASE WHEN [Complete] = 1 THEN 'Yes' ELSE 'No' END AS Complete FROM [CPS Projects] INNER JOIN [DWS Rep Data].dbo.tbldestinationList ON [CPS Projects].[Bill To Client Ref] = [DWS Rep Data].dbo.tbldestinationList.[Destination id] INNER JOIN [DWS Rep Data].dbo.tbldestinationList AS tbldestinationList_1 ON [CPS Projects].[Default Origin Ref] = tbldestinationList_1.[Destination id] INNER JOIN [DWS Rep Data].dbo.tbldestinationList AS tbldestinationList_2 ON [CPS Projects].[Default Destination Ref] = tbldestinationList_2.[Destination id] ORDER BY [CPS Projects].[Project Id] DESC">
    </asp:SqlDataSource>
    
    <br />
    <asp:HyperLink ID="_CreateNewProjectHyperlink" runat="server" NavigateUrl="ContainerCreateProject.aspx" Text="Click here to create a new container project." />
   
</asp:Content>

