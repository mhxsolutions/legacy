<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__Maas_Dwell" Title="Dwell" Codebehind="MaasDwell.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Dwell Average By Week<br />
    </h3>
    Year:<asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
        DataTextField="Year" DataValueField="Year">
    </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT DISTINCT [Year] FROM [Dwell Wk Avg by Dest] WHERE ([Fleet] = @Fleet) ORDER BY [Year] DESC">
        <SelectParameters>
            <asp:Parameter DefaultValue="Maas" Name="Fleet" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
        CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None">
        <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
        <Columns>
            <asp:BoundField DataField="Week" HeaderText="Week" SortExpression="Week" />
            <asp:BoundField DataField="Client" HeaderText="Destination" SortExpression="Client" />
            <asp:BoundField DataField="Average Dwell" DataFormatString="{0:n1}" HeaderText="Average Dwell"
                SortExpression="Average Dwell" />
            <asp:BoundField DataField="Count" HeaderText="Count" SortExpression="Count" />
        </Columns>
        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT * FROM [Dwell Wk Avg by Dest] WHERE (([Year] = @Year) AND ([Fleet] = @Fleet)) ORDER BY [Week] DESC, [Client]">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="Year" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:Parameter DefaultValue="Maas" Name="Fleet" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

