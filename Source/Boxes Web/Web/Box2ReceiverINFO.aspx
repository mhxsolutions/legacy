<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Box2ReceiverINFO.aspx.vb" Inherits="Box2ReceiverINFO" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Box to Receiver INFO</title>
</head>
<body>
    <form id="form1" runat="server">
    <h3>
        Box to Container Info</h3>
    <div>
    
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
            DataSourceID="SqlDataSource1" DataTextField="Booking_Id" 
            DataValueField="Booking_Id">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            SelectCommand="SELECT DISTINCT [Booking Id] AS Booking_Id FROM [Containers and Receivers test] ORDER BY [Booking Id]">
        </asp:SqlDataSource>
    
    </div>
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
        AutoGenerateColumns="False" BackColor="White" BorderColor="White" 
        BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" CellSpacing="1" 
        DataKeyNames="Container" DataSourceID="SqlDataSource2" GridLines="None">
        <RowStyle BackColor="#DEDFDE" ForeColor="Black" />
        <Columns>
            <asp:BoundField DataField="Booking Id" HeaderText="Booking Id" 
                SortExpression="Booking Id" />
            <asp:BoundField DataField="Container" HeaderText="Container" ReadOnly="True" 
                SortExpression="Container" />
            <asp:BoundField DataField="PUR" HeaderText="PUR" SortExpression="PUR" />
            <asp:BoundField DataField="Receiver" HeaderText="Receiver" 
                SortExpression="Receiver" />
            <asp:BoundField DataField="BOL" HeaderText="BOL" SortExpression="BOL" />
            <asp:BoundField DataField="Pounds" HeaderText="Pounds" 
                SortExpression="Pounds" />
            <asp:BoundField DataField="PG1" HeaderText="PG1" SortExpression="PG1" />
            <asp:BoundField DataField="Seal Id" HeaderText="Seal Id" 
                SortExpression="Seal Id" />
            <asp:BoundField DataField="Test Id" HeaderText="Test Id" 
                SortExpression="Test Id" />
            <asp:BoundField DataField="BIS BOL" HeaderText="BIS BOL" 
                SortExpression="BIS BOL" />
        </Columns>
        <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
        <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
        <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
        SelectCommand="SELECT * FROM [Containers and Receivers test] WHERE ([Booking Id] = @Booking_Id)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="Booking_Id" 
                PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    </form>
</body>
</html>
