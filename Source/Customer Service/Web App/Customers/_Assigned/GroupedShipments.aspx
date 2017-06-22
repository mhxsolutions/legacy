<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__Assigned_GroupedShipments" Title="Grouped Shipments" Codebehind="GroupedShipments.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
    Grouped Shipments<br />
    </h3>
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
        CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
        <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
        <Columns>
            <asp:BoundField DataField="Shipment Date" DataFormatString="{0:d}" HeaderText="Shipment Date"
                SortExpression="Shipment Date" />
            <asp:BoundField DataField="Fleet" HeaderText="Fleet" SortExpression="Fleet" />
            <asp:BoundField DataField="Shipper Number" HeaderText="Shipper Number" SortExpression="Shipper Number" />
            <asp:BoundField DataField="Name-city" HeaderText="Destination" SortExpression="Name-city" />
            <asp:BoundField DataField="Extended Description" HeaderText="Extended Description"
                SortExpression="Extended Description" />
            <asp:BoundField DataField="LnFt" DataFormatString="{0:f1}" HeaderText="LnFt" SortExpression="LnFt">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Item Count" HeaderText="Item Count" SortExpression="Item Count">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
        </Columns>
        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT * FROM [TTL shipments by shipper number] WHERE ([Shipping Client Ref] = @Shipping_Client_Ref) ORDER BY [Shipment Date] DESC, [Shipper Number], [Extended Description]">
        <SelectParameters>
            <asp:SessionParameter Name="Shipping_Client_Ref" SessionField="context_clientID"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

