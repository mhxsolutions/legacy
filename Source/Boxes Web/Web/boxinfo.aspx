<%@ Page Language="VB" AutoEventWireup="false" CodeFile="boxinfo.aspx.vb" Inherits="boxinfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Box Information</title>
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <h3>
        Booking Container Information</h3>
    <div>
    
        <table class="style1">
            <tr>
                <td>
                    Project Booking</td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
                        DataSourceID="SqlDataSource1" DataTextField="Booking_Id" 
                        DataValueField="Booking_Id">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
                        SelectCommand="SELECT DISTINCT [Booking Id] AS Booking_Id FROM [Container Detail] ORDER BY [Booking Id]">
                    </asp:SqlDataSource>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
        </table>
    
    </div>
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
        AutoGenerateColumns="False" CellPadding="4" 
        DataKeyNames="Project Id,Container Id,Location" DataSourceID="SqlDataSource2" 
        ForeColor="#333333" GridLines="None">
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:BoundField DataField="Container Id" HeaderText="Container Id" 
                ReadOnly="True" SortExpression="Container Id" />
            <asp:BoundField DataField="Location" HeaderText="Location" ReadOnly="True" 
                SortExpression="Location" />
            <asp:BoundField DataField="Location Date" DataFormatString="{0:d}" 
                HeaderText="Location Date" SortExpression="Location Date" />
            <asp:BoundField DataField="Seal Id" HeaderText="Seal Id" 
                SortExpression="Seal Id" />
            <asp:BoundField DataField="Test Id" HeaderText="Test Id" 
                SortExpression="Test Id" />
            <asp:BoundField DataField="Belt Net Wt" HeaderText="Net Wt" 
                SortExpression="Belt Net Wt" />
        </Columns>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
        SelectCommand="SELECT * FROM [Container Detail] WHERE ([Booking Id] = @Booking_Id) ORDER BY [Container Id]">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="Booking_Id" 
                PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    </form>
</body>
</html>
