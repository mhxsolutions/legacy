<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TTLavg.aspx.vb" Inherits="TTLavg" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Average LnFt</title>
</head>
<body>
    <form id="form1" runat="server">
    <h3>
        TTL Average Linear Feet</h3>
    <div>
    
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
            DataSourceID="SqlDataSource1" DataTextField="Client" DataValueField="Client">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            SelectCommand="SELECT DISTINCT [Client] FROM [TTL average LnFt] ORDER BY [Client]">
        </asp:SqlDataSource>
    
    </div>
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
        AutoGenerateColumns="False" BackColor="White" BorderColor="#E7E7FF" 
        BorderStyle="None" BorderWidth="1px" CellPadding="3" 
        DataSourceID="SqlDataSource2" GridLines="Horizontal">
        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
        <Columns>
            <asp:BoundField DataField="Extended_Description" 
                HeaderText="Extended_Description" SortExpression="Extended_Description" />
            <asp:BoundField DataField="Profile" HeaderText="Profile" 
                SortExpression="Profile" />
            <asp:BoundField DataField="Avg_Wt" DataFormatString="{0:n0}" 
                HeaderText="Avg_Wt" SortExpression="Avg_Wt">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Min_LnFt" DataFormatString="{0:n1}" 
                HeaderText="Min_LnFt" SortExpression="Min_LnFt">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Max_LnFt" DataFormatString="{0:n1}" 
                HeaderText="Max_LnFt" SortExpression="Max_LnFt">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Avg_LnFt" DataFormatString="{0:n1}" 
                HeaderText="Avg_LnFt" SortExpression="Avg_LnFt">
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
        SelectCommand="SELECT [Profile], [Extended Description] AS Extended_Description, [Min LnFt] AS Min_LnFt, [Max LnFt] AS Max_LnFt, [Avg LnFt] AS Avg_LnFt, [Avg Wt] AS Avg_Wt FROM [TTL average LnFt] WHERE ([Client] = @Client) ORDER BY [Extended Description]">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="Client" 
                PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    </form>
</body>
</html>
