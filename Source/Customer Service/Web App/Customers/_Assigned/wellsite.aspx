<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__Assigned_wellsite" Title="Wellsite Report" Codebehind="wellsite.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Deliveries by Wellsite<br />
    </h3>
    Filter Product:
    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
        DataTextField="Product_Group_1" DataValueField="Product_Group_1">
    </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT DISTINCT [Extended Description] AS Product_Group_1 FROM [COPS summary of delivered by delivery address] WHERE ([Shipping Client Ref] = @Shipping_Client_Ref) ORDER BY [Extended Description]">
        <SelectParameters>
            <asp:SessionParameter Name="Shipping_Client_Ref" SessionField="context_clientid"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    &nbsp;<asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
        CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None">
        <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
        <Columns>
            <asp:BoundField DataField="column1" HeaderText="Well" SortExpression="column1" />
            <asp:BoundField DataField="Product_Group_1" HeaderText="Product" SortExpression="Product_Group_1" />
            <asp:BoundField DataField="Extended_Description" HeaderText="Description" SortExpression="Extended_Description" />
            <asp:BoundField DataField="Product_Group_3" HeaderText="Inspection" SortExpression="Product_Group_3" />
            <asp:BoundField DataField="Last Shipment" DataFormatString="{0:d}" HeaderText="Last Shipment"
                SortExpression="Last Shipment" />
            <asp:BoundField DataField="Ct" HeaderText="Ct" SortExpression="Ct" />
            <asp:BoundField DataField="Pounds" DataFormatString="{0:n1}" HeaderText="Pounds"
                SortExpression="Pounds" />
            <asp:BoundField DataField="LnFt" DataFormatString="{0:n1}" HeaderText="LnFt" SortExpression="LnFt" />
        </Columns>
        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Name-city] AS column1, [Product Group 1] AS Product_Group_1, [Product Group 2] AS Product_Group_2, [Product Group 3] AS Product_Group_3, [Extended Description] AS Extended_Description, Ct, LnFt, Pounds, [Last Shipment] FROM [COPS summary of delivered by delivery address] WHERE ([Shipping Client Ref] = @Shipping_Client_Ref) AND ([Extended Description] = @Product_Group_1)">
        <SelectParameters>
            <asp:SessionParameter Name="Shipping_Client_Ref" SessionField="context_clientID"
                Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList1" Name="Product_Group_1" PropertyName="SelectedValue"
                Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

