<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SubhaulersOnPlan.aspx.vb" Inherits="SubhaulersOnPlan" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Subhaulers On Plan</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Subhaulers On Plan</h3>
    
    </div>
    <p>
        Year:
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
            DataSourceID="SqlDataSource1" DataTextField="Yr" DataValueField="Yr">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT DISTINCT [Yr] FROM [Subhaulers on Plan] ORDER BY [Yr] DESC">
        </asp:SqlDataSource>
    </p>
    <p>
        Month:<asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" 
            DataSourceID="SqlDataSource2" DataTextField="Mo" DataValueField="Mo">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT DISTINCT [Mo] FROM [Subhaulers on Plan] WHERE ([Yr] = @Yr) ORDER BY [Mo] DESC">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="Yr" 
                    PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
            AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource3" 
            ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="Fleet" HeaderText="Fleet" SortExpression="Fleet" />
                <asp:BoundField DataField="LastName" HeaderText="LastName" 
                    SortExpression="LastName" />
                <asp:BoundField DataField="FirstName" HeaderText="FirstName" 
                    SortExpression="FirstName" />
                <asp:BoundField DataField="Count" HeaderText="Days used in Month" 
                    SortExpression="Count">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
            <EditRowStyle BackColor="#2461BF" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
            SelectCommand="SELECT * FROM [Subhaulers on Plan] WHERE (([Yr] = @Yr) AND ([Mo] = @Mo)) ORDER BY [Fleet], [LastName], [FirstName]">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="Yr" 
                    PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="DropDownList2" Name="Mo" 
                    PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    </form>
    <p>
        Only shows subhaulers with Title = Driver. (no Driver-NLE)</p>
</body>
</html>
