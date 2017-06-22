<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers_Maas_MaasDwellDetail" Title="Dwell Detail" Codebehind="MaasDwellDetail.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Dwell Detail<br />
    </h3>
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
        CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
        <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
        <Columns>
            <asp:BoundField DataField="Date" DataFormatString="{0:d}" HeaderText="Date" ReadOnly="True"
                SortExpression="Date" />
            <asp:BoundField DataField="Destination" HeaderText="Destination" ReadOnly="True"
                SortExpression="Destination" />
            <asp:BoundField DataField="Wait" HeaderText="Wait" ReadOnly="True" SortExpression="Wait" />
        </Columns>
        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Date], [Destination], [Wait] FROM [Dwell detail for load destination] WHERE ([Fleet ref] = @Fleet_ref) ORDER BY [Date] DESC, [Destination]">
        <SelectParameters>
            <asp:Parameter DefaultValue="12" Name="Fleet_ref" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

