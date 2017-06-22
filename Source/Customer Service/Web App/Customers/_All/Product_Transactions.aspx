<%@ Page Title="" Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_Product_Transactions" 
    CodeBehind="Product_Transactions.aspx.cs" CodeFile="Product_Transactions.aspx.cs"%>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Product Transactions</h3>
    <br />
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT DISTINCT [Profile] FROM [sysRecvClientPG1List] WHERE (([Product Group 1] = @Product_Group_1) AND ([Receiving Client Ref] = @Receiving_Client_Ref))">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="Product_Group_1" PropertyName="SelectedValue"
                Type="String" />
            <asp:SessionParameter Name="Receiving_Client_Ref" SessionField="context_clientID"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT distinct [Product Group 1] AS Product_Group_1 FROM [sysRecvClientPG1List] WHERE ([Receiving Client Ref] = @Receiving_Client_Ref) ORDER BY [Product Group 1]">
        <SelectParameters>
            <asp:SessionParameter Name="Receiving_Client_Ref" SessionField="context_clientID"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <table>
        <tr>
            <td style="width: 189px">
                Filter for Product Number</td>
            <td style="width: 100px">
    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
        DataTextField="Product_Group_1" DataValueField="Product_Group_1">
    </asp:DropDownList></td>
        </tr>
        <tr>
            <td style="width: 189px">
                Filter for Profile</td>
            <td style="width: 100px">
                <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource3"
                    DataTextField="Profile" DataValueField="Profile">
                </asp:DropDownList></td>
        </tr>
    </table>
    <br />
    <asp:Button ID="ExportToExcelButton" runat="server" OnClick="ExportToExcelButton_Click"
        Text="Export to Excel" />
    <br />
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
        BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px" 
        CellPadding="4" DataSourceID="SqlDataSource2">
        <Columns>
            <asp:BoundField DataField="Terminal" HeaderText="Terminal" 
                SortExpression="Terminal" />
            <asp:BoundField DataField="Date" DataFormatString="{0:d}" HeaderText="Date" 
                SortExpression="Date" />
            <asp:BoundField DataField="Receiver" HeaderText="In-Receiver" 
                SortExpression="Receiver" />
            <asp:BoundField DataField="PDF of Load" HeaderText="Out-Load" SortExpression="BOL" HtmlEncode="False" />
            <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type" />
            <asp:BoundField DataField="release" HeaderText="Release" 
                SortExpression="release" />
            <asp:BoundField DataField="Carrier" HeaderText="Carrier-Destination" 
                SortExpression="Carrier" />
            <asp:BoundField DataField="Profile" HeaderText="Profile" 
                SortExpression="Profile" />
            <asp:BoundField DataField="Product_Group_1" HeaderText="Product" 
                SortExpression="Product_Group_1" />
            <asp:BoundField DataField="Description" HeaderText="Description" 
                SortExpression="Description" />
            <asp:BoundField DataField="Product_Group_2" HeaderText="Mill" 
                SortExpression="Product_Group_2" />
            <asp:BoundField DataField="Product_Group_3" HeaderText="Inspection" 
                SortExpression="Product_Group_3" />
            <asp:BoundField DataField="Item_Ct" HeaderText="Ct" SortExpression="Item_Ct" />
            <asp:BoundField DataField="Pounds" HeaderText="Pounds" 
                SortExpression="Pounds" />
            <asp:BoundField DataField="Linear_Ft" HeaderText="LNFT" 
                SortExpression="Linear_Ft" />
            <asp:BoundField DataField="Notes" HeaderText="Notes" SortExpression="Notes" />
        </Columns>
        <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" 
            Wrap="False" />
        <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
        <RowStyle BackColor="White" ForeColor="#330099" Wrap="False" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
        <SortedAscendingCellStyle BackColor="#FEFCEB" />
        <SortedAscendingHeaderStyle BackColor="#AF0101" />
        <SortedDescendingCellStyle BackColor="#F6F0C0" />
        <SortedDescendingHeaderStyle BackColor="#7E0000" />
    </asp:GridView>
    <br />

    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        
        SelectCommand="SELECT Terminal, Date, Receiver, BOL, Profile, Type, Carrier, Description, [Product Group 1] AS Product_Group_1, [Product Group 2] AS Product_Group_2, [Product Group 3] AS Product_Group_3, [Item Ct] AS Item_Ct, Pounds, [Linear Ft] AS Linear_Ft, [PDF of Load], release, Notes FROM [COPS Transactions Log by carrier for web] WHERE ([Client ref] = @Client_ref) AND ([Product Group 1] = @Product_Group_1) AND (Profile = @Profile_sel) ORDER BY Terminal, Date, Receiver">
        <SelectParameters>
            <asp:SessionParameter Name="Client_ref" SessionField="context_clientID" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList1" Name="Product_Group_1" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="DropDownList2" Name="Profile_sel" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

