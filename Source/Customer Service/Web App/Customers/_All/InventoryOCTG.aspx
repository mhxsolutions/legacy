<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_InventoryOCTG" Title="OCTG Inventory" 
    CodeBehind="InventoryOCTG.aspx.cs" CodeFile="InventoryOCTG.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        OCTG Inventory at Terminal<br />
    </h3>
    <asp:Button ID="ExportToExcelButton" runat="server" OnClick="ExportToExcelButton_Click"
        Text="Export to Excel" /><br />
    <br />
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" BackColor="White" BorderColor="#CC9966" BorderStyle="None"
        BorderWidth="1px" CellPadding="4" DataKeyNames="Terminal" DataSourceID="SqlDataSource1"
        PageSize="50">
        <RowStyle BackColor="White" ForeColor="#330099" Wrap="False" />
        <Columns>
            <asp:BoundField DataField="Terminal" HeaderText="Terminal" ReadOnly="True" SortExpression="Terminal" />
            <asp:BoundField DataField="Profile" HeaderText="Profile" 
                SortExpression="Profile" />
            <asp:BoundField DataField="Description" HeaderText="Description" 
                SortExpression="Description" />
            <asp:HyperLinkField HeaderText="Product" 
                DataNavigateUrlFields="Product,Profile" 
                DataNavigateUrlFormatString="Product_Transactions_lookup_runningtotals2.aspx?Product_Group_1={0}&amp;profile={1}" 
                DataTextField="Product" SortExpression="Product" />
            <asp:BoundField DataField="Mill" HeaderText="Mill" SortExpression="Mill" />
            <asp:BoundField DataField="Inspection" HeaderText="Inspection" 
                SortExpression="Inspection" />
            <asp:BoundField DataField="Pounds" DataFormatString="{0:n1}" HeaderText="Pounds"
                SortExpression="Pounds" />
            <asp:BoundField DataField="Count" DataFormatString="{0:n0}" HeaderText="Count" 
                SortExpression="Count" />
            <asp:BoundField DataField="Linear Ft" DataFormatString="{0:n1}" HeaderText="Linear Ft"
                SortExpression="Linear Ft" />
        </Columns>
        <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
        <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" Wrap="False" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        
        SelectCommand="SELECT * FROM [COPS OCTG Inventory Summary] WHERE ([Client ref] = @Client_ref) ORDER BY [Terminal], [Profile], [Description]">
        <SelectParameters>
            <asp:SessionParameter Name="Client_ref" SessionField="context_clientID" 
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

