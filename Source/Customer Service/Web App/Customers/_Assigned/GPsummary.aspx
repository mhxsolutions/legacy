<%@ Page Title="" Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__Assigned_GPsummary" Codebehind="GPsummary.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        GP Summary</h3>
    <p>
        (7 days)</p>
    <p>
        <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="Export" />
    </p>
    <p>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px" 
            CellPadding="4" DataSourceID="SqlDataSource1">
            <Columns>
                <asp:BoundField DataField="Date" DataFormatString="{0:d}" HeaderText="Date" 
                    SortExpression="Date" />
                <asp:BoundField DataField="WC Type" HeaderText="WC Type" 
                    SortExpression="WC Type" />
                <asp:BoundField DataField="Count" HeaderText="Count" SortExpression="Count">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Wait Avg" HeaderText="Wait Avg" 
                    SortExpression="Wait Avg">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Load Avg" HeaderText="Load Avg" 
                    SortExpression="Load Avg">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Post Load Avg" HeaderText="Post Load Avg" 
                    SortExpression="Post Load Avg">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Total Avg" HeaderText="Total Avg" 
                    SortExpression="Total Avg">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
            <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
            <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
            <RowStyle BackColor="White" ForeColor="#330099" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
            <SortedAscendingCellStyle BackColor="#FEFCEB" />
            <SortedAscendingHeaderStyle BackColor="#AF0101" />
            <SortedDescendingCellStyle BackColor="#F6F0C0" />
            <SortedDescendingHeaderStyle BackColor="#7E0000" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            SelectCommand="SELECT * FROM [willcall time analysis for phone] ORDER BY [Date] DESC">
        </asp:SqlDataSource>
    </p>
</asp:Content>

