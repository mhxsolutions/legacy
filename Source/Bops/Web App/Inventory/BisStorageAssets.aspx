
<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" Inherits="Inventory_BisStorageAssets" 
    Title="BOPS | Bulk Inventory System | Storage Assets" Codebehind="BisStorageAssets.aspx.cs" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Storage Assets</h2>
    <asp:GridView ID="_StorageAssetsGridview" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Id" DataSourceID="_StorageAssetsDatasource" 
    ForeColor="#333333" GridLines="None" EmptyDataText="Sorry, no active storage assets are available." OnRowDataBound="_StorageAssetsGridview_RowDataBound" >
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                SortExpression="Id" >
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Product" HeaderText="Product" SortExpression="Product" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" DataFormatString="{0:N0}">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:HyperLinkField DataNavigateUrlFields="Id" DataNavigateUrlFormatString="BisTransactionHistory.aspx?AssetId={0}" Text="History" />
            
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="_TransferLinkbutton" runat="server" Text="Transfer" />
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="_DeactivateLinkbutton" runat="server" Text="Deactivate"  
                        OnClientClick='return confirm("Are you sure you want to deactivate the storage asset?");' />
                </ItemTemplate>
            </asp:TemplateField>
            
        </Columns>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="_StorageAssetsDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [BIS Storage Assets].[Storage Asset Id] AS Id, [BIS Storage Assets].[Storage Type Ref] AS TypeRef, [BIS Storage Types].Name AS Type, [BIS Storage Assets].Name, [BIS Storage Assets].Description, [BIS Storage Assets].[Product Ref] AS ProductRef, [DWS Rep Data].dbo.[ATSF Product Type].[Product Type] AS Product, [BIS Storage Assets].[Current Quantity] AS Quantity FROM [BIS Storage Assets] INNER JOIN [BIS Storage Types] ON [BIS Storage Assets].[Storage Type Ref] = [BIS Storage Types].[Storage Type Id] INNER JOIN [DWS Rep Data].dbo.[ATSF Product Type] ON [BIS Storage Assets].[Product Ref] = [DWS Rep Data].dbo.[ATSF Product Type].[ATSF Product ID] WHERE ([BIS Storage Assets].Active = 1)">
    </asp:SqlDataSource>
    
    <h3>Create New Storage Asset</h3>
    <p>
        <a href="BisStorageCreateAssetFromRailcar.aspx">Click here to create a new storage asset from a railcar.</a><br />
        <a href="BisStorageCreateSiloAsset.aspx">Click here to create a new silo.</a>
    </p>
</asp:Content>
