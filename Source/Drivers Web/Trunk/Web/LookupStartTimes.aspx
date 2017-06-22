<%@ Page Language="C#" MasterPageFile="~/Drivers Web.master" AutoEventWireup="true"
    CodeFile="LookupStartTimes.aspx.cs" Inherits="LookupStartTimes" Title="Budway Drivers' Web | Lookup Start Times" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1>
        Lookup Start Times</h1>
    <table cellpadding="2">
        <tr>
            <td valign="top">
                Last Four Digits of SSN:</td>
            <td valign="top">
                <asp:TextBox ID="IdTextbox" runat="server"></asp:TextBox></td>
            <td valign="top">
                <asp:Button ID="LookupButton" runat="server" Text="Lookup" OnClick="LookupButton_Click" /></td>
        </tr>
    </table>
    <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
        DataSourceID="DriverStartTimesDatasource" ForeColor="#333333" GridLines="None" AllowSorting="True">
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:BoundField DataField="Plan Date" HeaderText="Plan Date" SortExpression="Plan Date" DataFormatString="{0:MM-dd-yy}" />
            <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="True" SortExpression="Name" />
            <asp:BoundField DataField="Start Time" HeaderText="Start Time" SortExpression="Start Time" DataFormatString="{0:hh:mm tt}" />
        </Columns>
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="DriverStartTimesDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Plan Date], Name, [Start Time] FROM [Driver Start Times for Today and Forward] WHERE (SSN = @Id)">
        <SelectParameters>
            <asp:ControlParameter ControlID="IdTextbox" Name="Id" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
        
</asp:Content>
