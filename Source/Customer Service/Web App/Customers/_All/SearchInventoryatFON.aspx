<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_SearchInventoryatFON" 
    Title="BudwayDirect | Search Fontana Inventory" CodeBehind="SearchInventoryatFON.aspx.cs" CodeFile="SearchInventoryatFON.aspx.cs"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>
        Inventory at Terminal</h2>
    <p>
        Search Item ID:
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <asp:Button ID="Button1" runat="server" PostBackUrl="~/Customers/_All/SearchInventoryatFON.aspx"
            Text="Search" /></p>
    <p>
        <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
            CellPadding="4" DataSourceID="SqlDataSource1" BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px">
            <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
            <RowStyle BackColor="White" Font-Size="Small" ForeColor="#330099" />
            <Columns>
                <asp:BoundField DataField="Terminal" HeaderText="Terminal" ReadOnly="True" SortExpression="Terminal" />
                <asp:BoundField DataField="Date Received" DataFormatString="{0:d}" HeaderText="Date Received"
                    HtmlEncode="False" SortExpression="Date Received" />
                <asp:BoundField DataField="Product Profile Description" HeaderText="Profile Description"
                    SortExpression="Product Profile Description" />
                <asp:BoundField DataField="Group Label 1" HeaderText="Label 1" SortExpression="Group Label 1" >
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="Product Group 1" HeaderText="Product 1" SortExpression="Product Group 1" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Group Label 2" HeaderText="Label 2" SortExpression="Group Label 2" >
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="Product Group 2" HeaderText="Product 2" SortExpression="Product Group 2" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Group Label 3" HeaderText="Label 3" SortExpression="Group Label 3" >
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="Product Group 3" HeaderText="Product 3" SortExpression="Product Group 3" >
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Item_ID" HeaderText="Item_ID" SortExpression="Item_ID" />
                <asp:BoundField DataField="Weight" HeaderText="Weight" SortExpression="Weight" >
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="Weight Label" HeaderText="Unit" SortExpression="Weight Label" />
                <asp:BoundField DataField="Package Label" HeaderText="Package" SortExpression="Package Label" >
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="Count In Package" HeaderText="Count In Package" SortExpression="Count In Package" >
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
            <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT * FROM [COPSfontanaInventory] WHERE (([Parent ref] = @Parent_ref) AND ([Item_ID] LIKE '%' + @Item_ID + '%'))">
            <SelectParameters>
                <asp:SessionParameter Name="Parent_ref" SessionField="context_clientID" Type="Int32" />
                <asp:ControlParameter ControlID="TextBox1" DefaultValue="%" Name="Item_ID" PropertyName="Text"
                    Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>

