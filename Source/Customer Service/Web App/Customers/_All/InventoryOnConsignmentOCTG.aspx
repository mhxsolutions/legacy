<%@ Page Title="" Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_InventoryOnConsignmentOCTG" 
    CodeBehind="InventoryOnConsignmentOCTG.aspx.cs" CodeFile="InventoryOnConsignmentOCTG.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        OCTG
        Consigned
        Inventory</h3>
    <br />
    Held by other Clients for current User.<br />
    This inventory is not owned by the current User.<br />
    <p>
        <asp:Button ID="ExportToExcelButton" runat="server" OnClick="ExportToExcelButton_Click"
            Text="Export to Excel" />&nbsp;</p>
    <p>
    <br />
    &nbsp;<asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
        BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px"
        CellPadding="4" DataKeyNames="Terminal" DataSourceID="SqlDataSource1">
        <RowStyle BackColor="White" ForeColor="#330099" Wrap="False" />
        <Columns>
            <asp:BoundField DataField="Inventory" HeaderText="Inventory" SortExpression="Inventory" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Terminal" HeaderText="Terminal" ReadOnly="True" SortExpression="Terminal" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Product Profile Description" HeaderText="Profile" SortExpression="Product Profile Description" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Ext" HeaderText="Description" SortExpression="Ext" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:HyperLinkField DataNavigateUrlFields="Product Profile Description,Product Group 1,Parent ref" DataNavigateUrlFormatString="Product_Consigned_Transactions_lookup.aspx?Profile={0}&amp;PG1={1}&amp;Parent_ref={2}"
                DataTextField="Product Group 1" HeaderText="Product" />
            <asp:BoundField DataField="Product Group 2" HeaderText="Mill" SortExpression="Product Group 2" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Product Group 3" HeaderText="Inspection" SortExpression="Product Group 3" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Pcs" HeaderText="Ct" SortExpression="Pcs" >
                <ItemStyle HorizontalAlign="Right" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Weight" DataFormatString="{0:n0}" HeaderText="Pounds"
                SortExpression="Weight" >
                <ItemStyle HorizontalAlign="Right" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Linear Ft" DataFormatString="{0:n1}" HeaderText="Linear Ft"
                SortExpression="Linear Ft" >
                <ItemStyle HorizontalAlign="Right" Wrap="False" />
            </asp:BoundField>
        </Columns>
        <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
        <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT * FROM [COPSfontanaInvSummaryAuthViewer] WHERE ([Auth ref] = @Auth_ref) ORDER BY [Inventory], [Terminal], [Ext]">
        <SelectParameters>
            <asp:SessionParameter Name="Auth_ref" SessionField="context_clientID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

