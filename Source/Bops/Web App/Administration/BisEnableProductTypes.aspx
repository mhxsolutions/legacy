<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="Administration_BisEnableProductTypes" Title="BOPS | Administration | BIS Enable Product Types" Codebehind="BisEnableProductTypes.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>BIS Enable Product Types</h2>
    <p>To enable or disable a product type for use with the Bulk Inventory System (BIS), click the edit link and set the flag as required.</p>
    <asp:GridView ID="_ProductGridview" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="ATSF_Product_ID" 
        DataSourceID="_ProductsDatasource" ForeColor="#333333" GridLines="None" AllowSorting="True" EmptyDataText="Sorry, no products found.">
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:BoundField DataField="ATSF_Product_ID" HeaderText="ID" InsertVisible="False"
                ReadOnly="True" SortExpression="ATSF_Product_ID">
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Product_Type" HeaderText="Product" SortExpression="Product_Type" ReadOnly="True">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:CheckBoxField DataField="BIS_Enable" HeaderText="BIS Enabled" SortExpression="BIS_Enable">
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
            </asp:CheckBoxField>
            <asp:CommandField ShowEditButton="True" />
        </Columns>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="_ProductsDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS Rep DataConnectionString %>"
        SelectCommand="SELECT [ATSF Product ID] AS ATSF_Product_ID, [Product Type] AS Product_Type, [BIS Enable] AS BIS_Enable FROM [ATSF Product Type] ORDER BY [Product Type]"
        UpdateCommand="UPDATE [ATSF Product Type] SET [BIS Enable]=@BIS_Enable WHERE [ATSF Product ID]=@ATSF_Product_ID">
    </asp:SqlDataSource>
</asp:Content>

