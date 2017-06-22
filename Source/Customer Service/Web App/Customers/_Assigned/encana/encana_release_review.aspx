<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_encana_release_review" Title="Release Review" Codebehind="encana_release_review.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Encana Release Review</h3>
    Part Number:
    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2"
        DataTextField="part_number" DataValueField="part_number">
    </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT DISTINCT [part number] AS part_number FROM [encana cardex] ORDER BY [part number]">
    </asp:SqlDataSource>
    <br />
    <br />
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
        BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px"
        CellPadding="4" DataSourceID="SqlDataSource1">
        <RowStyle BackColor="White" ForeColor="#330099" />
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="release" DataNavigateUrlFormatString="encana_release_details.aspx?Release={0}"
                DataTextField="Release" HeaderText="Release" SortExpression="Release" />
            <asp:BoundField DataField="part number" HeaderText="part number" SortExpression="part number" />
            <asp:BoundField DataField="LNFT encana" DataFormatString="{0:n1}" HeaderText="LNFT encana"
                SortExpression="LNFT encana" />
            <asp:BoundField DataField="LNFT TTL" DataFormatString="{0:n1}" HeaderText="LNFT TTL"
                SortExpression="LNFT TTL" />
            <asp:BoundField DataField="Delta" DataFormatString="{0:n1}" HeaderText="Delta" ReadOnly="True"
                SortExpression="Delta" />
        </Columns>
        <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
        <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT Release, [part number], [LNFT encana], [LNFT TTL], Delta FROM [encana release cp ttl] WHERE ([part number] = @PN) ORDER BY Release">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="PN" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

