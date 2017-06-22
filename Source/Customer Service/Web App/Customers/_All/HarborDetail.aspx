<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_HarborDetail" 
    Title="BudwayDirect - Harbor Detail" CodeBehind="HarborDetail.aspx.cs" CodeFile="HarborDetail.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>
        Harbor Inventory Detail (on ground)</h2>
    <p>
        Search Item ID:
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <asp:Button ID="Button1" runat="server" PostBackUrl="~/Customers/_All/HarborDetail.aspx"
            Text="Search" /></p>
    <p>
        <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
            CellPadding="4" DataSourceID="SqlDataSource1"
            Width="719px" BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px">
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
                <asp:BoundField DataField="Weight" HeaderText="Gross" SortExpression="Weight" />
                <asp:BoundField DataField="Net" HeaderText="Net" SortExpression="Net" />
                <asp:BoundField DataField="Notes" HeaderText="Notes" SortExpression="Notes" />
            </Columns>
            <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT Client, Vessel, Destination, [Client Ref], Item_ID, [Detail 1], [Detail 2], [Detail 3], Notes, DR, [Parent ref], Weight, DestRef, ReceiverRef, [PMBOLd Net Weight] AS Net FROM COPSharborRemainingDetail WHERE ([Parent ref] = @Parent_ref) AND (Item_ID LIKE N'%' + @ItemID + N'%') ORDER BY Vessel, Destination">
            <SelectParameters>
                <asp:SessionParameter Name="Parent_ref" SessionField="CONTEXT_CLIENTID" Type="Int32" />
                <asp:ControlParameter ControlID="TextBox1" DefaultValue="%" Name="ItemID" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>

