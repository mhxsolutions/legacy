<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__Assigned_encana_encana_release_details" Title="Release Details" Codebehind="encana_release_details.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Encana Release Details<br />
    </h3>
    <p>
        <strong>Encana</strong></p>
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
        BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px"
        CellPadding="4" DataKeyNames="encana cardex ID" DataSourceID="SqlDataSource1">
        <RowStyle BackColor="White" ForeColor="#330099" />
        <Columns>
            <asp:BoundField DataField="part number" HeaderText="part number" SortExpression="part number" />
            <asp:BoundField DataField="G/L Doc  Number" HeaderText="G/L Doc  Number" SortExpression="G/L Doc  Number" />
            <asp:BoundField DataField="Doc  Type" HeaderText="Doc  Type" SortExpression="Doc  Type" />
            <asp:BoundField DataField="Doc  Co" HeaderText="Doc  Co" SortExpression="Doc  Co" />
            <asp:BoundField DataField="Release" HeaderText="Release" SortExpression="Release" />
            <asp:BoundField DataField="location" HeaderText="location" SortExpression="location" />
            <asp:BoundField DataField="Transaction  Date" DataFormatString="{0:d}" HeaderText="Transaction  Date"
                SortExpression="Transaction  Date" />
            <asp:BoundField DataField="Quantity" DataFormatString="{0:n1}" HeaderText="Quantity"
                SortExpression="Quantity">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="G/L  Date" DataFormatString="{0:d}" HeaderText="G/L  Date"
                SortExpression="G/L  Date" />
            <asp:BoundField DataField="Work  Area" HeaderText="Work  Area" SortExpression="Work  Area" />
            <asp:BoundField DataField="Trans  UoM" HeaderText="Trans  UoM" SortExpression="Trans  UoM" />
            <asp:BoundField DataField="Lot/Serial" HeaderText="Lot/Serial" SortExpression="Lot/Serial" />
        </Columns>
        <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
        <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT * FROM [encana cardex] WHERE ([Release] = @Release) ORDER BY [G/L Doc  Number], [Transaction  Date]">
        <SelectParameters>
            <asp:QueryStringParameter Name="Release" QueryStringField="Release" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <strong>TTL<br />
    </strong>
    <asp:GridView ID="GridView2" runat="server" AllowSorting="True" AutoGenerateColumns="False"
        BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px"
        CellPadding="4" DataKeyNames="BOL" DataSourceID="SqlDataSource2">
        <RowStyle BackColor="White" ForeColor="#330099" />
        <Columns>
            <asp:BoundField DataField="Release" HeaderText="Release" SortExpression="Release" />
            <asp:BoundField DataField="BOL" HeaderText="BOL" ReadOnly="True" SortExpression="BOL" />
            <asp:BoundField DataField="Product" HeaderText="Product" SortExpression="Product" />
            <asp:BoundField DataField="LNFT TTL" DataFormatString="{0:n1}" HeaderText="LNFT TTL"
                ReadOnly="True" SortExpression="LNFT TTL">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
        </Columns>
        <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
        <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT * FROM [encana release TTL detail] WHERE ([Release] = @Release) ORDER BY [BOL], [Product]">
        <SelectParameters>
            <asp:QueryStringParameter Name="Release" QueryStringField="Release" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

