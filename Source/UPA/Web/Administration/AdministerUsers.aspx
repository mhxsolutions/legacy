<%@ Page Title="UPA | Administer Users" Language="C#" MasterPageFile="~/UPA.master" AutoEventWireup="true" CodeBehind="AdministerUsers.aspx.cs" Inherits="Web.Administration.AdministerUsers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <h2>Administer Users</h2>
    <asp:GridView ID="GridView1"
        runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4"
        DataKeyNames="User Id" DataSourceID="UsersDataSource" ForeColor="#333333"
        GridLines="None">
        <EditRowStyle BackColor="#2461BF" />
        <EmptyDataTemplate>(no existing users found)</EmptyDataTemplate>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:BoundField DataField="User Id" HeaderText="User Id" ReadOnly="True" SortExpression="User Id" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Client" HeaderText="Client" ReadOnly="True" SortExpression="Client" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:HyperLinkField DataNavigateUrlFields="User Id" DataNavigateUrlFormatString="AdministerUsersDelete.aspx?UserId={0}" Text="Delete" />
            <asp:HyperLinkField DataNavigateUrlFields="User Id" DataNavigateUrlFormatString="AdministerUsersPassword.aspx?UserId={0}" Text="Change Password" />
        </Columns>
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" />
        <SortedAscendingCellStyle BackColor="#F5F7FB" />
        <SortedAscendingHeaderStyle BackColor="#6D95E1" />
        <SortedDescendingCellStyle BackColor="#E9EBEF" />
        <SortedDescendingHeaderStyle BackColor="#4870BE" />
    </asp:GridView>
    <asp:SqlDataSource ID="UsersDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>"
        SelectCommand="SELECT [UPA User Details].[User Id], [UPA Rep Data].dbo.tbldestinationList.Destination + ': ' + [UPA Rep Data].dbo.tbldestinationList.City + ', ' + ISNULL([UPA Rep Data].dbo.tbldestinationList.State, '') AS Client FROM [UPA User Details] INNER JOIN [UPA Rep Data].dbo.tbldestinationList ON [UPA User Details].[Client Filter Destination Ref] = [UPA Rep Data].dbo.tbldestinationList.[Destination id] ORDER BY [UPA User Details].[User Id]"
        InsertCommand="INSERT INTO [UPA User Details] ([User Id], [Client Filter Destination Ref]) VALUES (@UserId, @Client)">
        <InsertParameters>
            <asp:Parameter Name="UserId" />
            <asp:Parameter Name="Client" />
        </InsertParameters>
    </asp:SqlDataSource>

    <h3>
        Add a New User</h3>
    <p>
        To add a new user, provide the details and click the button.</p>
    <table width="100%">
        <tr>
            <td valign="top">
                <asp:Label ID="NewUserIdLabel" runat="server" Text="<u>U</u>ser ID:" AccessKey="U"
                    AssociatedControlID="NewUserIdTextbox" />
            </td>
            <td valign="top">
                <asp:TextBox ID="NewUserIdTextbox" runat="server" ValidationGroup="NewValueValidation" />
                <asp:RequiredFieldValidator ID="NewUserIdExistsValidator" runat="server" ControlToValidate="NewUserIdTextbox"
                    Display="Dynamic" ErrorMessage="User ID is required" ValidationGroup="NewValueValidation"></asp:RequiredFieldValidator>
                <asp:CustomValidator ID="NewUserIdValidator" runat="server" ErrorMessage="The user ID must contain only alphanumeric characters and must not already exist"
                    OnServerValidate="ServerValidateUserId" ValidationGroup="NewValueValidation"
                    ControlToValidate="NewUserIdTextbox" Display="Dynamic"></asp:CustomValidator>
            </td>
        </tr>
        <tr>
            <td valign="top">
                <asp:Label ID="NewPasswordLabel" runat="server" Text="<u>P</u>assword:" AccessKey="P"
                    AssociatedControlID="NewPasswordTextbox" />
            </td>
            <td valign="top">
                <asp:TextBox ID="NewPasswordTextbox" runat="server" ValidationGroup="NewValueValidation" TextMode="Password" />
                <asp:RequiredFieldValidator ID="NewPasswordExistsValidator" runat="server" ControlToValidate="NewPasswordTextbox"
                    Display="Dynamic" ErrorMessage="Password is required" ValidationGroup="NewValueValidation"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td valign="top">
                <asp:Label ID="NewUserClientLabel" runat="server" Text="<u>C</u>lient:" AccessKey="C"
                    AssociatedControlID="NewUserClientDropdown" />
            </td>
            <td valign="top">
                <asp:DropDownList ID="NewUserClientDropdown" runat="server" DataSourceID="StakeholderList"
                    DataTextField="Destination" DataValueField="Destination id" ValidationGroup="NewValueValidation">
                </asp:DropDownList>
                <asp:SqlDataSource ID="StakeholderList" runat="server" ConnectionString="<%$ ConnectionStrings:UPA Rep DataConnectionString %>"
                    SelectCommand="SELECT [Destination id], Destination + ': ' + City + ', ' + ISNULL(State, '') AS Destination, [Company ID ref] FROM tbldestinationList WHERE ([Parent Ref] = [Destination id]) AND ([Company ID ref] = 7)">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td valign="top">
            </td>
            <td valign="top">
                <asp:Button ID="AddUserButton" runat="server" Text="Add New User" ValidationGroup="NewValueValidation" OnClick="AddUserButton_Click" />
            </td>
        </tr>
    </table>

</asp:Content>
