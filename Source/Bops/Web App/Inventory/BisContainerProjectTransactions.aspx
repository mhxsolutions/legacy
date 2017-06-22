<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="Inventory_BisContainerProjectTransactions" Title="BOPS | Bulk Inventory System | Container Details" Codebehind="BisContainerProjectTransactions.aspx.cs" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Container Details</h2>
    
    <h3>Container Data</h3>
    <asp:GridView ID="_ContainerDataGridview" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Project Id,Container Id" DataSourceID="_ContainerDataDatasource" ForeColor="#333333" GridLines="None" >
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:BoundField DataField="Project Id" HeaderText="Project Id" ReadOnly="True" SortExpression="Project Id">
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Booking" HeaderText="Booking" ReadOnly="True" SortExpression="Booking">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Container Id" HeaderText="Container Id" ReadOnly="True"
                SortExpression="Container Id">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Shipping Line" HeaderText="Shipping Line" SortExpression="Shipping Line">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Berth" HeaderText="Berth" SortExpression="Berth">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Seal Id" HeaderText="Seal Id" SortExpression="Seal Id">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Test Id" HeaderText="Test Id" SortExpression="Test Id">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Bill Of Lading" HeaderText="Bill Of Lading" SortExpression="Bill Of Lading">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
        </Columns>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="_ContainerDataDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [BIS CPS Container Data].[Project Ref] AS [Project Id], [CPS Projects].[Booking Id] AS Booking, [BIS CPS Container Data].[Container Ref] AS [Container Id], [CPS Projects].[Shipping Line], [CPS Projects].Berth, [BIS CPS Container Data].[Seal Id], [BIS CPS Container Data].[Test Id], [BIS CPS Container Data].[Bill Of Lading] FROM [BIS CPS Container Data] INNER JOIN [CPS Projects] ON [BIS CPS Container Data].[Project Ref] = [CPS Projects].[Project Id] WHERE ([BIS CPS Container Data].[Project Ref] = @ProjectId) AND ([BIS CPS Container Data].[Container Ref] = @ContainerId)">
        <SelectParameters>
            <asp:QueryStringParameter Name="ProjectId" QueryStringField="ProjectId" />
            <asp:QueryStringParameter Name="ContainerId" QueryStringField="ContainerId" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <h3>Container Transactions</h3>
    <asp:GridView ID="_TxGridview" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="_TxDatasource" ForeColor="#333333" GridLines="None">
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:BoundField DataField="Tx Id" HeaderText="Tx Id" InsertVisible="False" ReadOnly="True"
                SortExpression="Tx Id">
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Tx Type" HeaderText="Tx Type" SortExpression="Tx Type">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="User" HeaderText="User" SortExpression="User">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time" DataFormatString="{0:MM-dd-yy HH:mm}">
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Storage Id" HeaderText="Storage Id" InsertVisible="False"
                ReadOnly="True" SortExpression="Storage Id">
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Storage Name" HeaderText="Storage Name" SortExpression="Storage Name">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" DataFormatString="{0:N0}">
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
    <asp:SqlDataSource ID="_TxDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [BIS Transactions].[Transaction Id] AS [Tx Id], [BIS Transaction Types].Description AS [Tx Type], [BIS Transactions].[User Id] AS [User], [BIS Transactions].Timestamp AS Time, [BIS Storage Assets].[Storage Asset Id] AS [Storage Id], [BIS Storage Assets].Name AS [Storage Name], [BIS Transactions].Quantity FROM [BIS CPS Transactions] INNER JOIN [BIS Transactions] ON [BIS CPS Transactions].[BIS Transaction Ref] = [BIS Transactions].[Transaction Id] INNER JOIN [BIS Transaction Types] ON [BIS Transactions].[Transaction Type Ref] = [BIS Transaction Types].[Type Id] INNER JOIN [BIS Storage Assets] ON [BIS Transactions].[Origin Storage Asset Ref] = [BIS Storage Assets].[Storage Asset Id] INNER JOIN [BIS Storage Types] ON [BIS Storage Assets].[Storage Type Ref] = [BIS Storage Types].[Storage Type Id] WHERE ([BIS CPS Transactions].[Project Ref] = @ProjectId) AND ([BIS CPS Transactions].[Container Ref] = @ContainerId)">
        <SelectParameters>
            <asp:QueryStringParameter Name="ProjectId" QueryStringField="ProjectId" />
            <asp:QueryStringParameter Name="ContainerId" QueryStringField="ContainerId" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

