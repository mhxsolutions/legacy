<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvDemoReportSummary.aspx.cs" Inherits="InvDemoReportSummary" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Summary Report</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h3>
            Inventory Report Summary Report (<a href="invdemo.aspx">home</a>)<br />
        </h3>
        <br />
        <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
            CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <RowStyle BackColor="#EFF3FB" />
            <Columns>
                <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type" />
                <asp:BoundField DataField="Total" HeaderText="Total" SortExpression="Total" />
                <asp:BoundField DataField="Count" HeaderText="Count" SortExpression="Count" />
            </Columns>
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <EditRowStyle BackColor="#2461BF" />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT [Type], [Total], [Count] FROM [InvDemoSummaryReport] ORDER BY [Type]">
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
