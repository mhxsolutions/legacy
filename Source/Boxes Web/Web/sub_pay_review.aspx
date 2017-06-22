<%@ Page Language="VB" AutoEventWireup="false" CodeFile="sub_pay_review.aspx.vb" Inherits="sub_pay_review" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Subhaul Pay Review</title>
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            width: 277px;
        }
        .style3
        {
            width: 277px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Review Subhauler Pay</h3>
        <table class="style1">
            <tr>
                <td class="style3">
                    Start Date</td>
                <td>
                    <b>End Date</b></td>
            </tr>
            <tr>
                <td class="style2">
                    <asp:Calendar ID="Calendar1" runat="server" BackColor="White" 
                        BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" 
                        DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" 
                        ForeColor="#003399" Height="200px" Width="220px">
                        <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                        <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                        <OtherMonthDayStyle ForeColor="#999999" />
                        <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                        <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                        <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" 
                            Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                        <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                        <WeekendDayStyle BackColor="#CCCCFF" />
                    </asp:Calendar>
                </td>
                <td>
                    <asp:Calendar ID="Calendar2" runat="server" BackColor="White" 
                        BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" 
                        DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" 
                        ForeColor="#003399" Height="200px" Width="220px">
                        <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                        <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                        <OtherMonthDayStyle ForeColor="#999999" />
                        <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                        <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                        <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" 
                            Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                        <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                        <WeekendDayStyle BackColor="#CCCCFF" />
                    </asp:Calendar>
                </td>
            </tr>
        </table>
    
    </div>
    <p>
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
            DataSourceID="SqlDataSource2" DataTextField="Fleet" DataValueField="Fleet">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            SelectCommand="SELECT [Fleet] FROM [Fleet] ORDER BY [Fleet]">
        </asp:SqlDataSource>
    </p>
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
        AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" 
        EnableModelValidation="True" ForeColor="#333333" GridLines="None">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="Destination" HeaderText="Destination" 
                ReadOnly="True" SortExpression="Destination" />
            <asp:BoundField DataField="Invoice Date" DataFormatString="{0:d}" 
                HeaderText="Invoice Date" SortExpression="Invoice Date" />
            <asp:BoundField DataField="Driver" HeaderText="Driver" 
                SortExpression="Driver" />
            <asp:BoundField DataField="Origin" HeaderText="Origin" ReadOnly="True" 
                SortExpression="Origin" />
            <asp:BoundField DataField="LoadNotes" HeaderText="LoadNotes" 
                SortExpression="LoadNotes" />
            <asp:BoundField DataField="Invoice Total" DataFormatString="{0:c}" 
                HeaderText="Invoice Total" SortExpression="Invoice Total" />
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
        SelectCommand="SELECT * FROM [Sub Pay Review] WHERE (([Invoice Date] &gt;= @Invoice_Date) AND ([Invoice Date] &lt;= @Invoice_Date2) AND ([Fleet] = @Fleet)) ORDER BY [Destination], [Invoice Date] DESC, [Driver]">
        <SelectParameters>
            <asp:ControlParameter ControlID="Calendar1" Name="Invoice_Date" 
                PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="Calendar2" Name="Invoice_Date2" 
                PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="DropDownList1" Name="Fleet" 
                PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    </form>
</body>
</html>
