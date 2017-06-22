<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Load Count.aspx.vb" Inherits="Load_Count" %>

<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Load Count by Destination and Date</title>
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            width: 424px;
        }
        .style3
        {
            width: 424px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h3>
            Load Count by Destination and Date<br />
        </h3>
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
                    &nbsp;</td>
            </tr>
        </table>
    
    </div>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
        <TotalSummary>
            <dx:ASPxSummaryItem FieldName="Ct" SummaryType="Sum" />
        </TotalSummary>
        <GroupSummary>
            <dx:ASPxSummaryItem FieldName="Ct" SummaryType="Sum" />
        </GroupSummary>
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Fleet" GroupIndex="0" SortIndex="0" 
                SortOrder="Ascending" VisibleIndex="1">
                <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Destination" VisibleIndex="3" 
                GroupIndex="2" SortIndex="2" SortOrder="Ascending">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Load Count" FieldName="Ct" SortIndex="5" 
                SortOrder="Descending" VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="Plan Date" VisibleIndex="6" SortIndex="4" 
                SortOrder="Ascending">
                <Settings GroupInterval="DateMonth" />
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="City" SortIndex="3" 
                SortOrder="Ascending" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Profile" GroupIndex="1" SortIndex="1" 
                SortOrder="Ascending" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <SettingsPager PageSize="30">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" 
            ShowGroupPanel="True" ShowFilterBar="Visible" />
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
        <SettingsPopup>
            <HeaderFilter MinHeight="200px" />
        </SettingsPopup>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString for SQL4 %>" 
        SelectCommand="SELECT * FROM [Load Count by Destination and Date] WHERE (([Plan Date] &gt;= @Plan_Date) AND ([Plan Date] &lt;= @Plan_Date2))">
        <SelectParameters>
            <asp:ControlParameter ControlID="Calendar1" Name="Plan_Date" 
                PropertyName="SelectedDate" Type="DateTime" />
            <asp:ControlParameter ControlID="Calendar2" Name="Plan_Date2" 
                PropertyName="SelectedDate" Type="DateTime" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" 
        GridViewID="ASPxGridView1" FileName="Load Count by Destination">
    </dx:ASPxGridViewExporter>
    </form>
    <p>
        Includes Drivers and Subs on Planner 
        with planned load for listed destination.</p>
</body>
</html>
