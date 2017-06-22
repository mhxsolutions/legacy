<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_SearchHarborInv" Title="BudwayDirect | Search Harbor Inventory" CodeBehind="SearchHarborInv.aspx.cs" CodeFile="SearchHarborInv.aspx.cs"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>
        Harbor Inventory Detail History</h2>
    <p>
        Search Item ID:
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <asp:Button ID="Button1" runat="server" PostBackUrl="~/Customers/_All/SearchHarborInv.aspx"
            Text="Search" /></p>
    <p>
        <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
            BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px"
            CellPadding="4" DataSourceID="SqlDataSource1" Width="719px">
            <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
            <RowStyle BackColor="White" ForeColor="#330099" />
            <Columns>
                <asp:BoundField DataField="Item_ID" HeaderText="Item_ID" SortExpression="Item_ID" />
                <asp:BoundField DataField="Vessel" HeaderText="Vessel" SortExpression="Vessel" />
                <asp:BoundField DataField="Destination" HeaderText="Destination" ReadOnly="True"
                    SortExpression="Destination" />
                <asp:BoundField DataField="Client Ref" HeaderText="Client Ref" SortExpression="Client Ref" />
                <asp:BoundField DataField="Detail 1" HeaderText="Detail 1" SortExpression="Detail 1" />
                <asp:BoundField DataField="Detail 2" HeaderText="Detail 2" SortExpression="Detail 2" />
                <asp:BoundField DataField="Detail 3" HeaderText="Detail 3" SortExpression="Detail 3" />
                <asp:BoundField DataField="Notes" HeaderText="Notes" SortExpression="Notes" />
                <asp:BoundField DataField="DR Ref" HeaderText="DR Ref" SortExpression="DR Ref" />
                <asp:BoundField DataField="Load Date" DataFormatString="{0:d}" HeaderText="Load Date"
                    HtmlEncode="False" SortExpression="Load Date" />
                <asp:BoundField DataField="POD" HeaderText="POD" HtmlEncode="False" SortExpression="POD" />
            </Columns>
            <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT Shipper, Vessel, Destination, [Client Ref], Item_ID, [Detail 1], [Detail 2], [Detail 3], [DR Ref], Notes, [Load Date], POD, ShipperRef, ReceiverRef, DestinationRef FROM COPSHarborInventoryHistory WHERE (ShipperRef = @ShipperRef) AND (Item_ID LIKE N'%' + @Item_ID + N'%') OR (Item_ID LIKE N'%' + @Item_ID + N'%') AND (ReceiverRef = @ReceiverRef) OR (Item_ID LIKE N'%' + @Item_ID + N'%') AND (DestinationRef = @DestinationRef)">
            <SelectParameters>
                <asp:SessionParameter Name="ShipperRef" SessionField="context_clientID" Type="Int32" />
                <asp:ControlParameter ControlID="TextBox1" DefaultValue="" Name="Item_ID" PropertyName="Text" />
                <asp:SessionParameter Name="ReceiverRef" SessionField="context_clientID" Type="Int32" />
                <asp:SessionParameter Name="DestinationRef" SessionField="context_clientID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>

