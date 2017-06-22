<%@ Page Title="<%= this.WebSiteShortName %> | Impersonate Client" Language="C#" MasterPageFile="~/<%= this.WebSiteShortName %>.master" AutoEventWireup="true" CodeBehind="ImpersonateClient.aspx.cs" 
    Inherits="Web.Power_Users.ImpersonateClient" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Impersonate Client</h2>
    <asp:Panel ID="ImpersonatePanel" runat="server">
        <p>You may select a client to impersonate from the list below. This will not affect your login credentials or your web
        site privileges, but it will affect the data displayed on the various reports.</p>
        <table>
            <tr>
                <td valign="top">
                    Client:
                </td>
                <td valign="top">
                    <asp:DropDownList ID="ClientDropdownlist" runat="server" DataSourceID="UsersDataSource" DataTextField="Client" DataValueField="Destination id" />
                    <asp:SqlDataSource
                        ID="UsersDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                        SelectCommand="SELECT DISTINCT [DWS Rep Data].dbo.tbldestinationList.[Destination id], [DWS Rep Data].dbo.tbldestinationList.Destination + ': ' + [DWS Rep Data].dbo.tbldestinationList.City + ', ' + ISNULL([DWS Rep Data].dbo.tbldestinationList.State, '') AS Client FROM [<%= this.SqlShortName %> User Details] INNER JOIN [DWS Rep Data].dbo.tbldestinationList ON [<%= this.SqlShortName %> User Details].[Client Filter Destination Ref] = [DWS Rep Data].dbo.tbldestinationList.[Destination id] ORDER BY Client">
                    </asp:SqlDataSource>
                    <asp:Label ID="NoClientsLabel" Text="(no existing clients found)" runat="server" Visible="False" />
                </td>
            </tr>
            <tr>
                <td valign="top">
                </td>
                <td valign="top">
                    <asp:Button ID="ImpersonateButton" runat="server" Text="Impersonate" OnClick="ImpersonateButton_Click" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="ClearImpersonatePanel" runat="server">
    
        <% if (Session["CONTEXT_IMPERSONATE"] != null) {%>
            <p>You are currently impersonating <% Response.Write(Session["CONTEXT_IMPERSONATE"].ToString()); %>. To clear the impersonation, click
            the button below.</p>
        <% }  else { %>
            <p>If this message is visible, please contact the system administrator.</p>
        <% } %>
    
        <asp:Button ID="ClearImpersonateButton" runat="server" Text="Clear" OnClick="ClearImpersonateButton_Click" />
    </asp:Panel>
</asp:Content>
