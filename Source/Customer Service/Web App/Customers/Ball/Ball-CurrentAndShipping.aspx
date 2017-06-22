<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" 
    Inherits="Customers_Ball_Ball_CurrentAndShipping" Title="BudwayDirect | Custom Reports | Ball - Current And Shipping" Codebehind="Ball-CurrentAndShipping.aspx.cs" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h2>Ball - Current and Shipping</h2>
    
    <asp:GridView ID="_GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="_SqlDataSource1" AllowSorting="True" BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px">
        <RowStyle BackColor="White" ForeColor="#330099" />
        <Columns>
            <asp:BoundField DataField="Account" HeaderText="Account" SortExpression="Account" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Profile" HeaderText="Profile" SortExpression="Profile" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Size" HeaderText="Size" SortExpression="Size" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Product Group 2" HeaderText="Product Group 2" SortExpression="Product Group 2" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Item ID" HeaderText="Item ID" SortExpression="Item ID" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Weight" HeaderText="Weight" SortExpression="Weight" >
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="BOL" HeaderText="BOL" SortExpression="BOL" >
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:CheckBoxField DataField="Arrived" HeaderText="Arrived" SortExpression="Arrived" >
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
            </asp:CheckBoxField>
        </Columns>
        <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
        <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
    </asp:GridView>
    
    <asp:SqlDataSource ID="_SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT * FROM [Ball Current and Shipping]">
    </asp:SqlDataSource>
    
</asp:Content>

