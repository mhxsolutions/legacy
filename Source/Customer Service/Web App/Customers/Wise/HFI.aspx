<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers_Wise_HFI" Title="Hold For Inspection" Codebehind="HFI.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>
        Hold For Inspection (HFI)</h2>
    HFI coils held by MCC and Wise<br />
    <br />
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
        BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px"
        CellPadding="4" DataKeyNames="Client,Location" DataSourceID="SqlDataSource1">
        <RowStyle BackColor="White" ForeColor="#330099" />
        <Columns>
            <asp:BoundField DataField="Date Received" DataFormatString="{0:d}" HeaderText="Date Received"
                HtmlEncode="False" SortExpression="Date Received" />
            <asp:BoundField DataField="Client" HeaderText="Client" ReadOnly="True" SortExpression="Client" />
            <asp:BoundField DataField="Location" HeaderText="Location" ReadOnly="True" SortExpression="Location" />
            <asp:BoundField DataField="Product Group 1" HeaderText="Product Group 1" SortExpression="Product Group 1" />
            <asp:BoundField DataField="Product Group 2" HeaderText="Product Group 2" SortExpression="Product Group 2" />
            <asp:BoundField DataField="Item ID" HeaderText="Item ID" SortExpression="Item ID" />
            <asp:BoundField DataField="Weight" HeaderText="Weight" SortExpression="Weight" />
            <asp:BoundField DataField="Product Profile Description" HeaderText="Product Profile Description"
                SortExpression="Product Profile Description" />
        </Columns>
        <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
        <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT * FROM [Wise HFI inventory viewer] ORDER BY [Date Received]">
    </asp:SqlDataSource>
</asp:Content>

