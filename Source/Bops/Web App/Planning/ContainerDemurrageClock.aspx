<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="Planning_ContainerDemurrageClock" Title="BOPS | Planning | Container Demurrage Clock" Codebehind="ContainerDemurrageClock.aspx.cs" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h2>Container Demurrage Clock</h2>
    <asp:GridView ID="_DemurrageGridview" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="_DemurrageDatasource" ForeColor="#333333" GridLines="None" OnRowDataBound="_DemurrageGridview_RowDataBound" AllowSorting="True" EmptyDataText="There are currently no containers still in process." >
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:BoundField DataField="Container" HeaderText="Container" SortExpression="Container">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Project" HeaderText="Project" InsertVisible="False" ReadOnly="True"
                SortExpression="Project">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Booking" HeaderText="Booking" SortExpression="Booking">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Days" HeaderText="Days" SortExpression="Days">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Begin" HeaderText="Clock Began" SortExpression="Begin">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Remaining" HeaderText="Hours Remaining" ReadOnly="True"
                SortExpression="Remaining">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
        </Columns>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="_DemurrageDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [CPS Demurrage].[Container Ref] AS Container, [CPS Projects].[Project Id] AS Project, [CPS Projects].[Booking Id] AS Booking, [CPS Projects].Description, [CPS Projects].[Demurrage Days] AS Days, [CPS Demurrage].[Clock Begin] AS [Begin], DATEDIFF(HOUR, GETDATE(), DATEADD(DAY, [CPS Projects].[Demurrage Days], [CPS Demurrage].[Clock Begin])) AS Remaining FROM [CPS Demurrage] INNER JOIN [CPS Projects] ON [CPS Demurrage].[Project Ref] = [CPS Projects].[Project Id] WHERE ([CPS Demurrage].[Clock End] IS NULL)">
    </asp:SqlDataSource>

</asp:Content>

