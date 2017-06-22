<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="Planning_ContainerProjectsSummary" Title="BOPS | Planning | Container Projects Summary" Codebehind="ContainerProjectsSummary.aspx.cs" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Container Projects Summary</h2>
    <p>
        The following table shows the projects and their calculated pickups, returns, and
        custom moves, which are determined by matching the O/D pairs in the move records
        against the O/D pair specified in the project. If the project origin matches the
        move origin, then it's a pickup; if the project origin matches the move destination,
        then it's a return; otherwise, it's considered a custom move.
    </p>
        
    <asp:GridView ID="_ProjectsGridview" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Project Id" DataSourceID="_SummaryDatasource" ForeColor="#333333" GridLines="None" PageSize="20" >
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:BoundField DataField="Project Id" HeaderText="Project Id" InsertVisible="False"
                ReadOnly="True" SortExpression="Project Id">
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Booking Id" HeaderText="Booking Id" SortExpression="Booking Id">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Total Containers" HeaderText="Total Containers" SortExpression="Total Containers">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Pickups" HeaderText="Pickups" ReadOnly="True" SortExpression="Pickups">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Returns" HeaderText="Returns" ReadOnly="True" SortExpression="Returns">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Custom Moves" HeaderText="Custom Moves" ReadOnly="True" SortExpression="Custom Moves">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Complete" HeaderText="Complete" ReadOnly="True" SortExpression="Complete">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:HyperLink ID="_CloseProjectHyperlink" runat="server" NavigateUrl='<%# Eval("Project Id","ContainerConfirmProjectClose.aspx?ProjectId={0}") %>' 
                        Visible='<%# Eval("Complete").ToString().Equals("False") && Eval("Pickups").ToString().Equals(Eval("Returns").ToString())%>' Text="Close Project" />
                </ItemTemplate>
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
    <asp:SqlDataSource ID="_SummaryDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [CPS Projects].[Project Id], [CPS Projects].[Booking Id], [CPS Projects].Description, [CPS Projects].[Total Containers], SUM(CASE WHEN [Default Origin Ref] = [Origin Ref] THEN 1 ELSE 0 END) AS Pickups, SUM(CASE WHEN [Default Origin Ref] = [Destination Ref] THEN 1 ELSE 0 END) AS [Returns], SUM(CASE WHEN [Default Origin Ref] <> [Origin Ref] AND [Default Origin Ref] <> [Destination Ref] THEN 1 ELSE 0 END) AS [Custom Moves], [CPS Projects].Complete FROM [CPS Projects] INNER JOIN [CPS Movements] ON [CPS Projects].[Project Id] = [CPS Movements].[Project Ref] GROUP BY [CPS Projects].[Project Id], [CPS Projects].[Booking Id], [CPS Projects].Description, [CPS Projects].[Total Containers], [CPS Projects].Complete">
    </asp:SqlDataSource>
</asp:Content>

