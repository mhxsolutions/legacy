<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ThoroP2P.aspx.vb" Inherits="ThoroP2P" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Fleet Services</title>
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            width: 218px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Fleet Services<br />
        </h3>
    
    </div>
    <table class="style1">
        <tr>
            <td class="style2">
                Start Date</td>
            <td>
                End Date</td>
        </tr>
        <tr>
            <td class="style2">
    <asp:Calendar ID="Calendar1" runat="server" BackColor="White" 
        BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" 
        Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" 
        Width="200px">
        <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
        <SelectorStyle BackColor="#CCCCCC" />
        <WeekendDayStyle BackColor="#FFFFCC" />
        <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
        <OtherMonthDayStyle ForeColor="#808080" />
        <NextPrevStyle VerticalAlign="Bottom" />
        <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
        <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
    </asp:Calendar>
            </td>
            <td>
                <asp:Calendar ID="Calendar2" runat="server" BackColor="White" 
                    BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" 
                    Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" 
                    Width="200px">
                    <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                    <SelectorStyle BackColor="#CCCCCC" />
                    <WeekendDayStyle BackColor="#FFFFCC" />
                    <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <OtherMonthDayStyle ForeColor="#808080" />
                    <NextPrevStyle VerticalAlign="Bottom" />
                    <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                    <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                </asp:Calendar>
            </td>
        </tr>
        <tr>
            <td class="style2">
                Select Fleet:
                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
                    DataSourceID="SqlDataSource2" DataTextField="Fleet" DataValueField="Fleet">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
                    SelectCommand="SELECT [Fleet] FROM [Fleet] ORDER BY [Fleet]">
                </asp:SqlDataSource>
            </td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
        DataSourceID="SqlDataSource1" AutoGenerateColumns="False" CellPadding="4" 
        ForeColor="#333333" GridLines="None">
        <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
        <Columns>
            <asp:BoundField DataField="Plan Date" DataFormatString="{0:d}" 
                HeaderText="Plan Date" SortExpression="Plan Date" />
            <asp:BoundField DataField="Driver" HeaderText="Driver" 
                SortExpression="Driver" />
            <asp:BoundField DataField="Origin" HeaderText="Origin" 
                SortExpression="Origin" />
            <asp:BoundField DataField="Destination" HeaderText="Destination" 
                SortExpression="Destination" />
            <asp:BoundField DataField="Load" HeaderText="Load" SortExpression="Load" />
            <asp:BoundField DataField="Notes" HeaderText="Notes" SortExpression="Notes" />
            <asp:BoundField DataField="Plan_Transit" HeaderText="Plan_Transit" 
                SortExpression="Plan_Transit">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="Plan_Dwell" HeaderText="Plan_Dwell" 
                SortExpression="Plan_Dwell">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="Transit" HeaderText="Transit" 
                SortExpression="Transit">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="Dwell" HeaderText="Dwell" SortExpression="Dwell">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
        </Columns>
        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
        
        
        
        SelectCommand="SELECT Driver, Origin, Destination, Notes, [Plan Transit] AS Plan_Transit, [Plan Dwell] AS Plan_Dwell, Transit, dwell, [Plan Date], [Order], Fleet, [Load] FROM [Thoro P2P] WHERE ([Plan Date] BETWEEN @Plan_Date AND @Plan_Date2) AND (Fleet = @Fleet) ORDER BY [Plan Date], Driver, [Order]">
        <SelectParameters>
            <asp:ControlParameter ControlID="Calendar1" DbType="Datetime" Name="Plan_Date" 
                PropertyName="SelectedDate" />
            <asp:ControlParameter ControlID="Calendar2" Name="Plan_Date2" 
                PropertyName="SelectedDate" />
            <asp:ControlParameter ControlID="DropDownList1" DefaultValue="Maas" 
                Name="Fleet" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    </form>
</body>
</html>
