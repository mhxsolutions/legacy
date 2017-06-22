<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_PlannedReceiverToday" 
    Title="BudwayDirect | Planned Deliveries" CodeBehind="PlannedReceiverToday.aspx.cs" CodeFile="PlannedReceiverToday.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Planned Receiver Shipments</h2>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="PlannedReceiverDataSource" AllowSorting="True" BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px">
        <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
        <RowStyle BackColor="White" Font-Size="Small" ForeColor="#330099" />
        <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
        <Columns>
            <asp:BoundField DataField="Sch Arrive" HeaderText="Sch Arrive"
                HtmlEncode="False" SortExpression="Sch Arrive" />
            <asp:BoundField DataField="Load" HeaderText="Load" SortExpression="Load" />
            <asp:BoundField DataField="Origin" HeaderText="Origin" SortExpression="Origin" />
            <asp:BoundField DataField="Action" HeaderText="Action" SortExpression="Action" />
            <asp:BoundField DataField="Stop" HeaderText="Stop" SortExpression="Stop" />
            <asp:BoundField DataField="Final Destination" HeaderText="Final Destination" SortExpression="Final Destination" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="PlannedReceiverDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT * FROM [COPSLoadPlan] WHERE ([receiver ref] = @Parent_ref) ORDER BY [Sch Arrive]">
        <SelectParameters>
            <asp:SessionParameter Name="Parent_ref" SessionField="CONTEXT_CLIENTID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

