<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PercentLoaded.aspx.vb" Inherits="PercentLoaded" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Loaded Ratio</h3>
        <br />
        <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
            AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" 
            BorderStyle="None" BorderWidth="1px" CellPadding="3" 
            DataSourceID="SqlDataSource1" EnableModelValidation="True" GridLines="Vertical">
            <AlternatingRowStyle BackColor="#DCDCDC" />
            <Columns>
                <asp:BoundField DataField="Plan Date" DataFormatString="{0:d}" 
                    HeaderText="Plan Date" SortExpression="Plan Date" />
                <asp:BoundField DataField="Fleet" HeaderText="Fleet" SortExpression="Fleet" />
                <asp:BoundField DataField="Loaded Ratio" DataFormatString="{0:n2}" 
                    HeaderText="Loaded Ratio" ReadOnly="True" SortExpression="Loaded Ratio" />
            </Columns>
            <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
            <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
            <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
            <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            SelectCommand="SELECT * FROM [Loaded Ratio by fleet and date] ORDER BY [Plan Date] DESC, [Fleet]">
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
