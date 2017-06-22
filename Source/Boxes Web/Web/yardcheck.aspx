<%@ Page Language="VB" AutoEventWireup="false" CodeFile="yardcheck.aspx.vb" Inherits="yardcheck" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Yard Check</title>
</head>
<body>
    <h3>
        Container Yard Check</h3>
    <form id="form1" runat="server">
    <p>
        Select Location:
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
            DataSourceID="SqlDataSource1" DataTextField="Location" 
            DataValueField="Location">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            SelectCommand="SELECT DISTINCT [Location] FROM [CPS Yard Check] ORDER BY [Location]">
        </asp:SqlDataSource>
    </p>
    <div>
    
        <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
            AutoGenerateColumns="False" BackColor="#CCCCCC" BorderColor="#999999" 
            BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" 
            DataSourceID="SqlDataSource2" ForeColor="Black">
            <RowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="Container Id" HeaderText="Container" 
                    SortExpression="Container Id" />
                <asp:BoundField DataField="Booking Id" HeaderText="Booking" 
                    SortExpression="Booking Id" />
                <asp:BoundField DataField="Location" HeaderText="Location" 
                    SortExpression="Location" />
                <asp:BoundField DataField="Location Date" DataFormatString="{0:d}" 
                    HeaderText="Location Date" SortExpression="Location Date" />
                <asp:BoundField DataField="Remaining Hours" HeaderText="Remaining Hours" 
                    ReadOnly="True" SortExpression="Remaining Hours" />
                <asp:CheckBoxField HeaderText="Empty" />
                <asp:CheckBoxField HeaderText="Loaded" />
                <asp:CheckBoxField HeaderText="Seal #" />
                <asp:CheckBoxField HeaderText="BOL attached" />
            </Columns>
            <FooterStyle BackColor="#CCCCCC" />
            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            SelectCommand="SELECT * FROM [CPS Yard Check] WHERE ([Location] = @Location) ORDER BY [Container Id]">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="Location" 
                    PropertyName="SelectedValue" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
