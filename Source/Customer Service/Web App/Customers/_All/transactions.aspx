<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_transactions" Title="Transaction Log" CodeBehind="transactions.aspx.cs" CodeFile="transactions.aspx.cs"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Transaction Log<br />
    </h3>
    (reporting delayed by 20 minutes)<br />
    Profile:
    <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource3"
        DataTextField="Profile" DataValueField="Profile">
    </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT DISTINCT Profile, [Client ref] FROM [Cache COPS Transaction Log view with sort] WHERE ([Client ref] = @CID) ORDER BY Profile">
        <SelectParameters>
            <asp:SessionParameter Name="CID" SessionField="context_clientid" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    Item:
    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
        DataTextField="sort" DataValueField="sort">
    </asp:DropDownList><br />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT DISTINCT sort FROM [Cache COPS Transaction Log view with sort] WHERE ([Client ref] = @Client_ref) AND (Profile = @Profile_1) ORDER BY sort">
        <SelectParameters>
            <asp:SessionParameter Name="Client_ref" SessionField="context_clientid" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList2" Name="Profile_1" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
        BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px"
        CellPadding="4" DataSourceID="SqlDataSource2" OnRowDataBound="GridView1_RowDataBound">
        <RowStyle BackColor="White" ForeColor="#330099" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" />
        <Columns>
            <asp:BoundField DataField="Terminal" HeaderText="Terminal" ReadOnly="True" SortExpression="Terminal" />
            <asp:BoundField DataField="Date" DataFormatString="{0:d}" HeaderText="Date" ReadOnly="True"
                SortExpression="Date" />
            <asp:BoundField DataField="Group_1" HeaderText="Group 1" ReadOnly="True" SortExpression="Group_1" />
            <asp:BoundField DataField="Group_2" HeaderText="Group 2" ReadOnly="True" SortExpression="Group_2" />
            <asp:BoundField DataField="Group_3" HeaderText="Group 3" ReadOnly="True" SortExpression="Group_3" />
            <asp:BoundField DataField="Item_Ct_In" HeaderText="Count In" SortExpression="Item_Ct_In">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Item_Ct_Out" HeaderText="Count Out" SortExpression="Item_Ct_Out">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Count_Total" HeaderText="Ct Balance" SortExpression="Count_Total">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Linear Ft In" HeaderText="Footage In" SortExpression="Linear Ft In">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Linear Ft Out" HeaderText="Footage Out" SortExpression="Linear Ft Out">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Feet_Total" HeaderText="Ft Balance" SortExpression="Feet_Total" DataFormatString="{0:f1}" HtmlEncode="False">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
        </Columns>
        <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
        <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" BorderColor="White" />
        <AlternatingRowStyle BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT Terminal, Date, [Group 1] AS Group_1, [Group 2] AS Group_2, [Group 3] AS Group_3, [Item Ct In] AS Item_Ct_In, [Item Ct Out] AS Item_Ct_Out, Profile, [Linear Ft In], [Linear Ft Out], 0 AS Count_Total, 0 AS Feet_Total, sort FROM [Cache COPS Transaction Log view with sort] WHERE ([Client ref] = @Client_ref) AND (Profile = @Profile_1) AND (sort = @sort) ORDER BY Date, Terminal, sort">
        <SelectParameters>
            <asp:SessionParameter Name="Client_ref" SessionField="context_clientid" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList2" Name="Profile_1" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownList1" Name="sort" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
