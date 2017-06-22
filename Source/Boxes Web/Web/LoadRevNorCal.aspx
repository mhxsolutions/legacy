<%@ Page Language="VB" AutoEventWireup="false" CodeFile="LoadRevNorCal.aspx.vb" Inherits="LoadRevNorCal" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Load Revenue Breakout<br />
            Drivers v. Subs</h3>
    
    </div>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        CellPadding="4" DataSourceID="SqlDataSource1" EnableModelValidation="True" 
        ForeColor="#333333" GridLines="None">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="Year" HeaderText="Year" SortExpression="Year" />
            <asp:BoundField DataField="Month" HeaderText="Month" SortExpression="Month" />
            <asp:CheckBoxField DataField="Subhauler" HeaderText="Subhauler" 
                SortExpression="Subhauler" />
            <asp:BoundField DataField="Revenue" DataFormatString="{0:c}" 
                HeaderText="Revenue" SortExpression="Revenue" />
        </Columns>
        <EditRowStyle BackColor="#2461BF" />
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#EFF3FB" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
        SelectCommand="SELECT * FROM [LoadRevTinSheetBreakout] ORDER BY [Year] DESC, [Month] DESC, [Subhauler]">
    </asp:SqlDataSource>
    </form>
</body>
</html>
