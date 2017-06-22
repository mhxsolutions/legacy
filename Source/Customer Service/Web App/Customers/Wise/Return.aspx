<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers_Wise_Return" Title="Return Matrix" Codebehind="Return.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>
    Return Matrix
    </h2>
    Select Location:
    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
        DataTextField="Location" DataValueField="Location">
    </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT DISTINCT [Location] FROM [Wise matrix for rail shipments] ORDER BY [Location]">
    </asp:SqlDataSource>
    <br />
    <br />
    Select Start Date:<br />
    <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="White"
        BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="190px"
        NextPrevFormat="FullMonth" Width="350px">
        <SelectedDayStyle BackColor="#333399" ForeColor="White" />
        <TodayDayStyle BackColor="#CCCCCC" />
        <OtherMonthDayStyle ForeColor="#999999" />
        <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
        <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
        <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True"
            Font-Size="12pt" ForeColor="#333399" />
    </asp:Calendar>
    <br />
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" BackColor="White" BorderColor="#CC9966" BorderStyle="None"
        BorderWidth="1px" CellPadding="4" DataSourceID="SqlDataSource2" PageSize="100">
        <RowStyle BackColor="White" ForeColor="#330099" />
        <Columns>
            <asp:BoundField DataField="Plan Date" DataFormatString="{0:d}" HeaderText="Plan Date"
                HtmlEncode="False" SortExpression="Plan Date" />
            <asp:BoundField DataField="Location" HeaderText="Location" SortExpression="Location" />
            <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type" />
            <asp:BoundField DataField="Release Number" HeaderText="Release Number" SortExpression="Release Number" />
            <asp:BoundField DataField="Item ID" HeaderText="Item ID" SortExpression="Item ID" />
            <asp:BoundField DataField="Weight" HeaderText="Weight" SortExpression="Weight" />
            <asp:BoundField DataField="Transfer from Plant" DataFormatString="{0:c}" HeaderText="Transfer from Plant"
                HtmlEncode="False" ReadOnly="True" SortExpression="Transfer from Plant">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Rail Transload Fee" DataFormatString="{0:c}" HeaderText="Rail Transload Fee"
                HtmlEncode="False" ReadOnly="True" SortExpression="Rail Transload Fee">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Railroad Fee" DataFormatString="{0:c}" HeaderText="Railroad Fee"
                HtmlEncode="False" ReadOnly="True" SortExpression="Railroad Fee">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
        </Columns>
        <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
        <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Plan Date], Location, Profile, Type, [Release Number], [Item ID], Weight, [Transfer from Plant], [Rail Transload Fee], [Railroad Fee], [Budway Load in], [Budway Receiver], [Budway BOL] FROM [Wise matrix for rail shipments] WHERE (Location = @Location) AND ([Plan Date] >= @Plan_Date) ORDER BY [Plan Date], [Release Number]">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="Location" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="Calendar1" DbType="DateTime" Name="Plan_Date" PropertyName="SelectedDate" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

