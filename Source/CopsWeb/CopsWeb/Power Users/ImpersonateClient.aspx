<%@ Page Title="Cops | Impersonate Client" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="ImpersonateClient.aspx.cs"
    Inherits="Web.Power_Users.ImpersonateClient" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Impersonate Client</h2>
    <div class="contentDiv">
        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" ShowCollapseButton="false" HeaderText="Impersonate Client" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">
                    <asp:Panel ID="ImpersonatePanel" runat="server">
                        <p>
                            You may select a client to impersonate from the list below.<br />
                            This will not affect your login credentials or your web
        site privileges, but it will affect the data displayed on the various reports.
                        </p>
                        <table style="border-collapse: separate; border-spacing: 8px;">
                            <tr>
                                <td>Client:</td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:DropDownList ID="ClientDropdownlist" runat="server" DataSourceID="UsersDataSource" DataTextField="Client" DataValueField="Destination id" />
                                    <asp:SqlDataSource
                                        ID="UsersDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
                                        SelectCommand="SELECT DISTINCT [DWS Rep Data].dbo.tbldestinationList.[Destination id], [DWS Rep Data].dbo.tbldestinationList.Destination + ': ' + [DWS Rep Data].dbo.tbldestinationList.City + ', ' + ISNULL([DWS Rep Data].dbo.tbldestinationList.State, '') AS Client FROM [Cops User Details] INNER JOIN [DWS Rep Data].dbo.tbldestinationList ON [Cops User Details].[Client Filter Destination Ref] = [DWS Rep Data].dbo.tbldestinationList.[Destination id] WHERE ([DWS Rep Data].dbo.tbldestinationList.[Company ID ref] = 1) ORDER BY Client"></asp:SqlDataSource>
                                    <asp:Label ID="NoClientsLabel" Text="(no existing clients found)" runat="server" Visible="False" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Button ID="ImpersonateButton" runat="server" Text="Impersonate" OnClick="ImpersonateButton_Click" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <asp:Panel ID="ClearImpersonatePanel" runat="server">

                        <% if (Session["CONTEXT_IMPERSONATE"] != null)
                           {%>
                        <p>
                            You are currently impersonating: <b><% Response.Write(Session["CONTEXT_IMPERSONATE"].ToString()); %></b>.
                            <br />
                            <br />
                            To clear the impersonation, click
            the button below.
                        </p>
                        <% }
                           else
                           { %>
                        <p>If this message is visible, please contact the system administrator.</p>
                        <% } %>
                        <br />
                        <asp:Button ID="ClearImpersonateButton" runat="server" Text="Clear" OnClick="ClearImpersonateButton_Click" />
                    </asp:Panel>

                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>
    </div>
</asp:Content>
