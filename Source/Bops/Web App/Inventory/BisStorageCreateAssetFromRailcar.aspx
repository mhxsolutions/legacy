<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" Inherits="Inventory_BisStorageCreateAssetFromRailcar" 
    Title="BOPS | Bulk Inventory System | Create Storage Asset From Railcar" Codebehind="BisStorageCreateAssetFromRailcar.aspx.cs" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Create Storage Asset From Railcar</h2>
    <p>
        The following is the list of railcars that are on site, in the relevant state, and have a known cargo weight. 
        Click the link to create a new storage asset from a railcar.
    </p>
    <asp:GridView ID="_RailcarsGridview" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Ukey" DataSourceID="_RailcarsDatasource" 
        ForeColor="#333333" GridLines="None" EmptyDataText="Sorry, but no rail cars are available to create new storage assets.">
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:BoundField DataField="CarNumber" HeaderText="Car Number" SortExpression="CarNumber" >
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
            <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
           
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <a href="BisStorageCreateAssetFromRailcarUkey.aspx?Ukey=<%# Eval("Ukey") %>"
                        onclick='return confirm("Are you sure you want to create the new storage asset?");'>Create</a>
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
    <asp:SqlDataSource ID="_RailcarsDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>"
        SelectCommand="SELECT ATSF.UKEY AS Ukey, ATSF.[Car Number] AS CarNumber, [ATSF Product Type].[Product Type] AS Product, ATSF.billwgt AS Quantity, ATSF.[Status Flag], [ATSF Status].Status, [ATSF Product Type].[BIS Enable] FROM ATSF INNER JOIN [ATSF Product Type] ON ATSF.[Product Type Ref] = [ATSF Product Type].[ATSF Product ID] INNER JOIN [ATSF Status] ON ATSF.[Status Flag] = [ATSF Status].[Status Flag ID] LEFT OUTER JOIN [DWS No Rep Data].dbo.[BIS Storage Assets] ON ATSF.UKEY = [DWS No Rep Data].dbo.[BIS Storage Assets].[Original Asset Ref] WHERE (ATSF.billwgt > 0) AND (ATSF.[Status Flag] IN (2, 3, 4)) AND ([DWS No Rep Data].dbo.[BIS Storage Assets].[Storage Asset Id] IS NULL) AND ([ATSF Product Type].[BIS Enable] = 1)">
    </asp:SqlDataSource>
</asp:Content>
