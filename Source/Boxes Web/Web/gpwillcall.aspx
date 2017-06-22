<%@ Page Language="VB" AutoEventWireup="false" CodeFile="gpwillcall.aspx.vb" Inherits="gpwillcall" %>

<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=320" />
    <title>GP will call</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            GP will-call 
            time averages<br />
        </h3>
    
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        SelectCommand="SELECT * FROM [willcall time analysis for phone] ORDER BY [Date] DESC">
    </asp:SqlDataSource>
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
        AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" 
        ForeColor="#333333" GridLines="None">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="Company" HeaderText="Co." 
                SortExpression="Company" />
            <asp:BoundField DataField="Date" DataFormatString="{0:d}" HeaderText="Date" 
                SortExpression="Date" />
            <asp:BoundField DataField="WC Type" HeaderText="Type" 
                SortExpression="WC Type" />
            <asp:BoundField DataField="Count" HeaderText="Ct" SortExpression="Count">
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="Wait Avg" HeaderText="Wait" 
                SortExpression="Wait Avg">
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="Load Avg" HeaderText="Load" 
                SortExpression="Load Avg">
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="Post Load Avg" HeaderText="Post" 
                SortExpression="Post Load Avg">
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="Total Avg" HeaderText="Total" 
                SortExpression="Total Avg">
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
    </form>
    <p>
        Wait Time Average - arrival to assign load</p>
    <p>
        Load Time Average - assign load to log out</p>
    <p>
        Post Load Time Average - log out to will-call complete</p>
    <p>
        Total Time Average - arrival to will-call complete</p>
</body>
</html>
