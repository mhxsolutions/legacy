<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_BlueLinx_bltransactions" Title="Trasnactions" Codebehind="bltransactions.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Transactions by Product</h3>
    <br />
    Select a Product Number:
    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
        DataTextField="Item_ID" DataValueField="Item_ID">
    </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT DISTINCT [Item ID] AS Item_ID FROM [Blue Linx Receivers] ORDER BY [Item ID]">
    </asp:SqlDataSource>
    <table>
        <tr>
            <td style="width: 100px">
                <strong>Receiving</strong></td>
            <td style="width: 100px">
                <strong>Shipping</strong></td>
        </tr>
        <tr>
            <td style="width: 100px" valign="top">
                <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                    BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px"
                    CellPadding="4" DataKeyNames="Receiver" DataSourceID="SqlDataSource2">
                    <RowStyle BackColor="White" ForeColor="#330099" />
                    <Columns>
                        <asp:BoundField DataField="Terminal" HeaderText="Terminal" SortExpression="Terminal" />
                        <asp:BoundField DataField="Profile" HeaderText="Profile" SortExpression="Profile" />
                        <asp:BoundField DataField="Date" DataFormatString="{0:d}" HeaderText="Date" SortExpression="Date" />
                        <asp:BoundField DataField="Receiver" HeaderText="Receiver" ReadOnly="True" SortExpression="Receiver" />
                        <asp:BoundField DataField="PO" HeaderText="PO" SortExpression="PO" />
                        <asp:BoundField DataField="Product_Group_1" HeaderText="Product_Group" SortExpression="Product_Group_1" />
                        <asp:BoundField DataField="Item_Ct_In" HeaderText="Item Ct In" SortExpression="Item_Ct_In">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Piece_Ct_In" HeaderText="Piece Ct In" SortExpression="Piece_Ct_In">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Weight_In" DataFormatString="{0:n0}" HeaderText="Weight In"
                            SortExpression="Weight_In">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                    </Columns>
                    <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
                    <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                    SelectCommand="SELECT Terminal, Profile, Date, Receiver, PO, [Product Group 1] AS Product_Group_1, [Item Ct In] AS Item_Ct_In, [Piece Ct In] AS Piece_Ct_In, [Weight In] AS Weight_In FROM [Blue Linx Receivers] WHERE ([Item ID] = @Item_ID) ORDER BY Date, Receiver">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList1" Name="Item_ID" PropertyName="SelectedValue"
                            Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td style="width: 100px" valign="top">
                <asp:GridView ID="GridView2" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                    BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px"
                    CellPadding="4" DataKeyNames="BOL" DataSourceID="SqlDataSource3">
                    <RowStyle BackColor="White" ForeColor="#330099" />
                    <Columns>
                        <asp:BoundField DataField="Terminal" HeaderText="Terminal" SortExpression="Terminal" />
                        <asp:BoundField DataField="Profile" HeaderText="Profile" SortExpression="Profile" />
                        <asp:BoundField DataField="Date" DataFormatString="{0:d}" HeaderText="Date" SortExpression="Date" />
                        <asp:BoundField DataField="BOL" HeaderText="BOL" ReadOnly="True" SortExpression="BOL" />
                        <asp:BoundField DataField="Release" HeaderText="Release" SortExpression="Release" />
                        <asp:BoundField DataField="Product_Group_1" HeaderText="Product_Group" SortExpression="Product_Group_1" />
                        <asp:BoundField DataField="Item_Ct_Out" HeaderText="Item Ct Out" SortExpression="Item_Ct_Out">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Piece_Ct_Out" HeaderText="Piece Ct Out" SortExpression="Piece_Ct_Out">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Weight_Out" DataFormatString="{0:n0}" HeaderText="Weight Out"
                            SortExpression="Weight_Out">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                    </Columns>
                    <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
                    <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                    SelectCommand="SELECT Terminal, Profile, Date, BOL, Release, [Product Group 1] AS Product_Group_1, [Item Ct Out] AS Item_Ct_Out, [Piece Ct Out] AS Piece_Ct_Out, [Weight Out] AS Weight_Out FROM [Blue Linx BOLs] WHERE ([Item ID] = @Item_ID) ORDER BY Date, BOL">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList1" Name="Item_ID" PropertyName="SelectedValue"
                            Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
    <br />
</asp:Content>

