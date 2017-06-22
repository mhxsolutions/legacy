<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_InvoiceHistory" 
    Title="BudwayDirect | Invoice History" CodeBehind="InvoiceHistory.aspx.cs" CodeFile="InvoiceHistory.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h2>
        Invoice History</h2>
    <asp:GridView ID="GridView1" runat="server" CellPadding="4"
        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
        DataSourceID="InvoiceHistoryDatasource" PageSize="25" BackColor="White" 
        BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px">
        <RowStyle BackColor="White" ForeColor="#330099" />
        <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
        <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
        <Columns>
            <asp:HyperLinkField HeaderText="Invoice" DataTextField="ID" DataNavigateUrlFields="ID"
                SortExpression="ID" 
                DataNavigateUrlFormatString="InvoiceDisplay.aspx?InvoiceId={0}">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" />
            </asp:HyperLinkField>
            <asp:BoundField DataField="Date" DataFormatString="{0:d}" HeaderText="Date" SortExpression="Date">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Hide From Clients" HeaderText="Hidden" SortExpression="Hide From Clients">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Shipper" HeaderText="Shipper" SortExpression="Shipper">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Bill-To" HeaderText="Bill-To" SortExpression="Bill-To">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Total" DataFormatString="{0:c}" HeaderText="Total" SortExpression="Total">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Notes" HeaderText="Notes" SortExpression="Notes">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" />
            </asp:BoundField>
            <asp:HyperLinkField HeaderText="POD scans" Text="View" DataNavigateUrlFields="ID"
                DataNavigateUrlFormatString="InvoiceSupportingDocumentsDisplay.aspx?InvoiceId={0}">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" />
            </asp:HyperLinkField>
        </Columns>
        <SortedAscendingCellStyle BackColor="#FEFCEB" />
        <SortedAscendingHeaderStyle BackColor="#AF0101" />
        <SortedDescendingCellStyle BackColor="#F6F0C0" />
        <SortedDescendingHeaderStyle BackColor="#7E0000" />
    </asp:GridView>
    <asp:SqlDataSource ID="InvoiceHistoryDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        
        SelectCommand="SELECT [RFS Invoices].[RFS Invoice Id] AS ID, [RFS Invoices].[Invoice Date] AS Date, [RFS Invoices].[Shipper Client Ref], tbldestinationList1.Destination AS Shipper, [RFS Invoices].[Bill To Client Ref], tbldestinationList2.Destination AS [Bill-To], [RFS Invoices].[Invoice Total] AS Total, [RFS Invoices].[Public Notes] AS Notes, [RFS Invoices].[Hide From Clients] FROM [RFS Invoices] LEFT OUTER JOIN [DWS Rep Data].dbo.tbldestinationList AS tbldestinationList1 ON [RFS Invoices].[Shipper Client Ref] = tbldestinationList1.[Destination id] LEFT OUTER JOIN [DWS Rep Data].dbo.tbldestinationList AS tbldestinationList2 ON [RFS Invoices].[Bill To Client Ref] = tbldestinationList2.[Destination id] WHERE ([RFS Invoices].[Invoice Status Ref] &gt; 3) AND ([RFS Invoices].[Bill To Client Ref] = @BillToClient) AND ([RFS Invoices].[Hide From Clients] = 0) OR ([RFS Invoices].[Invoice Status Ref] &gt; 3) AND (166073081 = @BillToClient) ORDER BY ID DESC">
        <SelectParameters>
            <asp:SessionParameter Name="BillToClient" SessionField="CONTEXT_CLIENTID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
