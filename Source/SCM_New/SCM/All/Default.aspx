<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="All_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">

    <h1>Welcome <%= User.Identity.Name %> !</h1>
    <br />
    <br />
    <div class="contentDiv">
        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" ShowCollapseButton="false" HeaderText="Welcome" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">
                    <table style="width: 100%; border-collapse: separate; border-spacing: 8px;">
                        <tr>
                            <td>You have logged in as:
                                <dx:ASPxLabel ID="lblRoles" runat="server" Font-Bold="true"></dx:ASPxLabel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Your current Company: 
                                <dx:ASPxLabel ID="lblImpersonatedCompany" runat="server" Font-Bold="true" />
                            </td>
                        </tr>
                    </table>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>
    </div>
</asp:Content>

