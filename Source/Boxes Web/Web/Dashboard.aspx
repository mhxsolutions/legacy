<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Dashboard.aspx.vb" Inherits="Dashboard" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Dashboard</title>
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            width: 234px;
        }
        .style3
        {
            width: 234px;
            font-weight: bold;
        }
        .style4
        {
            width: 432px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Revenue and Tons -
            Dashboard</h3>
    
    </div>
    <p>
        Year:
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
            DataSourceID="SqlDataSource1" DataTextField="Year" DataValueField="Year">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            SelectCommand="SELECT DISTINCT [Year] FROM [RFS Sum by Cost Center by Month] ORDER BY [Year] DESC">
        </asp:SqlDataSource>
&nbsp;Month:
        <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" 
            DataSourceID="SqlDataSource2" DataTextField="Month" DataValueField="Month">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            SelectCommand="SELECT DISTINCT [Month] FROM [RFS Sum by Cost Center by Month] WHERE ([Year] = @Year) ORDER BY [Month] DESC">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="Year" 
                    PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <table class="style1">
        <tr>
            <td class="style3">
                
                Invoicing Summary</td>
            <td class="style4">
                <b>Tons Handled</b><br />
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style2" valign="top">
            
                    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
                        AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" 
                        BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                        DataSourceID="SqlDataSource3" GridLines="Vertical">
                        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                        <Columns>
                            <asp:BoundField DataField="Cost_Center" HeaderText="Cost_Center" 
                                SortExpression="Cost_Center" />
                            <asp:BoundField DataField="Total" DataFormatString="{0:c}" HeaderText="Total" 
                                SortExpression="Total" >
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                        </Columns>
                        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                        <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                        <AlternatingRowStyle BackColor="#DCDCDC" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
                        SelectCommand="SELECT [Cost Center] AS Cost_Center, [Total] FROM [RFS Sum by Cost Center by Month] WHERE (([Year] = @Year) AND ([Month] = @Month)) ORDER BY [Cost Center]">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownList1" Name="Year" 
                                PropertyName="SelectedValue" Type="Int32" />
                            <asp:ControlParameter ControlID="DropDownList2" Name="Month" 
                                PropertyName="SelectedValue" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </p>
            </td>
            <td valign="top" class="style4">
                <asp:GridView ID="GridView2" runat="server" AllowSorting="True" 
                    AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" 
                    BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                    DataSourceID="SqlDataSource4" GridLines="Vertical" 
                    EnableModelValidation="True" style="text-align: right">
                    <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                    <Columns>
                        <asp:BoundField DataField="Fleet" HeaderText="Fleet" 
                            SortExpression="Fleet" >
                        <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Tons in" DataFormatString="{0:n1}" 
                            HeaderText="Tons in" SortExpression="Tons in">
                        <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Tons Out" DataFormatString="{0:n1}" 
                            HeaderText="Tons Out" SortExpression="Tons Out" />
                        <asp:BoundField DataField="Truck Tons" DataFormatString="{0:n1}" 
                            HeaderText="Truck Tons" SortExpression="Truck Tons">
                        </asp:BoundField>
                        <asp:BoundField DataField="Truck Ct" HeaderText="Truck Ct" 
                            SortExpression="Truck Ct" DataFormatString="{0:n0}">
                        </asp:BoundField>
                        <asp:BoundField DataField="Subhaul Tons" DataFormatString="{0:n1}" 
                            HeaderText="Subhaul Tons" SortExpression="Subhaul Tons" />
                        <asp:BoundField DataField="Subhaul Ct" DataFormatString="{0:n0}" 
                            HeaderText="Subhaul Ct" SortExpression="Subhaul Ct" />
                        <asp:BoundField DataField="WC Tons" DataFormatString="{0:n1}" 
                            HeaderText="WC Tons" SortExpression="WC Tons" />
                        <asp:BoundField DataField="WC Ct" DataFormatString="{0:n0}" HeaderText="WC Ct" 
                            SortExpression="WC Ct" />
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
                    
                    
                    SelectCommand="SELECT * FROM [Tons Handled by Fleet and Month] WHERE (([Year] = @Year) AND ([Month] = @Month)) ORDER BY [Fleet]">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList1" Name="Year" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="DropDownList2" Name="Month" 
                            PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td valign="top">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style2" valign="top">
            
                    No pass thru revenue.</td>
            <td valign="top" class="style4">
                Tons In - tons on receivers, no account transfer or corrections<br />
                Tons Out - tons on BOLs, no account transfer or corrections<br />
                Truck Tons - tons on all truck carriers</td>
            <td valign="top">
                &nbsp;</td>
        </tr>
    </table>
    </form>
</body>
</html>
