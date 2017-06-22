<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true"
    Inherits="Planning_ContainerConfirmProjectClose" Title="BOPS | Planning | Confirm Container Project Close" Codebehind="ContainerConfirmProjectClose.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h2>Confirm Container Project Close</h2>
    
    <p>
        The following table shows the criteria required and optional for evaluating whether a container project may
        be closed. The project under review is:<br /><br />
        <asp:Label ID="_ProjectInformationLabel" runat="server" />
    </p>
    
    <table border="1" cellpadding="4">
        <tr>
            <td valign="middle"><b>Criteria</b></td>
            <td valign="middle"><b>Modality</b></td>
            <td valign="middle"><b>Status</b></td>
        </tr>
        <tr>
            <td valign="middle"><a href="ContainerMoveHistory.aspx?ProjectId=<% Response.Write(Request.Params["ProjectId"]); %>">Pickups Equal Returns</a>:</td>
            <td valign="middle">Required</td>
            <td valign="middle" align="center"><asp:Image ID="_PickupsEqualReturnsImage" runat="server" /></td>
        </tr>
        <tr>
            <td valign="middle"><a href="ContainerDemurrageClock.aspx">Open Demurrage</a>:</td>
            <td valign="middle">Required</td>
            <td valign="middle" align="center"><asp:Image ID="_OpenDemurrageImage" runat="server" /></td>
        </tr>
        <tr>
            <td valign="middle">Pickups/Returns Match Project Total Count:</td>
            <td valign="middle">Optional</td>
            <td valign="middle" align="center"><asp:Image ID="_TotalMatchesImage" runat="server" /></td>
        </tr>
    </table>

    <p><asp:Label ID="_ConclusionLabel" runat="server" /></p>
    <asp:Button ID="_CloseButton" runat="server" Text="Close Project" OnClick="_CloseButton_Click" />
    
</asp:Content>
