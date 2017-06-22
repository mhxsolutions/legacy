<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Vessel Summary</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <h1>Vessel Summary</h1>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
            DataKeyNames="Client,Dest,PMID" DataSourceID="SqlDataSource1" ForeColor="#333333"
            GridLines="None">
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <RowStyle BackColor="#EFF3FB" />
            <Columns>
                <asp:BoundField DataField="Proj Client Ref" HeaderText="Proj Client Ref" SortExpression="Proj Client Ref" />
                <asp:BoundField DataField="Client" HeaderText="Client" ReadOnly="True" SortExpression="Client" />
                <asp:BoundField DataField="Vessel" HeaderText="Vessel" SortExpression="Vessel" />
                <asp:BoundField DataField="Dest" HeaderText="Dest" ReadOnly="True" SortExpression="Dest" />
                <asp:BoundField DataField="Start Project" HeaderText="Start Project" SortExpression="Start Project" />
                <asp:BoundField DataField="PO Number" HeaderText="PO Number" SortExpression="PO Number" />
                <asp:BoundField DataField="PMBOL1" HeaderText="PMBOL1" SortExpression="PMBOL1" />
                <asp:BoundField DataField="PMBOL2" HeaderText="PMBOL2" SortExpression="PMBOL2" />
                <asp:BoundField DataField="PMBOL3" HeaderText="PMBOL3" SortExpression="PMBOL3" />
                <asp:BoundField DataField="Start" HeaderText="Start" SortExpression="Start" />
                <asp:BoundField DataField="Recd" HeaderText="Recd" SortExpression="Recd" />
                <asp:BoundField DataField="PMID" HeaderText="PMID" ReadOnly="True" SortExpression="PMID" />
                <asp:BoundField DataField="PMBOL Client Number" HeaderText="PMBOL Client Number"
                    SortExpression="PMBOL Client Number" />
            </Columns>
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <EditRowStyle BackColor="#2461BF" />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT * FROM wProjectTotals WHERE (Client LIKE '%tree%' AND Vessel NOT LIKE '%cascade%' AND Vessel LIKE '%::Vessel::%') ORDER BY [Start Project] DESC,Vessel ASC,[PO Number] ASC,PMBOL1 ASC,PMBOL2 ASC,PMBOL3 ASC">
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
