<%@ Page Language="VB" AutoEventWireup="false" CodeFile="warehousebillingdetail.aspx.vb" Inherits="warehousebillingdetail" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Warehouse Billing Detail</title>
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            width: 570px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Warehouse Revenue</h3>
        <br />
        <table class="style1">
            <tr>
                <td class="style2">
                    <b>Start Date</b></td>
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
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style2">
                    <strong>Terminal</strong>:
                    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
                        DataSourceID="SqlDataSource1" DataTextField="Terminal" 
                        DataValueField="Terminal">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
                        SelectCommand="SELECT DISTINCT Terminal, [Company ID ref] FROM [Receiver billing] WHERE ([Date Received] &gt;= @Date_Received) AND ([Date Received] &lt;= @Date_Received2) AND ([Company ID ref] &lt; 3) ORDER BY Terminal">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="Calendar1" Name="Date_Received" 
                                PropertyName="SelectedDate" Type="DateTime" />
                            <asp:ControlParameter ControlID="Calendar2" Name="Date_Received2" 
                                PropertyName="SelectedDate" Type="DateTime" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
                <td>
                    <strong>Fleet</strong>:
                    <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" 
                        DataSourceID="SqlDataSource2" DataTextField="Fleet" DataValueField="Fleet">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
                        SelectCommand="SELECT DISTINCT Fleet, Terminal FROM [BOL billing] WHERE ([BOL Date] &gt;= @BOL_Date) AND ([BOL Date] &lt;= @BOL_Date2) AND (Terminal = @Selted_Term) ORDER BY Fleet">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="Calendar1" Name="BOL_Date" 
                                PropertyName="SelectedDate" Type="DateTime" />
                            <asp:ControlParameter ControlID="Calendar2" Name="BOL_Date2" 
                                PropertyName="SelectedDate" Type="DateTime" />
                            <asp:ControlParameter ControlID="DropDownList1" Name="Selted_Term" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td class="style2" valign="top">
                    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
                        AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource3" 
                        EnableModelValidation="True" ForeColor="#333333" GridLines="None">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="Receiver ID" HeaderText="Receiver" 
                                SortExpression="Receiver ID" />
                            <asp:BoundField DataField="Date Received" DataFormatString="{0:d}" 
                                HeaderText="Date Recd" SortExpression="Date Received" />
                            <asp:BoundField DataField="Client" HeaderText="Client" ReadOnly="True" 
                                SortExpression="Client" >
                            <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="RFS" HeaderText="RFS" SortExpression="RFS" />
                            <asp:BoundField DataField="Billing" DataFormatString="{0:c}" 
                                HeaderText="Item Billing" SortExpression="Billing" />
                            <asp:BoundField DataField="Invoice" 
                                HeaderText="Invoice" SortExpression="Invoice" />
                            <asp:BoundField DataField="Total" DataFormatString="{0:c}" 
                                HeaderText="Invoice Total" SortExpression="Total" />
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
                        SelectCommand="SELECT * FROM [Receiver billing] WHERE (([Date Received] &gt;= @Date_Received) AND ([Date Received] &lt;= @Date_Received2) AND ([Terminal] = @Terminal)) ORDER BY [Receiver ID]">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="Calendar1" Name="Date_Received" 
                                PropertyName="SelectedDate" Type="DateTime" />
                            <asp:ControlParameter ControlID="Calendar2" Name="Date_Received2" 
                                PropertyName="SelectedDate" Type="DateTime" />
                            <asp:ControlParameter ControlID="DropDownList1" Name="Terminal" 
                                PropertyName="SelectedValue" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
                <td valign="top">
                    <asp:GridView ID="GridView2" runat="server" AllowSorting="True" 
                        AutoGenerateColumns="False" CellPadding="4" DataKeyNames="BOL" 
                        DataSourceID="SqlDataSource4" EnableModelValidation="True" ForeColor="#333333" 
                        GridLines="None">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="BOL" HeaderText="BOL" ReadOnly="True" 
                                SortExpression="BOL" />
                            <asp:BoundField DataField="BOL Date" DataFormatString="{0:d}" 
                                HeaderText="BOL Date" SortExpression="BOL Date" />
                            <asp:BoundField DataField="Client" HeaderText="Client" ReadOnly="True" 
                                SortExpression="Client" >
                            <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Load Type" HeaderText="Load Type" 
                                SortExpression="Load Type" />
                            <asp:BoundField DataField="RFS" HeaderText="RFS" SortExpression="RFS" />
                            <asp:BoundField DataField="Billing" DataFormatString="{0:c}" 
                                HeaderText="Item Billing" SortExpression="Billing" />
                            <asp:BoundField DataField="Invoice" 
                                HeaderText="Invoice" SortExpression="Invoice" />
                            <asp:BoundField DataField="Total" DataFormatString="{0:c}" 
                                HeaderText="Invoice Total" SortExpression="Total" />
                        </Columns>
                        <EditRowStyle BackColor="#2461BF" />
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#EFF3FB" />
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
                        SelectCommand="SELECT * FROM [BOL billing] WHERE (([BOL Date] &gt;= @BOL_Date) AND ([BOL Date] &lt;= @BOL_Date2) AND ([Fleet] = @Fleet)) ORDER BY [BOL]">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="Calendar1" Name="BOL_Date" 
                                PropertyName="SelectedDate" Type="DateTime" />
                            <asp:ControlParameter ControlID="Calendar2" Name="BOL_Date2" 
                                PropertyName="SelectedDate" Type="DateTime" />
                            <asp:ControlParameter ControlID="DropDownList2" Name="Fleet" 
                                PropertyName="SelectedValue" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>
    
    </div>
    </form>
    <p>
        Item Billing is generated by the system. </p>
    <p>
        If there is no Invoice number that item has not been added to an invoice.</p>
    <p>
        Invoice Total is the total charged on the invoice containing the item in 
        question. It includes the billing for the item, additional items and manual 
        charges.</p>
</body>
</html>
