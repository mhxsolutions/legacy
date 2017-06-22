<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Drivers Not Assigned</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>
                Drivers Not Assigned</h1>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
                DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <RowStyle BackColor="#EFF3FB" />
                <Columns>
                    <asp:BoundField DataField="Drivers Not Assigned" HeaderText="Drivers Not Assigned"
                        ReadOnly="True" SortExpression="Drivers Not Assigned" />
                    <asp:CheckBoxField DataField="ServiceDriver" HeaderText="Service Driver" SortExpression="ServiceDriver" />
                </Columns>
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <EditRowStyle BackColor="#2461BF" />
                <AlternatingRowStyle BackColor="White" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                SelectCommand="SELECT * FROM [Drivers Not Assigned]"></asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
