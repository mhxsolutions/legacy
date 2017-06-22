<%@ Page Language="VB" AutoEventWireup="false" CodeFile="UPIinvoices.aspx.vb" Inherits="UPIinvoices" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            UPI Invoices with Detail - <a href="default.aspx">home</a></h3>
        <hr />
        <br />
        Select Invoice:<asp:DropDownList ID="DropDownList1" runat="server" 
            AutoPostBack="True" DataSourceID="SqlDataSource1" 
            DataTextField="RFS_Invoice_Id" DataValueField="RFS_Invoice_Id">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            SelectCommand="SELECT DISTINCT [RFS Invoice Id] AS RFS_Invoice_Id FROM [UPI invoice list with detail] ORDER BY [RFS Invoice Id]">
        </asp:SqlDataSource>
        <br />
        <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
            AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource2" 
            ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="Invoice Date" DataFormatString="{0:d}" 
                    HeaderText="Invoice Date" SortExpression="Invoice Date" />
                <asp:BoundField DataField="Invoice Total" DataFormatString="{0:c}" 
                    HeaderText="Invoice Total" SortExpression="Invoice Total" />
                <asp:BoundField DataField="Load" HeaderText="Load" SortExpression="Load" />
                <asp:BoundField DataField="Item Total" DataFormatString="{0:c}" 
                    HeaderText="Item Total" SortExpression="Item Total" />
                <asp:BoundField DataField="Item Description" HeaderText="Item Description" 
                    SortExpression="Item Description" />
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
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            SelectCommand="SELECT * FROM [UPI invoice list with detail] WHERE ([RFS Invoice Id] = @RFS_Invoice_Id) ORDER BY [Load]">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="RFS_Invoice_Id" 
                    PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
