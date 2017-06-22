<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_InventoryAtBudwaySummary" 
    Title="Inventory Summary" CodeBehind="InventoryAtBudwaySummary.aspx.cs" CodeFile="InventoryAtBudwaySummary.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
    Inventory at Terminal (Summary)<br />
    </h3>
    <p>
        <asp:Button ID="ExportToExcelButton" runat="server" OnClick="ExportToExcelButton_Click"
            Text="Export to Excel" />&nbsp;</p>
    <p>
    <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
        BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataSourceID="SqlDataSource1" AllowSorting="True">
        <RowStyle BackColor="White" ForeColor="#330099" />
        <Columns>
            <asp:BoundField DataField="Terminal" HeaderText="Terminal" SortExpression="Terminal" />
            <asp:BoundField DataField="Product_Profile_Description" HeaderText="Profile"
                SortExpression="Product_Profile_Description" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Ext" HeaderText="Description" SortExpression="Ext" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Product_Group_1" HeaderText="Group 1" SortExpression="Product_Group_1" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Product_Group_2" HeaderText="Group 2" SortExpression="Product_Group_2" />
            <asp:BoundField DataField="Product_Group_3" HeaderText="Group 3" SortExpression="Product_Group_3" />
            <asp:BoundField DataField="Weight" HeaderText="Weight" SortExpression="Weight" DataFormatString="{0:n0}" HtmlEncode="False" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Net_Weight" DataFormatString="{0:n0}" HeaderText="Net Weight"
                HtmlEncode="False" SortExpression="Net_Weight">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Linear Ft" DataFormatString="{0:f1}" HeaderText="Footage"
                SortExpression="Linear Ft">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Unit Ct" HeaderText="Unit Ct" SortExpression="Unit Ct">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Pcs" HeaderText="Pcs" SortExpression="Pcs" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
        </Columns>
        <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
        <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT Terminal, [Product Profile Description] AS Product_Profile_Description, [Product Group 1] AS Product_Group_1, Ext, [Product Group 2] AS Product_Group_2, [Product Group 3] AS Product_Group_3, Weight, Pcs, [Net Weight] AS Net_Weight, [Linear Ft], [Unit Ct] FROM COPSfontanInventorySummary WHERE ([Parent ref] = @Parent_ref2) ORDER BY Terminal, Product_Profile_Description, Product_Group_1">
        <SelectParameters>
            <asp:SessionParameter Name="Parent_ref2" SessionField="CONTEXT_CLIENTID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    </p>
</asp:Content>

