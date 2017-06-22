<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" Inherits="Inventory_BisContainerProjects" 
    Title="BOPS | Bulk Inventory System | Container Projects" Codebehind="BisContainerProjects.aspx.cs" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <h2>Container Projects</h2>
    <asp:GridView ID="_ProjectsGridview" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False" 
        DataSourceID="_ProjectsDatasource" DataKeyNames="Project Id,Container Id" AllowSorting="True" 
        EmptyDataText="Sorry, but no projects were found involving containers loaded via BIS.">
        <RowStyle BackColor="#EFF3FB" />
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="Project Id" HeaderText="Project Id" InsertVisible="False"
                ReadOnly="True" SortExpression="Project Id" >
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Booking" HeaderText="Booking" SortExpression="Booking" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Bill-To" HeaderText="Bill-To" ReadOnly="True" SortExpression="Bill-To">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Shipping Line" HeaderText="Shipping Line" SortExpression="Shipping Line" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Complete" SortExpression="Complete">
                <ItemTemplate>
                    <asp:Label ID="_CompleteLabel" runat="server" Text='<%# Eval("Complete").ToString().Equals("False") ? "No" : "Yes" %>' />
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
            </asp:TemplateField>
            <asp:BoundField DataField="Product" HeaderText="Product" SortExpression="Product" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:HyperLinkField DataNavigateUrlFields="Project Id,Container Id" DataNavigateUrlFormatString="BisContainerProjectTransactions.aspx?ProjectId={0}&amp;ContainerId={1}"
                DataTextField="Container Id" HeaderText="Container Id" SortExpression="Container Id">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:HyperLinkField>
            <asp:BoundField DataField="Tx Count" HeaderText="Tx Count" ReadOnly="True" SortExpression="Tx Count" DataFormatString="{0:N0}">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Total Weight" HeaderText="Total Weight" ReadOnly="True"
                SortExpression="Total Weight" DataFormatString="{0:N0}">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="_ProjectsDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [CPS Projects].[Project Id], [CPS Projects].[Booking Id] AS Booking, [DWS Rep Data].dbo.tbldestinationList.Destination + ': ' + [DWS Rep Data].dbo.tbldestinationList.City + ', ' + ISNULL([DWS Rep Data].dbo.tbldestinationList.State, '') AS [Bill-To], [CPS Projects].[Shipping Line], [CPS Projects].Complete, [DWS Rep Data].dbo.[ATSF Product Type].[Product Type] AS Product, [BIS CPS Transactions].[Container Ref] AS [Container Id], COUNT([BIS Transactions].[Transaction Id]) AS [Tx Count], SUM([BIS Transactions].Quantity) AS [Total Weight] FROM [BIS CPS Transactions] INNER JOIN [BIS Transactions] ON [BIS CPS Transactions].[BIS Transaction Ref] = [BIS Transactions].[Transaction Id] INNER JOIN [CPS Projects] ON [BIS CPS Transactions].[Project Ref] = [CPS Projects].[Project Id] INNER JOIN [BIS Transaction Types] ON [BIS Transactions].[Transaction Type Ref] = [BIS Transaction Types].[Type Id] INNER JOIN [DWS Rep Data].dbo.[ATSF Product Type] ON [BIS Transactions].[Product Ref] = [DWS Rep Data].dbo.[ATSF Product Type].[ATSF Product ID] INNER JOIN [BIS Storage Assets] ON [BIS Transactions].[Origin Storage Asset Ref] = [BIS Storage Assets].[Storage Asset Id] INNER JOIN [BIS Storage Types] ON [BIS Storage Assets].[Storage Type Ref] = [BIS Storage Types].[Storage Type Id] INNER JOIN [DWS Rep Data].dbo.tbldestinationList ON [CPS Projects].[Bill To Client Ref] = [DWS Rep Data].dbo.tbldestinationList.[Destination id] GROUP BY [CPS Projects].[Booking Id], [CPS Projects].[Shipping Line], [BIS CPS Transactions].[Container Ref], [DWS Rep Data].dbo.[ATSF Product Type].[Product Type], [CPS Projects].Complete, [CPS Projects].[Project Id], [DWS Rep Data].dbo.tbldestinationList.Destination, [DWS Rep Data].dbo.tbldestinationList.City, [DWS Rep Data].dbo.tbldestinationList.State">
    </asp:SqlDataSource>
    
</asp:Content>
