<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ODdetail.aspx.vb" Inherits="ODdetail" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>OD Load Detail</title>
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            width: 243px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            OD Load Detail</h3>
        <br />
        Fleet:
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
            DataSourceID="SqlDataSource1" DataTextField="Fleet" DataValueField="Fleet">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            SelectCommand="SELECT [Fleet] FROM [Fleet] ORDER BY [Fleet]">
        </asp:SqlDataSource>
        <br />
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
    <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        CellPadding="4" DataKeyNames="Load" DataSourceID="SqlDataSource2" 
        EnableModelValidation="True" ForeColor="#333333" GridLines="None" 
        AllowSorting="True">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="Plan Date" DataFormatString="{0:d}" 
                HeaderText="Plan Date" SortExpression="Plan Date" />
            <asp:BoundField DataField="Origin" HeaderText="Origin" ReadOnly="True" 
                SortExpression="Origin" />
            <asp:BoundField DataField="Destination" HeaderText="Destination" 
                ReadOnly="True" SortExpression="Destination" />
            <asp:BoundField DataField="Load" HeaderText="Load" ReadOnly="True" 
                SortExpression="Load" />
            <asp:BoundField DataField="Client" HeaderText="Client" ReadOnly="True" 
                SortExpression="Client" />
            <asp:BoundField DataField="GrossWeight" HeaderText="GrossWeight" 
                SortExpression="GrossWeight" />
            <asp:BoundField DataField="Act Transit" HeaderText="Act Transit" 
                ReadOnly="True" SortExpression="Act Transit" />
            <asp:BoundField DataField="Act Dwell" HeaderText="Act Dwell" ReadOnly="True" 
                SortExpression="Act Dwell" />
        </Columns>
        <EditRowStyle BackColor="#2461BF" />
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#EFF3FB" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
        SelectCommand="SELECT * FROM [OD load information] WHERE (([Fleet] = @Fleet) AND ([Plan Date] &gt;= @Plan_Date) AND ([Plan Date] &lt;= @Plan_Date2)) ORDER BY [Origin], [Destination], [Plan Date]">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="Fleet" 
                PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="Calendar1" Name="Plan_Date" 
                PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="Calendar2" Name="Plan_Date2" 
                PropertyName="SelectedDate" Type="DateTime" />
        </SelectParameters>
    </asp:SqlDataSource>
    </form>
</body>
</html>
