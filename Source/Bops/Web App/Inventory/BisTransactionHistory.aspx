<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="Inventory_BisTransactionHistory" Title="BOPS | Bulk Inventory System | Transaction History" Codebehind="BisTransactionHistory.aspx.cs" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2><asp:Label ID="_PageTitleLabel" runat="server" Text="Transaction History"/></h2>
    
    <p>
        <asp:Button ID="_ShowAllButton" runat="server" Visible="false" Text="Show All Transactions" OnClick="_ShowAllButton_Click" />
    </p>
    
    <asp:GridView ID="_HistoryGridview" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="_TransactionHistoryDatasource" 
        ForeColor="#333333" GridLines="None" AllowPaging="True" AllowSorting="True" PageSize="25" 
        EmptyDataText="No transactions are available or match the current filter setting.">
        
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:BoundField DataField="Tx Id" HeaderText="Tx Id" InsertVisible="False" ReadOnly="True"
                SortExpression="Tx Id" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Tx Type" HeaderText="Tx Type" SortExpression="Tx Type" >
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="User" HeaderText="User" SortExpression="User" >
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time" DataFormatString="{0:MM-dd-yy HH:mm}" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Origin Id" HeaderText="Origin Id" InsertVisible="False"
                ReadOnly="True" SortExpression="Origin Id" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Origin Type" HeaderText="Origin Type" SortExpression="Origin Type" >
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" >
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" DataFormatString="{0:N0}">
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Destination Type" HeaderText="Destination Type" SortExpression="Destination Type" >
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Destination Ref" HeaderText="Destination Id" SortExpression="Destination Ref" >
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
        </Columns>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="_TransactionHistoryDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [BIS Storage Assets].[Storage Asset Id] AS [Origin Id], [BIS Storage Types].Name AS [Origin Type], [BIS Storage Assets].Name, [BIS Transactions].[Transaction Id] AS [Tx Id], [BIS Transaction Types].Description AS [Tx Type], [BIS Transactions].[User Id] AS [User], [BIS Transactions].Timestamp AS Time, [BIS Transactions].Quantity, [BIS Storage Types_1].Name AS [Destination Type], [BIS Transactions].[Destination Storage Asset Ref] AS [Destination Ref] FROM [BIS Transactions] INNER JOIN [BIS Transaction Types] ON [BIS Transactions].[Transaction Type Ref] = [BIS Transaction Types].[Type Id] INNER JOIN [BIS Storage Assets] ON [BIS Transactions].[Origin Storage Asset Ref] = [BIS Storage Assets].[Storage Asset Id] INNER JOIN [BIS Storage Types] ON [BIS Storage Assets].[Storage Type Ref] = [BIS Storage Types].[Storage Type Id] INNER JOIN [BIS Storage Types] AS [BIS Storage Types_1] ON [BIS Transactions].[Destination Storage Asset Type Ref] = [BIS Storage Types_1].[Storage Type Id]">
    </asp:SqlDataSource>
</asp:Content>
