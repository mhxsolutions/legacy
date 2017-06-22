<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__Assigned_Product_Transactions" 
    Title="Product Transactions" CodeBehind="Product_Transactions_Lookup.aspx.cs" CodeFile="Product_Transactions_Lookup.aspx.cs"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Product Transactions</h3>
    <asp:Button ID="ExportToExcelButton" runat="server" OnClick="ExportToExcelButton_Click"
        Text="Export to Excel" /><br />
    &nbsp;<br />
    &nbsp;<asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
        BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px"
        CellPadding="4" DataSourceID="SqlDataSource2">
        <RowStyle BackColor="White" ForeColor="#330099" Wrap="False" />
        <Columns>
            <asp:BoundField DataField="Terminal" HeaderText="Terminal" SortExpression="Terminal" />
            <asp:BoundField DataField="Date" DataFormatString="{0:d}" HeaderText="Date" SortExpression="Date" />
            <asp:BoundField DataField="Profile" HeaderText="Profile" SortExpression="Profile" />
            <asp:BoundField DataField="Receiver" HeaderText="In-Receiver" SortExpression="Receiver" />
            <asp:BoundField DataField="PDF of Load" HeaderText="Out-Load" HtmlEncode="False"
                SortExpression="BOL">
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:HyperLinkField DataNavigateUrlFields="BOL" DataNavigateUrlFormatString="tally_detail.aspx?load_ref={0}"
                HeaderText="Tally" SortExpression="BOL" DataTextField="BOL">
                <ItemStyle Wrap="False" />
            </asp:HyperLinkField>
            <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type" />
            <asp:BoundField DataField="release" HeaderText="Release" SortExpression="release" />
            <asp:BoundField DataField="Carrier" HeaderText="Source" SortExpression="Carrier">
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description">
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Product_Group_1" HeaderText="Product" SortExpression="Product_Group_1" />
            <asp:BoundField DataField="Product_Group_2" HeaderText="Mill" SortExpression="Product_Group_2" />
            <asp:BoundField DataField="Product_Group_3" HeaderText="Inspection" SortExpression="Product_Group_3" />
            <asp:BoundField DataField="Item_Ct" DataFormatString="{0:n0}" HeaderText="Ct"
                SortExpression="Item_Ct">
                <ItemStyle HorizontalAlign="Right" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Pounds" DataFormatString="{0:n1}" HeaderText="Pounds"
                SortExpression="Pounds">
                <ItemStyle HorizontalAlign="Right" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Linear_Ft" DataFormatString="{0:n1}" HeaderText="Linear Ft"
                SortExpression="Linear_Ft">
                <ItemStyle HorizontalAlign="Right" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Notes" HeaderText="Notes" SortExpression="Notes" />
        </Columns>
        <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
        <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" Wrap="False" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        
        
        SelectCommand="SELECT Terminal, Date, Profile, Type, Carrier, Description, [Product Group 1] AS Product_Group_1, [Product Group 2] AS Product_Group_2, [Product Group 3] AS Product_Group_3, [Item Ct] AS Item_Ct, Pounds, [Linear Ft] AS Linear_Ft, Receiver, BOL, [PDF of Load], release, Notes FROM [COPS Transactions Log by carrier for web] WHERE ([Client ref] = @Client_ref) AND ([Product Group 1] = @PG1) AND (Profile = @Profile) ORDER BY Terminal, Date">
        <SelectParameters>
            <asp:SessionParameter Name="Client_ref" SessionField="context_clientID" Type="Int32" />
            <asp:QueryStringParameter Name="PG1" QueryStringField="Product_Group_1" />
            <asp:QueryStringParameter Name="Profile" QueryStringField="Profile" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

