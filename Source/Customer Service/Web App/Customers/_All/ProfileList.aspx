<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_ProfileList" 
    Title="Profile List" CodeBehind="ProfileList.aspx.cs" CodeFile="ProfileList.aspx.cs"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Profile List wih Authorized Viewers</h3>
    <br />
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
        BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px"
        CellPadding="4" DataSourceID="SqlDataSource1">
        <RowStyle BackColor="White" ForeColor="#330099" />
        <Columns>
            <asp:BoundField DataField="Profile" HeaderText="Profile" SortExpression="Profile" />
            <asp:BoundField DataField="Authorized_Viewer" HeaderText="Authorized Viewer" ReadOnly="True"
                SortExpression="Authorized_Viewer" />
        </Columns>
        <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
        <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Profile], [Authorized Viewer] AS Authorized_Viewer FROM [ProfileINFO] WHERE ([Receiving Client Ref] = @Receiving_Client_Ref) ORDER BY [Profile]">
        <SelectParameters>
            <asp:SessionParameter Name="Receiving_Client_Ref" SessionField="context_clientid"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    Authorized Viewers can view your inventory with In-Transit and On Site Consigned
    Inventory reports.&nbsp;
</asp:Content>

