<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Product Volume.aspx.vb" Inherits="Product_Volume" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Biggest Movers</title>
</head>
<body>
    <form id="form1" runat="server">
    <h3>
        Product Volume Shipped</h3>
    <div>
    
        <b>Year</b>:
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
            DataSourceID="SqlDataSource1" DataTextField="Year" DataValueField="Year">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            SelectCommand="SELECT DISTINCT [Year] FROM [Count of product shipped by month and year] ORDER BY [Year] DESC">
        </asp:SqlDataSource>
&nbsp;<b>Month</b>:<asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" 
            DataSourceID="SqlDataSource2" DataTextField="Month" DataValueField="Month">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            SelectCommand="SELECT DISTINCT [Month] FROM [Count of product shipped by month and year] WHERE ([Year] = @Year) ORDER BY [Month] DESC">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="Year" 
                    PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
&nbsp;<b>Fleet</b>:
        <asp:DropDownList ID="DropDownList3" runat="server" AutoPostBack="True" 
            DataSourceID="SqlDataSource4" DataTextField="Fleet" DataValueField="Fleet">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            SelectCommand="SELECT DISTINCT [Fleet] FROM [Count of product shipped by month and year] WHERE (([Year] = @Year) AND ([Month] = @Month)) ORDER BY [Fleet]">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="Year" 
                    PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="DropDownList2" Name="Month" 
                    PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    
        <br />
        <p>
            &nbsp;</p>
    
    </div>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        CellPadding="4" DataKeyNames="Client_Name" DataSourceID="SqlDataSource3" 
        ForeColor="#333333" GridLines="None" AllowSorting="True" 
        EnableModelValidation="True">
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:BoundField DataField="Client_Name" HeaderText="Client" 
                ReadOnly="True" SortExpression="Client_Name" />
            <asp:BoundField DataField="Load Type" HeaderText="Load Type" 
                SortExpression="Load Type" />
            <asp:BoundField DataField="Product_Group_1" HeaderText="PG1" 
                SortExpression="Product_Group_1" />
            <asp:BoundField DataField="Count" HeaderText="Count" 
                SortExpression="Count" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Weight" DataFormatString="{0:n0}" 
                HeaderText="Weight" SortExpression="Weight">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
        </Columns>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
        
        
        SelectCommand="SELECT [Client Name] AS Client_Name, [Load Type], [Product Group 1] AS Product_Group_1, Count, Weight, Feet FROM [Count of product shipped by month and year] WHERE (Year = @Year) AND (Month = @Month) AND (Fleet = @Fleet) ORDER BY Weight DESC, Feet, Client_Name, [Load Type], Product_Group_1">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="Year" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList2" Name="Month" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList3" Name="Fleet" 
                PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    </form>
</body>
</html>
