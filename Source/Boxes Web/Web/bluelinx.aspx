<%@ Page Language="VB" AutoEventWireup="false" CodeFile="bluelinx.aspx.vb" Inherits="bluelinx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Blue Linx Activity</title>
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
    </style>
</head>
<body>
    <h3>
        Blue Linx Activity 
        by Item ID</h3>
    <form id="form1" runat="server">
    <div>
    
        Select Item ID: 
    
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
            DataSourceID="SqlDataSource1" DataTextField="Item_ID" DataValueField="Item_ID">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            SelectCommand="SELECT DISTINCT [Item ID] AS Item_ID FROM [Blue Linx Receivers] ORDER BY [Item ID]">
        </asp:SqlDataSource>
    
    </div>
    <table class="style1">
        <tr>
            <td>
                <b>Receiving</b></td>
            <td>
                <b>Bills of Lading</b></td>
        </tr>
        <tr>
            <td valign="top">
                <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
                    AutoGenerateColumns="False" BackColor="White" BorderColor="#E7E7FF" 
                    BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="Receiver" 
                    DataSourceID="SqlDataSource2" GridLines="Horizontal">
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                    <Columns>
                        <asp:BoundField DataField="Terminal" HeaderText="Terminal" 
                            SortExpression="Terminal" />
                        <asp:BoundField DataField="Profile" HeaderText="Profile" 
                            SortExpression="Profile" />
                        <asp:BoundField DataField="Date" DataFormatString="{0:d}" HeaderText="Date" 
                            SortExpression="Date" />
                        <asp:BoundField DataField="Receiver" HeaderText="Receiver" ReadOnly="True" 
                            SortExpression="Receiver" />
                        <asp:BoundField DataField="PO" HeaderText="PO" SortExpression="PO" />
                        <asp:BoundField DataField="Product_Group_1" HeaderText="Product_Group_1" 
                            SortExpression="PG1" />
                        <asp:BoundField DataField="Item_Ct_In" HeaderText="Item_Ct_In" 
                            SortExpression="Item_Ct_In" >
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Piece_Ct_In" HeaderText="Piece_Ct_In" 
                            SortExpression="Piece_Ct_In" >
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Weight_In" HeaderText="Weight_In" 
                            SortExpression="Weight_In" DataFormatString="{0:n0}" >
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                    </Columns>
                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
                    
                    SelectCommand="SELECT [Terminal], [Profile], [Date], [Receiver], [Product Group 1] AS Product_Group_1, [Item Ct In] AS Item_Ct_In, [Piece Ct In] AS Piece_Ct_In, [Weight In] AS Weight_In, [PO] FROM [Blue Linx Receivers] WHERE ([Item ID] = @Item_ID) ORDER BY [Date], [Receiver]">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList1" Name="Item_ID" 
                            PropertyName="SelectedValue" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td valign="top">
                <asp:GridView ID="GridView2" runat="server" AllowSorting="True" 
                    AutoGenerateColumns="False" BackColor="LightGoldenrodYellow" 
                    BorderColor="Tan" BorderWidth="1px" CellPadding="2" DataKeyNames="BOL" 
                    DataSourceID="SqlDataSource3" GridLines="None" ForeColor="Black">
                    <Columns>
                        <asp:BoundField DataField="Terminal" HeaderText="Terminal" 
                            SortExpression="Terminal" />
                        <asp:BoundField DataField="Profile" HeaderText="Profile" 
                            SortExpression="Profile" />
                        <asp:BoundField DataField="Date" DataFormatString="{0:d}" HeaderText="Date" 
                            SortExpression="Date" />
                        <asp:BoundField DataField="BOL" HeaderText="BOL" ReadOnly="True" 
                            SortExpression="BOL" />
                        <asp:BoundField DataField="Release" HeaderText="Release" 
                            SortExpression="Release" />
                        <asp:BoundField DataField="Product_Group_1" HeaderText="Product_Group_1" 
                            SortExpression="Product_Group_1" />
                        <asp:BoundField DataField="Item_Ct_Out" HeaderText="Item_Ct_Out" 
                            SortExpression="Item_Ct_Out" >
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Piece_Ct_Out" HeaderText="Piece_Ct_Out" 
                            SortExpression="Piece_Ct_Out" >
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Weight_Out" HeaderText="Weight_Out" 
                            SortExpression="Weight_Out" DataFormatString="{0:n0}" >
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                    </Columns>
                    <FooterStyle BackColor="Tan" />
                    <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" 
                        HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
                    <HeaderStyle BackColor="Tan" Font-Bold="True" />
                    <AlternatingRowStyle BackColor="PaleGoldenrod" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
                    
                    SelectCommand="SELECT [Terminal], [Profile], [Date], [BOL], [Product Group 1] AS Product_Group_1, [Item Ct Out] AS Item_Ct_Out, [Piece Ct Out] AS Piece_Ct_Out, [Weight Out] AS Weight_Out, [Release] FROM [Blue Linx BOLs] WHERE ([Item ID] = @Item_ID) ORDER BY [Date], [BOL]">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList1" Name="Item_ID" 
                            PropertyName="SelectedValue" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
