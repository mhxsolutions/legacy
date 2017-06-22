<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Harbor Plan Summary</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <h1>Harbor Plan Summary</h1>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
            DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <RowStyle BackColor="#EFF3FB" />
            <Columns>
                <asp:BoundField DataField="Request Date" HeaderText="Request Date" SortExpression="Request Date" DataFormatString="{0:MM//dd/yy}" />
                <asp:BoundField DataField="Plan Date" HeaderText="Plan Date" SortExpression="Plan Date" DataFormatString="{0:MM/dd/yy}" />
                <asp:BoundField DataField="Vessel" HeaderText="Vessel" SortExpression="Vessel" />
                <asp:BoundField DataField="Origin" HeaderText="Origin" SortExpression="Origin" />
                <asp:BoundField DataField="Shipper" HeaderText="Shipper" SortExpression="Shipper" />
                <asp:BoundField DataField="Destination" HeaderText="Destination" SortExpression="Destination" />
                <asp:BoundField DataField="Loads Requested" HeaderText="Loads Requested" SortExpression="Loads Requested" />
                <asp:BoundField DataField="Loads Planned" HeaderText="Loads Planned" SortExpression="Loads Planned" />
            </Columns>
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <EditRowStyle BackColor="#2461BF" />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT * FROM [Harbor Planned Load Summary] ORDER BY Origin ASC,Vessel ASC,Shipper ASC,Destination ASC">
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
