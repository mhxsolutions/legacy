<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" Inherits="Planning_ContainerProjectRailcarsFromProject" 
    Title="BOPS | Container Project Railcars" Codebehind="ContainerProjectRailcarsFromProject.aspx.cs" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Container Project Railcars </h2>
    <p>
        To copy the railcars from another container project, find it in the list of other projects with railcars and
        click the link. NB: Any railcars already assigned to the target project will be replaced.
    </p>

    <h3>Target Project Details</h3>
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

    <h3>Other Projects With Railcars</h3>
    <asp:GridView ID="_OtherProjectsGridview" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Project Id" DataSourceID="_OtherProjectsDatasource" 
        ForeColor="#333333" GridLines="None" EmptyDataText="No other open container projects have rail cars assigned.">
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:BoundField DataField="Project Id" HeaderText="Id" InsertVisible="False" ReadOnly="True"
                SortExpression="Project Id" >
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Booking Id" HeaderText="Booking" SortExpression="Booking Id" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Berth" HeaderText="Berth" SortExpression="Berth" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Shipping Line" HeaderText="Shipping Line" SortExpression="Shipping Line" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Begin Date" HeaderText="Begin Date" SortExpression="Begin Date"  DataFormatString="{0:MM-dd-yyyy}">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Demurrage Days" HeaderText="Days" SortExpression="Demurrage Days" >
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Total Containers" HeaderText="Containers" SortExpression="Total Containers" >
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Count" HeaderText="Railcar Count" ReadOnly="True" SortExpression="Count" >
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton ID="_CopyRailcarsLinkbutton" runat="server" Text="Copy Railcars"
                        PostBackUrl='<%# string.Format("ContainerProjectAssignRailcarsFromProject.aspx?SourceProjectId={0}&DestinationProjectId={1}", Eval("Project Id"), Request.QueryString["ProjectId"] ) %>'>
                    </asp:LinkButton>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:TemplateField>
            
        </Columns>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="_OtherProjectsDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [CPS Projects].[Project Id], [CPS Projects].[Booking Id], [CPS Projects].Description, [CPS Projects].Berth, [CPS Projects].[Shipping Line], [CPS Projects].[Begin Date], [CPS Projects].[Demurrage Days], [CPS Projects].[Total Containers], COUNT([CPS Project Railcars].[Railcar Ref]) AS Count FROM [CPS Projects] INNER JOIN [CPS Project Railcars] ON [CPS Projects].[Project Id] = [CPS Project Railcars].[Project Ref] WHERE ([CPS Projects].Complete = 0) GROUP BY [CPS Projects].[Project Id], [CPS Projects].[Booking Id], [CPS Projects].Description, [CPS Projects].Berth, [CPS Projects].[Shipping Line], [CPS Projects].[Begin Date], [CPS Projects].[Demurrage Days], [CPS Projects].[Total Containers] HAVING ([CPS Projects].[Project Id] <> @ProjectId)">
        <SelectParameters>
            <asp:QueryStringParameter Name="ProjectId" QueryStringField="ProjectId" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>

