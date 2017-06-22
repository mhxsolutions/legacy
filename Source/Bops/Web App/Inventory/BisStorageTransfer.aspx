<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="Inventory_BisStorageTransfer" Title="BOPS | Bulk Inventory System | Transfer" Codebehind="BisStorageTransfer.aspx.cs" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Transfer</h2>
    <h3>Origin Storage Asset</h3>
    <asp:GridView ID="_OriginGridview" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="_OriginDatasource" ForeColor="#333333" 
        GridLines="None" EmptyDataText="Origin storage asset not found.">
        <RowStyle BackColor="#EFF3FB" />
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                SortExpression="Id" >
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type" >
                <HeaderStyle HorizontalAlign="Left" />
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" >
                <HeaderStyle HorizontalAlign="Left" />
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" >
                <HeaderStyle HorizontalAlign="Left" />
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="Product" HeaderText="Product" SortExpression="Product" >
                <HeaderStyle HorizontalAlign="Left" />
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" DataFormatString="{0:N0}">
                <HeaderStyle HorizontalAlign="Right" />
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="_OriginDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [BIS Storage Assets].[Storage Asset Id] AS Id, [BIS Storage Assets].[Storage Type Ref] AS TypeRef, [BIS Storage Types].Name AS Type, [BIS Storage Assets].Name, [BIS Storage Assets].Description, [BIS Storage Assets].[Product Ref] AS ProductRef, [DWS Rep Data].dbo.[ATSF Product Type].[Product Type] AS Product, [BIS Storage Assets].[Current Quantity] AS Quantity, [BIS Storage Assets].Active FROM [BIS Storage Assets] INNER JOIN [BIS Storage Types] ON [BIS Storage Assets].[Storage Type Ref] = [BIS Storage Types].[Storage Type Id] INNER JOIN [DWS Rep Data].dbo.[ATSF Product Type] ON [BIS Storage Assets].[Product Ref] = [DWS Rep Data].dbo.[ATSF Product Type].[ATSF Product ID] WHERE ([BIS Storage Assets].Active = 1) AND ([BIS Storage Assets].[Current Quantity] > 0) AND ([BIS Storage Assets].[Storage Asset Id] = @AssetId)">
        <SelectParameters>
            <asp:QueryStringParameter Name="AssetId" QueryStringField="AssetId" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <h3>Destination Storage Asset</h3>
    <asp:GridView ID="_DestinationGridview" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="ID" DataSourceID="_DestinationDatasource" 
        ForeColor="#333333" GridLines="None" AutoGenerateSelectButton="True" EmptyDataText="No destination storage assets found that are empty or have the same product type.">
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                SortExpression="Id" >
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type" >
                <HeaderStyle HorizontalAlign="Left" />
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" >
                <HeaderStyle HorizontalAlign="Left" />
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" >
                <HeaderStyle HorizontalAlign="Left" />
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="Product" HeaderText="Product" SortExpression="Product" >
                <HeaderStyle HorizontalAlign="Left" />
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" DataFormatString="{0:N0}">
                <HeaderStyle HorizontalAlign="Right" />
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
        </Columns>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="_DestinationDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [BIS Storage Assets].[Storage Asset Id] AS ID, [BIS Storage Types].Name AS Type, [BIS Storage Assets].Name, [BIS Storage Assets].Description, [BIS Storage Assets].[Product Ref] AS ProductRef, [DWS Rep Data].dbo.[ATSF Product Type].[Product Type] AS Product, [BIS Storage Assets].[Current Quantity] AS Quantity FROM [BIS Storage Assets] INNER JOIN [BIS Storage Types] ON [BIS Storage Assets].[Storage Type Ref] = [BIS Storage Types].[Storage Type Id] INNER JOIN [DWS Rep Data].dbo.[ATSF Product Type] ON [BIS Storage Assets].[Product Ref] = [DWS Rep Data].dbo.[ATSF Product Type].[ATSF Product ID] WHERE ([BIS Storage Assets].Active = 1) AND ([BIS Storage Assets].[Storage Asset Id] <> @AssetId) AND ([BIS Storage Assets].[Current Quantity] = 0) OR ([BIS Storage Assets].Active = 1) AND ([BIS Storage Assets].[Storage Asset Id] <> @AssetId) AND ([BIS Storage Assets].[Product Ref] = @ProductId)">
        <SelectParameters>
            <asp:QueryStringParameter Name="AssetId" QueryStringField="AssetId" />
            <asp:QueryStringParameter Name="ProductId" QueryStringField="ProductId" />
        </SelectParameters>
    </asp:SqlDataSource>

    <p>
        <asp:Label ID="_DestinationErrorLabel" runat="server" Visible="false" Text="You must select a storage destination for transfer" ForeColor="red"/>
    </p>
    
    Quantity: <asp:TextBox ID="_QuantityTextbox" runat="server" MaxLength="5" />
    <asp:RequiredFieldValidator ID="_QuantityRequiredValidator" runat="server" ControlToValidate="_QuantityTextbox" Display="dynamic"
        ErrorMessage="Required" />
    <asp:CompareValidator ID="_QuantityNumberValidator" runat="server" ControlToValidate="_QuantityTextbox" Operator="DataTypeCheck" 
        Type="Integer" Display="dynamic" ErrorMessage="Must be a whole number" />
    <asp:CompareValidator ID="_QuantityPositiveValidator" runat="server" ControlToValidate="_QuantityTextbox" ValueToCompare="0" Operator="GreaterThan" 
        Display="dynamic" ErrorMessage="Must be greater than zero" />

    <p>
        <asp:Label ID="_TransferErrorLabel" runat="server" Visible="false" Text="An error occurred while trying to record the transaction. You may try again or contact IT support." ForeColor="red"/>
    </p>

    <asp:Button ID="_TransferButton" runat="server" Text="Transfer" OnClick="_TransferButton_Click" />
        
</asp:Content>
