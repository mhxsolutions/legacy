<%@ Page Language="VB" AutoEventWireup="false" CodeFile="DestDwell.aspx.vb" Inherits="DestDwell" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            width: 253px;
        }
        .style3
        {
            width: 253px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Dwell Review</h3>
        <p>
            Reporting dwell statistics from payroll records (planner actual) with dwell 
            between 5 and 300 minutes.</p>
    
    </div>
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
        <tr>
            <td class="style2">
                <strong>Fleet:</strong>
                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
                    DataSourceID="SqlDataSource1" DataTextField="Fleet" DataValueField="Fleet">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
                    SelectCommand="SELECT DISTINCT [Fleet] FROM [PlannerINFO dwell by date summary sel fleet] WHERE (([Plan Date] &gt;= @Plan_Date) AND ([Plan Date] &lt;= @Plan_Date2)) ORDER BY [Fleet]">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="Calendar1" Name="Plan_Date" 
                            PropertyName="SelectedDate" Type="DateTime" />
                        <asp:ControlParameter ControlID="Calendar2" Name="Plan_Date2" 
                            PropertyName="SelectedDate" Type="DateTime" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style2">
                <strong>Destination:</strong>
                <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" 
                    DataSourceID="SqlDataSource2" DataTextField="Destination" 
                    DataValueField="Destination">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
                    SelectCommand="SELECT DISTINCT [Destination] FROM [PlannerINFO dwell by date summary sel fleet] WHERE (([Fleet] = @Fleet) AND ([Plan Date] &gt;= @Plan_Date) AND ([Plan Date] &lt;= @Plan_Date2)) ORDER BY [Destination]">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList1" Name="Fleet" 
                            PropertyName="SelectedValue" Type="String" />
                        <asp:ControlParameter ControlID="Calendar1" Name="Plan_Date" 
                            PropertyName="SelectedDate" Type="DateTime" />
                        <asp:ControlParameter ControlID="Calendar2" Name="Plan_Date2" 
                            PropertyName="SelectedDate" Type="DateTime" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
        AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Destination" 
        DataSourceID="SqlDataSource3" EnableModelValidation="True" ForeColor="#333333" 
        GridLines="None">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="Fleet" HeaderText="Fleet" SortExpression="Fleet" />
            <asp:BoundField DataField="Plan Date" DataFormatString="{0:d}" 
                HeaderText="Plan Date" SortExpression="Plan Date" />
            <asp:BoundField DataField="Destination" HeaderText="Destination" 
                ReadOnly="True" SortExpression="Destination" />
            <asp:BoundField DataField="Count" HeaderText="Count" SortExpression="Count">
            <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Min" HeaderText="Min" SortExpression="Min">
            <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Max" HeaderText="Max" SortExpression="Max" >            
            <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Average" HeaderText="Average" 
                SortExpression="Average" >                
            <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
        </Columns>
        <EditRowStyle BackColor="#2461BF" />
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#EFF3FB" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
        SelectCommand="SELECT * FROM [PlannerINFO dwell by date summary sel fleet] WHERE (([Plan Date] &gt;= @Plan_Date) AND ([Plan Date] &lt;= @Plan_Date2) AND ([Fleet] = @Fleet) AND ([Destination] = @Destination)) ORDER BY [Plan Date]">
        <SelectParameters>
            <asp:ControlParameter ControlID="Calendar1" Name="Plan_Date" 
                PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="Calendar2" Name="Plan_Date2" 
                PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="DropDownList1" Name="Fleet" 
                PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="DropDownList2" Name="Destination" 
                PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    </form>
</body>
</html>
