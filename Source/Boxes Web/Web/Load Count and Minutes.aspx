<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Load Count and Minutes.aspx.vb" Inherits="Load_Count_and_Minutes" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Load Count</title>
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            width: 369px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Load Count and Minutes (daily summary)</h3>
    
    </div>
    <table class="style1">
        <tr>
            <td class="style2">
                <strong>Start Date</strong></td>
            <td>
                <strong>End Date</strong></td>
        </tr>
        <tr>
            <td class="style2">
                <asp:Calendar ID="Calendar1" runat="server" BackColor="White" 
                    BorderColor="Black" DayNameFormat="Shortest" Font-Names="Times New Roman" 
                    Font-Size="10pt" ForeColor="Black" Height="220px" NextPrevFormat="FullMonth" 
                    TitleFormat="Month" Width="400px">
                    <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" 
                        ForeColor="#333333" Height="10pt" />
                    <DayStyle Width="14%" />
                    <NextPrevStyle Font-Size="8pt" ForeColor="White" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <SelectedDayStyle BackColor="#CC3333" ForeColor="White" />
                    <SelectorStyle BackColor="#CCCCCC" Font-Bold="True" Font-Names="Verdana" 
                        Font-Size="8pt" ForeColor="#333333" Width="1%" />
                    <TitleStyle BackColor="Black" Font-Bold="True" Font-Size="13pt" 
                        ForeColor="White" Height="14pt" />
                    <TodayDayStyle BackColor="#CCCC99" />
                </asp:Calendar>
            </td>
            <td>
                <asp:Calendar ID="Calendar2" runat="server" BackColor="White" 
                    BorderColor="Black" DayNameFormat="Shortest" Font-Names="Times New Roman" 
                    Font-Size="10pt" ForeColor="Black" Height="220px" NextPrevFormat="FullMonth" 
                    TitleFormat="Month" Width="400px">
                    <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" 
                        ForeColor="#333333" Height="10pt" />
                    <DayStyle Width="14%" />
                    <NextPrevStyle Font-Size="8pt" ForeColor="White" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <SelectedDayStyle BackColor="#CC3333" ForeColor="White" />
                    <SelectorStyle BackColor="#CCCCCC" Font-Bold="True" Font-Names="Verdana" 
                        Font-Size="8pt" ForeColor="#333333" Width="1%" />
                    <TitleStyle BackColor="Black" Font-Bold="True" Font-Size="13pt" 
                        ForeColor="White" Height="14pt" />
                    <TodayDayStyle BackColor="#CCCC99" />
                </asp:Calendar>
            </td>
        </tr>
        <tr>
            <td class="style2">
                <asp:Button ID="Button1" runat="server" Text="Export to Excel" />
            </td>
            <td>
                <a href="load%20count%2030%20day%20histo.aspx">30 day histogram data</a></td>
        </tr>
    </table>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2003Olive">
        <GroupSummary>
            <dx:ASPxSummaryItem FieldName="Load Count" SummaryType="Sum" />
        </GroupSummary>
        <Columns>
            <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True"/>
            <dx:GridViewDataTextColumn FieldName="Fleet" SortIndex="0" 
                SortOrder="Ascending" VisibleIndex="1">
                <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Load Count" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Minutes" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="Plan Date" SortIndex="1" 
                SortOrder="Ascending" VisibleIndex="2">
            </dx:GridViewDataDateColumn>
        </Columns>
        <SettingsPager PageSize="30">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        <SettingsPopup>
            <HeaderFilter MinHeight="200px" />
        </SettingsPopup>
    </dx:ASPxGridView>
    <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" 
        GridViewID="ASPxGridView1">
    </dx:ASPxGridViewExporter>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        SelectCommand="SELECT * FROM [Planned load count and minutes by terminal daily summary] WHERE (([Plan Date] &gt;= @Plan_Date) AND ([Plan Date] &lt;= @Plan_Date2))">
        <SelectParameters>
            <asp:ControlParameter ControlID="Calendar1" Name="Plan_Date" 
                PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="Calendar2" Name="Plan_Date2" 
                PropertyName="SelectedDate" Type="DateTime" />
        </SelectParameters>
    </asp:SqlDataSource>
    </form>
</body>
</html>
