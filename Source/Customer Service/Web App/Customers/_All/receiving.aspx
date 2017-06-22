<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_receiving" 
    Title="Receiving History" CodeBehind="receiving.aspx.cs" CodeFile="receiving.aspx.cs"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Receiving History<br />
    </h3>
    <br />
    <table>
        <tr>
            <td align="left" style="width: 100px" valign="top">
                <strong>Start Date</strong></td>
            <td align="left" style="width: 100px" valign="top">
                <strong>End Date</strong></td>
        </tr>
        <tr>
            <td align="left" style="width: 100px" valign="top">
                <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="#999999" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt"
                    ForeColor="Black" Height="180px" Width="200px" CellPadding="4">
                    <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                    <SelectorStyle BackColor="#CCCCCC" />
                    <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <OtherMonthDayStyle ForeColor="#808080" />
                    <NextPrevStyle VerticalAlign="Bottom" />
                    <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                    <TitleStyle BackColor="#999999" Font-Bold="True" BorderColor="Black" />
                    <WeekendDayStyle BackColor="#FFFFCC" />
                </asp:Calendar>
            </td>
            <td align="left" style="width: 100px" valign="top">
                <asp:Calendar ID="Calendar2" runat="server" BackColor="White" BorderColor="#999999" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt"
                    ForeColor="Black" Height="180px" Width="200px" CellPadding="4">
                    <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                    <SelectorStyle BackColor="#CCCCCC" />
                    <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <OtherMonthDayStyle ForeColor="#808080" />
                    <NextPrevStyle VerticalAlign="Bottom" />
                    <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                    <TitleStyle BackColor="#999999" Font-Bold="True" BorderColor="Black" />
                    <WeekendDayStyle BackColor="#FFFFCC" />
                </asp:Calendar>
            </td>
        </tr>
    </table>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
        CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None"
        PageSize="250" AutoGenerateColumns="False">
        <RowStyle BackColor="#FFFBD6" ForeColor="#333333" Wrap="False" />
        <Columns>
            <asp:BoundField DataField="Terminal" HeaderText="Terminal" ReadOnly="True" SortExpression="Terminal" />
            <asp:BoundField DataField="Receiver_ID" HeaderText="Receiver" ReadOnly="True"
                SortExpression="Receiver_ID" />
            <asp:BoundField DataField="Carrier" HeaderText="Carrier" SortExpression="Carrier" />
            <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type" />
            <asp:BoundField DataField="Date_Received" DataFormatString="{0:d}" HeaderText="Date Rcd"
                SortExpression="Date_Received" />
            <asp:BoundField DataField="Profile" HeaderText="Profile" SortExpression="Profile" />
            <asp:BoundField DataField="Label_1" HeaderText="Label 1" SortExpression="Label_1" />
            <asp:BoundField DataField="Group_1" HeaderText="Group 1" SortExpression="Group_1" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Label_2" HeaderText="Label 2" SortExpression="Label_2" />
            <asp:BoundField DataField="Group_2" HeaderText="Group 2" SortExpression="Group_2" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Label_3" HeaderText="Label 3" SortExpression="Label_3" />
            <asp:BoundField DataField="Group_3" HeaderText="Group 3" SortExpression="Group_3" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Item_ID" HeaderText="Item ID" SortExpression="Item_ID" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Extended_Description" HeaderText="Ext Desc" SortExpression="Extended_Description" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="LnFt" DataFormatString="{0:f1}" HeaderText="Footage" SortExpression="LnFt">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Ct_in_Pkg" HeaderText="Pcs" SortExpression="Ct_in_Pkg" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="Pounds" HeaderText="Pounds" SortExpression="Pounds" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="Pkg" HeaderText="Units" SortExpression="Pkg" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
        </Columns>
        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" Wrap="False" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Terminal], [Receiver ID] AS Receiver_ID, [Type], [Date Received] AS Date_Received, [Profile], [Label 1] AS Label_1, [Group 1] AS Group_1, [Label 2] AS Label_2, [Group 2] AS Group_2, [Label 3] AS Label_3, [Group 3] AS Group_3, [Item ID] AS Item_ID, [Ct in Pkg] AS Ct_in_Pkg, [Pounds], [Pkg], [Carrier], [Extended Description] AS Extended_Description, [LnFt] FROM [Receivers semi summarized] WHERE (([client] = @client) AND ([Date Received] >= @Date_Received) AND ([Date Received] <= @Date_Received2)) ORDER BY [Terminal], [Receiver ID], [Group 1]">
        <SelectParameters>
            <asp:SessionParameter Name="client" SessionField="context_clientid" Type="Int32" />
            <asp:ControlParameter ControlID="Calendar1" DbType="DateTime" Name="Date_Received"
                PropertyName="SelectedDate" />
            <asp:ControlParameter ControlID="Calendar2" DbType="DateTime" Name="Date_Received2"
                PropertyName="SelectedDate" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
</asp:Content>

