<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Administration_BudwayUsers" Title="Untitled Page" Codebehind="BudwayUsers.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Budway Users</h2>
    <p>The following are the known Budway users of this site. Click the user ID to make changes.</p>
    <asp:GridView ID="UsersGridview" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False" AllowSorting="True">
        <RowStyle BackColor="#EFF3FB" />
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="White"/>
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="UserName" DataNavigateUrlFormatString="BudwayUserDetails.aspx?userId={0}" DataTextField="UserName" HeaderText="ID">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top"/>
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top"/>
            </asp:HyperLinkField>
            <asp:BoundField DataField="Email" HeaderText="Email">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top"/>
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top"/>
            </asp:BoundField>
            <asp:BoundField DataField="LastLoginDate" HeaderText="Last Login">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top"/>
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top"/>
            </asp:BoundField>
        </Columns>
        <EmptyDataTemplate>
            No data found.
        </EmptyDataTemplate>
    </asp:GridView>
</asp:Content>
