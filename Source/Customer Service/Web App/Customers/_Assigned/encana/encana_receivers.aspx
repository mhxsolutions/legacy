<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__Assigned_encana_encana_receivers" Title="Encana Receivers" Codebehind="encana_receivers.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Encana Receivers<br />
    </h3>
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
        BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px"
        CellPadding="4" DataKeyNames="Receiver_ID" DataSourceID="SqlDataSource1">
        <RowStyle BackColor="White" ForeColor="#330099" />
        <Columns>
            <asp:BoundField DataField="Receiver_ID" HeaderText="Receiver" InsertVisible="False"
                ReadOnly="True" SortExpression="Receiver_ID" />
            <asp:BoundField DataField="Receiver_Type" HeaderText="Type" SortExpression="Receiver_Type" />
            <asp:BoundField DataField="Date_Received" DataFormatString="{0:d}" HeaderText="Date"
                SortExpression="Date_Received" />
            <asp:BoundField DataField="Client_PO" HeaderText="PO" SortExpression="Client_PO" />
        </Columns>
        <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
        <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Receiver ID] AS Receiver_ID, [Receiver Type] AS Receiver_Type, [Date Received] AS Date_Received, [Client PO] AS Client_PO FROM [Receivers S] WHERE ([Receiving Client Ref] = @Receiving_Client_Ref) ORDER BY [Receiver ID]">
        <SelectParameters>
            <asp:SessionParameter Name="Receiving_Client_Ref" SessionField="context_clientID"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

