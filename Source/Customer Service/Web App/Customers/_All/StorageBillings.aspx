<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_StorageBillings" 
    Title="BudwayDirect | Storage Billings" CodeBehind="StorageBillings.aspx.cs" CodeFile="StorageBillings.aspx.cs"%>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Storage Billings</h2>
    <asp:GridView ID="_StorageBillingsGridview" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Billing Id" DataSourceID="_StorageBillingsDatasource" ForeColor="#333333" GridLines="None">
        <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
        <Columns>
            <asp:BoundField DataField="Billing Id" HeaderText="Billing Id" InsertVisible="False"
                ReadOnly="True" SortExpression="Billing Id" >
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Date Billed Through" HeaderText="Date Billed Through"
                SortExpression="Date Billed Through" DataFormatString="{0:d}" >
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Client" HeaderText="Bill-To Client" SortExpression="Client" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Items" HeaderText="Items" ReadOnly="True" SortExpression="Items" >
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
        </Columns>
        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="_StorageBillingsDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [RFS Storage Billings].[Billing Id], [RFS Storage Billings].[Date Billed Through], [RFS Storage Billing Details].[Bill To Client Ref], COUNT([RFS Storage Billing Details].[Billing Detail Id]) AS Items, [DWS Rep Data].dbo.tbldestinationList.Destination + N': ' + [DWS Rep Data].dbo.tbldestinationList.City + N', ' + ISNULL([DWS Rep Data].dbo.tbldestinationList.State, N'') AS Client FROM [RFS Storage Billing Details] INNER JOIN [RFS Storage Billings] ON [RFS Storage Billing Details].[Billing Ref] = [RFS Storage Billings].[Billing Id] INNER JOIN [DWS Rep Data].dbo.tbldestinationList ON [RFS Storage Billing Details].[Bill To Client Ref] = [DWS Rep Data].dbo.tbldestinationList.[destination Id] GROUP BY [RFS Storage Billings].[Billing Id], [RFS Storage Billings].[Date Billed Through], [RFS Storage Billing Details].[Bill To Client Ref], [DWS Rep Data].dbo.tbldestinationList.Destination + N': ' + [DWS Rep Data].dbo.tbldestinationList.City + N', ' + ISNULL([DWS Rep Data].dbo.tbldestinationList.State, N'') HAVING (@ClientId = 166073081) OR ([RFS Storage Billing Details].[Bill To Client Ref] = @ClientId) ORDER BY [RFS Storage Billings].[Date Billed Through]">
        <SelectParameters>
            <asp:SessionParameter Name="ClientId" SessionField="CONTEXT_CLIENTID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
