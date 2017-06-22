<%@ Page Language="C#" AutoEventWireup="true" CodeFile="h-sch.aspx.cs" Inherits="h_sch" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Harbor Schedule (m)</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h3>
            Harbor Schedule<br />
        </h3>
        Select Load Origin<br />
        <br />
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
            DataTextField="column1" DataValueField="column1">
        </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT DISTINCT [Load @] AS column1 FROM [vSYSharborArrivalsBB] ORDER BY [Load @]">
        </asp:SqlDataSource>
        <br />
        &nbsp;<asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
            CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None">
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <RowStyle BackColor="#EFF3FB" />
            <Columns>
                <asp:BoundField DataField="column1" DataFormatString="{0:t}" HeaderText="Arrive @"
                    HtmlEncode="False" SortExpression="column1" />
                <asp:BoundField DataField="column2" HeaderText="Load #" SortExpression="column2" />
                <asp:BoundField DataField="Driver" HeaderText="Driver" SortExpression="Driver" />
                <asp:BoundField DataField="Dest" HeaderText="Dest" SortExpression="Dest" />
            </Columns>
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <EditRowStyle BackColor="#2461BF" />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT [Arrive @] AS column1, [Load #] AS column2, [Driver], [Dest] FROM [vSYSharborArrivalsBB] WHERE ([Load @] = @column1) ORDER BY [Arrive @]">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="column1" PropertyName="SelectedValue"
                    Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
