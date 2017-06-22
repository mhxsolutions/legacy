<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Active Harbor Projects</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <h1>Active Harbor Projects</h1>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <RowStyle BackColor="#EFF3FB" />
            <Columns>
                <asp:BoundField DataField="LFD" HeaderText="LFD" SortExpression="LFD" DataFormatString="{0:MM/dd/yy}" />
                <asp:BoundField DataField="Client" HeaderText="Client" SortExpression="Client" />
                <asp:BoundField DataField="Vessel" HeaderText="Vessel" SortExpression="Vessel" />
                <asp:BoundField DataField="Origin" HeaderText="Origin" SortExpression="Origin" />
                <asp:BoundField DataField="Destination" HeaderText="Destination" SortExpression="Destination" />
                <asp:BoundField DataField="Load Est" HeaderText="Load Est" SortExpression="Load Est" />
                <asp:BoundField DataField="Loads Complete" HeaderText="Loads Complete" SortExpression="Loads Complete" />
                <asp:BoundField DataField="Loads Remaining" HeaderText="Loads Remaining" ReadOnly="True"
                    SortExpression="Loads Remaining" />
                <asp:BoundField DataField="Tendered" HeaderText="Tendered" SortExpression="Tendered" />
                <asp:BoundField DataField="Delivered" HeaderText="Delivered" SortExpression="Delivered" />
                <asp:BoundField DataField="O/S" HeaderText="O/S" ReadOnly="True" SortExpression="O/S" />
                <asp:BoundField DataField="Days Remaining" HeaderText="Days Remaining" ReadOnly="True"
                    SortExpression="Days Remaining" />
                <asp:BoundField DataField="LPD Remaining" HeaderText="LPD Remaining" ReadOnly="True"
                    SortExpression="LPD Remaining" />
                <asp:BoundField DataField="Days for Calc" HeaderText="Days for Calc" ReadOnly="True"
                    SortExpression="Days for Calc" />
                <asp:BoundField DataField="Product Type" HeaderText="Product Type" SortExpression="Product Type" />
            </Columns>
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <EditRowStyle BackColor="#2461BF" />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT * FROM webHarborDemand ORDER BY LFD ASC,Client ASC,Vessel ASC">
        </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
