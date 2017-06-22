<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__Assigned_wellsite_transaction" Title="Transactions by Well Site" Codebehind="wellsite transaction.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Transactions by Well Site (BETA)</h3>
    <br />
    Select Product:
    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
        DataTextField="Product" DataValueField="Product">
    </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT DISTINCT [Product] FROM [TTL well site transactions] WHERE ([Client Ref] = @Client_Ref) ORDER BY [Product]">
        <SelectParameters>
            <asp:SessionParameter Name="Client_Ref" SessionField="context_clientID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" BackColor="White" BorderColor="#CC9966" BorderStyle="None"
        BorderWidth="1px" CellPadding="4" DataSourceID="SqlDataSource2" PageSize="25">
        <RowStyle BackColor="White" ForeColor="#330099" />
        <Columns>
            <asp:BoundField DataField="Transaction Date" DataFormatString="{0:d}" HeaderText="Transaction Date"
                ReadOnly="True" SortExpression="Transaction Date" />
            <asp:BoundField DataField="Well_Site" HeaderText="Well_Site" ReadOnly="True" SortExpression="Well_Site" />
            <asp:BoundField DataField="Description" HeaderText="Description" ReadOnly="True"
                SortExpression="Description" />
            <asp:BoundField DataField="Inspection" HeaderText="Inspection" SortExpression="Inspection" />
            <asp:BoundField DataField="Ct_to_Rig" DataFormatString="{0:n0}" HeaderText="Ct to Rig"
                SortExpression="Ct_to_Rig" />
            <asp:BoundField DataField="LnFt_to_Rig" DataFormatString="{0:n1}" HeaderText="LnFt to Rig"
                SortExpression="LnFt_to_Rig" />
            <asp:BoundField DataField="Ct_Returned" DataFormatString="{0:n0}" HeaderText="Ct Returned"
                SortExpression="Ct_Returned" />
            <asp:BoundField DataField="LnFt_Returned" DataFormatString="{0:n1}" HeaderText="LnFt Returned"
                SortExpression="LnFt_Returned" />
        </Columns>
        <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
        <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Transaction Date], [Well Site] AS Well_Site, Description, Inspection, [Ct to Rig] AS Ct_to_Rig, [LnFt to Rig] AS LnFt_to_Rig, [Ct Returned] AS Ct_Returned, [LnFt Returned] AS LnFt_Returned FROM [TTL well site transactions] WHERE ([Client Ref] = @Client_Ref) AND (Product = @Product ) ORDER BY [Transaction Date] DESC, Well_Site">
        <SelectParameters>
            <asp:SessionParameter Name="Client_Ref" SessionField="context_clientID" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList1" Name="Product" PropertyName="SelectedValue"
                Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
</asp:Content>

