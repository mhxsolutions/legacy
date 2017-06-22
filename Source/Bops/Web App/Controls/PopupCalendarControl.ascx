<%@ Control Language="C#" AutoEventWireup="true" Inherits="Controls_PopupCalendarControl" Codebehind="PopupCalendarControl.ascx.cs" %>
<asp:TextBox ID="DateTextbox" runat="server" />
<asp:Image ID="CalendarImage" runat="server" ImageUrl="~/Controls/PopupCalendarControl.png" />
<asp:Panel ID="PopupCalendarPanel" runat="server" Height="50px" Width="125px">
    <asp:Calendar ID="PopupCalendar" runat="server" BackColor="White" BorderColor="#999999"
        CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt"
        ForeColor="Black" Height="180px" Width="200px" OnSelectionChanged="PopupCalendar_SelectionChanged">
        <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
        <SelectorStyle BackColor="#CCCCCC" />
        <WeekendDayStyle BackColor="#FFFFCC" />
        <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
        <OtherMonthDayStyle ForeColor="#808080" />
        <NextPrevStyle VerticalAlign="Bottom" />
        <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
        <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
    </asp:Calendar>
</asp:Panel>
