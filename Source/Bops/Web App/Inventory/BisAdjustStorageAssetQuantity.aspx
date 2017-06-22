<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="Inventory_BisAdjustStorageAssetQuantity" Title="BOPS | Bulk Inventory System | Adjust Storage Asset Quantity" Codebehind="BisAdjustStorageAssetQuantity.aspx.cs" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h2>Adjust Storage Asset Quantity</h2>
    <p>
        To manually adjust the remaining quantity of material in a storage asset, choose the asset to adjust, the type of
        adjustment, and provide the amount (in pounds) if needed. Click the "Adjust" button to record the transaction.
    </p>

    <h3>1. Select Storage Source For Withdraw</h3>
    <asp:GridView ID="_SourceGridview" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Id" DataSourceID="_SourceDatasource" 
        ForeColor="#333333" GridLines="None" EmptyDataText="Sorry, no active storage assets with material are available." AllowPaging="True" AllowSorting="True" AutoGenerateSelectButton="True" PageSize="6" >
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
        </Columns>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="_SourceDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [BIS Storage Assets].[Storage Asset Id] AS Id, [BIS Storage Assets].[Storage Type Ref] AS TypeRef, [BIS Storage Types].Name AS Type, [BIS Storage Assets].Name, [BIS Storage Assets].Description, [BIS Storage Assets].[Product Ref] AS ProductRef, [DWS Rep Data].dbo.[ATSF Product Type].[Product Type] AS Product, [BIS Storage Assets].[Current Quantity] AS Quantity FROM [BIS Storage Assets] INNER JOIN [BIS Storage Types] ON [BIS Storage Assets].[Storage Type Ref] = [BIS Storage Types].[Storage Type Id] INNER JOIN [DWS Rep Data].dbo.[ATSF Product Type] ON [BIS Storage Assets].[Product Ref] = [DWS Rep Data].dbo.[ATSF Product Type].[ATSF Product ID] WHERE ([BIS Storage Assets].Active = 1) AND ([BIS Storage Assets].[Current Quantity] > 0)">
    </asp:SqlDataSource>
    
    <p>
        <asp:Label ID="_SourceErrorLabel" runat="server" Visible="false" Text="You must select a storage source for adjustment" ForeColor="red"/>
    </p>
    
    <h3>2. Choose The Type of Adjustment</h3>
    <asp:RadioButtonList ID="_AdjustTypeRadiobuttonlist" runat="server" AutoPostBack="True" OnSelectedIndexChanged="_AdjustTypeRadiobuttonlist_SelectedIndexChanged">
        <asp:ListItem Value="0" Selected="True">Empty Storage Asset</asp:ListItem>
        <asp:ListItem Value="1">Deposit</asp:ListItem>
        <asp:ListItem Value="2">Withdraw</asp:ListItem>
    </asp:RadioButtonList>

    <asp:Panel ID="_AmountPanel" runat="server" Visible="false">

        <h3>3. Specify Amount</h3>
        <asp:Label ID="_QuantityLabel" runat="server" Text="Adjustment Amount:" />
        <asp:TextBox ID="_QuantityTextbox" runat="server" MaxLength="5" />
        <asp:RequiredFieldValidator ID="_QuantityRequiredValidator" runat="server" ControlToValidate="_QuantityTextbox" Display="dynamic"
            ErrorMessage="Required field" />
        <asp:CompareValidator ID="_QuantityNumberValidator" runat="server" ControlToValidate="_QuantityTextbox" Operator="DataTypeCheck" 
            Type="Integer" Display="dynamic" ErrorMessage="Must be a whole number" />
        <asp:CompareValidator ID="_QuantityPositiveValidator" runat="server" ControlToValidate="_QuantityTextbox" ValueToCompare="0" Operator="GreaterThan" 
            Display="dynamic" ErrorMessage="Must be greater than zero" />

    </asp:Panel>

    <p>
        <asp:Label ID="_AdjustErrorLabel" runat="server" Visible="false" Text="An error occurred while trying to record the transaction. You may try again or contact IT support." ForeColor="red"/>
    </p>
    
    <asp:Button ID="_AdjustButton" runat="server" Text="Adjust" OnClick="_AdjustButton_Click" />
       
</asp:Content>

