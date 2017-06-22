<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" Inherits="RFS_RfsStorageBillings" 
    Title="BOPS | RFS Storage Billings" Codebehind="RfsStorageBillings.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h2>RFS Storage Billings</h2>
    <asp:GridView ID="_StorageBillingsGridview" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Billing Id" DataSourceID="_StorageBillingsDatasource" ForeColor="#333333" GridLines="None" AllowSorting="True">
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:HyperLinkField DataTextField="Billing Id" HeaderText="ID" SortExpression="Billing Id" DataNavigateUrlFields="Billing Id"
                DataNavigateUrlFormatString="RfsStorageBillingDetails.aspx?BillingId={0}">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:HyperLinkField>
            <asp:BoundField DataField="Date Billed Through" HeaderText="Billed Through"
                SortExpression="Date Billed Through" DataFormatString="{0:d}">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Date Generated" HeaderText="Date Generated" SortExpression="Date Generated" DataFormatString="{0:d}">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="User Id" HeaderText="User Id" SortExpression="User Id" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Total Items Processed" HeaderText="Total Items"
                SortExpression="Total Items Processed" >
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Total Revenue" HeaderText="Total Revenue" SortExpression="Total Revenue" DataFormatString="{0:c}">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Date Invoiced" HeaderText="Date Invoiced" SortExpression="Date Invoiced" DataFormatString="{0:d}">
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
    <asp:SqlDataSource ID="_StorageBillingsDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Billing Id], [Date Billed Through], [Date Generated], [User Id], [Total Items Processed], [Total Revenue], [Date Invoiced] FROM [RFS Storage Billings]">
    </asp:SqlDataSource>

</asp:Content>

