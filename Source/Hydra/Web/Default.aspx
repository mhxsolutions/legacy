<%@ Page Language="C#" MasterPageFile="~/Hydra.master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Web.Default"  Title="Hydra" %>
<%@ Register Assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

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
