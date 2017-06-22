<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="Planning_ContainerMoveHistory" Title="BOPS | Planning | Container Move History" Codebehind="ContainerMoveHistory.aspx.cs" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Container Move History</h2>
    
    <p>
        <asp:Label ID="_ProjectInformationLabel" runat="server" />
        <asp:Button ID="_ExportToExcelButton" runat="server" OnClick="_ExportToExcelButton_Click" Text="Export to Excel" />
    </p>
    
    <asp:GridView ID="_MovesGridview" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="_MovesDatasource" ForeColor="#333333" GridLines="None" AllowSorting="True" PageSize="20" Font-Size="Small">
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:BoundField DataField="MoveId" HeaderText="Move ID" InsertVisible="False"
                ReadOnly="True" SortExpression="MoveId" >
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Container" HeaderText="Container" SortExpression="Container" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Origin" HeaderText="Origin" ReadOnly="True" SortExpression="Origin" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Departed" HeaderText="Departed" SortExpression="Departed" DataFormatString="{0:MM-dd-yyyy HH:mm}" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Destination" HeaderText="Destination" ReadOnly="True"
                SortExpression="Destination" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Arrived" HeaderText="Arrived" SortExpression="Arrived" DataFormatString="{0:MM-dd-yyyy HH:mm}" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="PUR" HeaderText="PUR" SortExpression="PUR" >
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" />
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
    <asp:SqlDataSource ID="_MovesDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [CPS Movements].[Movement Id] AS MoveId, [CPS Movements].[Container Ref] AS Container, tbldestinationList_Origin.Destination + N': ' + tbldestinationList_Origin.City + N', ' + ISNULL(tbldestinationList_Origin.State, N'') AS Origin, [CPS Movements].[Origin Timestamp] AS Departed, tbldestinationList_Destination.Destination + N': ' + tbldestinationList_Destination.City + N', ' + ISNULL(tbldestinationList_Destination.State, N'') AS Destination, [CPS Movements].[Destination Timestamp] AS Arrived, [CPS Movements].[Pickup Request Ref] AS PUR FROM [CPS Projects] INNER JOIN [CPS Movements] ON [CPS Projects].[Project Id] = [CPS Movements].[Project Ref] INNER JOIN [CPS Containers] ON [CPS Movements].[Container Ref] = [CPS Containers].[Container Id] INNER JOIN [DWS Rep Data].dbo.tbldestinationList AS tbldestinationList_Origin ON [CPS Movements].[Origin Ref] = tbldestinationList_Origin.[Destination id] INNER JOIN [DWS Rep Data].dbo.tbldestinationList AS tbldestinationList_Destination ON [CPS Movements].[Destination Ref] = tbldestinationList_Destination.[Destination id] WHERE ([CPS Projects].[Project Id] = @ProjectId)">
        <SelectParameters>
            <asp:QueryStringParameter Name="ProjectId" QueryStringField="ProjectId" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <p>
        <a href="ContainerPlanner.aspx">Click here to return to the container planner.</a>
    </p>
    
</asp:Content>
