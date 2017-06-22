<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_HarborDetailHistory" 
    Title="BudwayDirect - Harbor Detail History" CodeBehind="HarborDetailHistory.aspx.cs" CodeFile="HarborDetailHistory.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>
        All Harbor History</h2>
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
        BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px"
        CellPadding="4" DataSourceID="SqlDataSource1" AllowPaging="True" PageSize="100" Width="740px">
        <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
        <RowStyle BackColor="White" ForeColor="#330099" Font-Size="Small" />
        <Columns>
            <asp:BoundField DataField="Item_ID" HeaderText="Item_ID" SortExpression="Item_ID" />
            <asp:BoundField DataField="Vessel" HeaderText="Vessel" SortExpression="Vessel" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Destination" HeaderText="Destination" ReadOnly="True"
                SortExpression="Destination" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Client Ref" HeaderText="Client #" SortExpression="Client Ref" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Detail 1" HeaderText="Detail 1" SortExpression="Detail 1" />
            <asp:BoundField DataField="Detail 2" HeaderText="Detail 2" SortExpression="Detail 2" />
            <asp:BoundField DataField="Detail 3" HeaderText="Detail 3" SortExpression="Detail 3" />
            <asp:BoundField DataField="DR Ref" HeaderText="DR Ref" SortExpression="DR Ref" />
            <asp:BoundField DataField="Notes" HeaderText="Notes" SortExpression="Notes" />
            <asp:BoundField DataField="Load Date" DataFormatString="{0:d}" HeaderText="Load Date"
                HtmlEncode="False" SortExpression="Load Date" />
            <asp:BoundField DataField="POD" HeaderText="POD" SortExpression="POD" HtmlEncode="False" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>
        </Columns>
        <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT * FROM [COPSHarborInventoryHistory] WHERE ([ShipperRef] = @ShipperRef) ORDER BY [Item_ID]">
        <SelectParameters>
            <asp:SessionParameter Name="ShipperRef" SessionField="CONTEXT_CLIENTID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

