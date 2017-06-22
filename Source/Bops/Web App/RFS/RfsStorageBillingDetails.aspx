<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="RFS_RfsStorageBillingDetails" Title="BOPS | RFS Storage Billing Details" Codebehind="RfsStorageBillingDetails.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>RFS Storage Billing <% Response.Write(Request.Params["BillingId"]); %> Details</h2>
    <asp:GridView ID="_StorageBillingDetailsGridview" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="_StorageBillingDetailsDatasource" ForeColor="#333333" GridLines="None" AllowSorting="True">
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:BoundField DataField="Billing Detail Id" HeaderText="Detail ID" InsertVisible="False"
                ReadOnly="True" SortExpression="Billing Detail Id" >
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Profile ID" HeaderText="Profile ID" InsertVisible="False"
                ReadOnly="True" SortExpression="Profile ID" >
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Bill-To" HeaderText="Bill-To" SortExpression="Bill-To" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Inventory Ref" HeaderText="Inventory ID" SortExpression="Inventory Ref" >
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Product Class Description" HeaderText="Product Class Description"
                SortExpression="Product Class Description" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" >
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Cycles Billed" HeaderText="Cycles Billed" SortExpression="Cycles Billed" DataFormatString="{0:n2}">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Average Cost Per Cycle" HeaderText="Average Rate" SortExpression="Average Cost Per Cycle" DataFormatString="{0:c}">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Revenue" HeaderText="Revenue" SortExpression="Revenue" DataFormatString="{0:c}">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Public Details" HeaderText="Public Details"
                SortExpression="Public Details" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Private Details" HeaderText="Private Details"
                SortExpression="Private Details" >
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
    <asp:SqlDataSource ID="_StorageBillingDetailsDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [RFS Storage Billing Details].[Billing Detail Id], [Product Profiles].[Profile ID], [DWS Rep Data].dbo.tbldestinationList.Destination + ': ' + [DWS Rep Data].dbo.tbldestinationList.City + ', ' + ISNULL([DWS Rep Data].dbo.tbldestinationList.State, '') AS [Bill-To], [RFS Storage Billing Details].[Inventory Ref], [Product Profiles].[Product Class Description], [RFS Storage Billing Details].Quantity, [RFS Storage Billing Details].[Cycles Billed], [RFS Storage Billing Details].[Average Cost Per Cycle], [RFS Storage Billing Details].Revenue, [RFS Storage Billing Details].[Public Details], [RFS Storage Billing Details].[Private Details] FROM [RFS Storage Billing Details] INNER JOIN [Product Profiles] ON [RFS Storage Billing Details].[Profile Ref] = [Product Profiles].[Profile ID] INNER JOIN [DWS Rep Data].dbo.tbldestinationList ON [RFS Storage Billing Details].[Bill To Client Ref] = [DWS Rep Data].dbo.tbldestinationList.[Destination id] WHERE ([RFS Storage Billing Details].[Billing Ref] = @BillingId)">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="BillingId" QueryStringField="BillingId" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

