<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers_Thoro_ThoroLoadPlan" Title="Thoro Dispatch Plan by Driver" Codebehind="ThoroLoadPlan.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Thoro Load Plan by Driver<br />
    </h3>
    Select Plan Date and Driver<br />
    <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="#999999"
        CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt"
        ForeColor="Black" Height="180px" Width="200px">
        <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
        <SelectorStyle BackColor="#CCCCCC" />
        <WeekendDayStyle BackColor="#FFFFCC" />
        <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
        <OtherMonthDayStyle ForeColor="#808080" />
        <NextPrevStyle VerticalAlign="Bottom" />
        <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
        <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
    </asp:Calendar>
    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2"
        DataTextField="Driver" DataValueField="Driver">
    </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT DISTINCT [Driver] FROM [Thoro Load Plan] ORDER BY [Driver]">
    </asp:SqlDataSource>
    <br />
    <br />
    <asp:Button ID="export2excel" runat="server" Text="Export to Excel" OnClick="export2excel_Click" /><br />
    <br />
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
        CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
        <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
        <Columns>
            <asp:BoundField DataField="Plan Date" DataFormatString="{0:d}" HeaderText="Plan Date"
                SortExpression="Plan Date" />
            <asp:BoundField DataField="Unit" HeaderText="Unit" SortExpression="Unit" />
            <asp:BoundField DataField="Origin" HeaderText="Origin" SortExpression="Origin" />
            <asp:BoundField DataField="Sch Arrive" DataFormatString="{0:t}" HeaderText="Sch Arrive"
                SortExpression="Sch Arrive" />
            <asp:BoundField DataField="Destination" HeaderText="Destination" SortExpression="Destination" />
            <asp:BoundField DataField="Sch Depart" DataFormatString="{0:t}" HeaderText="Sch Depart"
                SortExpression="Sch Depart" />
            <asp:BoundField DataField="Notes" HeaderText="Notes" SortExpression="Notes" />
            <asp:BoundField DataField="Transit" HeaderText="Transit" SortExpression="Transit" />
            <asp:BoundField DataField="Dwell" HeaderText="Dwell" SortExpression="Dwell" />
        </Columns>
        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Plan Date], Driver, Unit, Origin, [Sch Arrive], Destination, [Sch Depart], Notes, Transit, Dwell FROM [Thoro Load Plan] WHERE ([Plan Date] = @Plan_Date2) AND (Driver = @Driver) ORDER BY Driver, [Sch Arrive]">
        <SelectParameters>
            <asp:ControlParameter ControlID="Calendar1" DbType="DateTime" Name="Plan_Date2" PropertyName="SelectedDate" />
            <asp:ControlParameter ControlID="DropDownList1" Name="Driver" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>