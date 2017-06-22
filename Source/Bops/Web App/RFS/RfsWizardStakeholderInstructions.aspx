<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="RFS_RfsWizardStakeholderInstructions" Title="BOPS | RFS Wizard | Stakeholder Instructions" Codebehind="RfsWizardStakeholderInstructions.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div id="top-container" style="z-index: 101; left: 0px; width: 1000px;">
        <div id="tabbed-bar">
            <a href="RfsWizardSelect.aspx">Select RFS</a>

            <!-- Show the create tab only if the user has advanced permissions -->
            
            <% if (User.IsInRole("Power Users") || User.IsInRole("Administrators")) { %>
            <a href="RfsWizardCreate.aspx">Create RFS</a>
            <% } %>
            
            <!-- Show the bracketed tabs only if the user has selected/created an RFS. -->
            
            <% if (Session["CONTEXT_RFSID"] != null) { %>
                <a href="RfsWizardMain.aspx">Main</a>
                <a href="RfsWizardStakeholders.aspx">Stakeholders</a>
                <a href="RfsWizardServices.aspx">Services</a>
            <% } %>
            
            <!-- Show the tools tab only if the user has selected/created an RFS and has advanced permissions -->
            
            <% if ((Session["CONTEXT_RFSID"] != null) && (User.IsInRole("Power Users") || User.IsInRole("Administrators"))) { %>
            <a href="RfsWizardTools.aspx">Tools</a>
            <% } %>
            
            <a href="RfsWizardHelp.aspx">Help Me!</a>
        </div>
    </div>

    <div style="z-index: 102; left: 0px; width: 1000px;">
        <div id="topbar">
            <div style="left: 0px; top: 5px; position: relative">
                <asp:Label ID="SelectedRfsLabel" runat="server" Text=""></asp:Label>            
            </div>
        </div>
    </div>

    <div style="z-index: 103; left: 0px; width: 1000px; top: 10px;">
        <h2>
            Instructions for <asp:Label ID="StakeholderDetailsLabel" runat="server" Text="(unknown)"></asp:Label>
        </h2>
        <p>
            Enter any special instructions or other information on this stakeholder in the following space.
            Press the button to save. To go back to the main stakeholders page, click the tab at the top.
        </p>
        <asp:SqlDataSource ID="StakeholderDetails" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT [RFS Stakeholders].[Stakeholder ID], [RFS Stakeholder Roles].Role AS Role, [DWS Rep Data].dbo.tbldestinationList.Destination AS Client FROM [RFS Stakeholders] INNER JOIN [RFS Stakeholder Roles] ON [RFS Stakeholders].[Role ref] = [RFS Stakeholder Roles].[Role Id] INNER JOIN [DWS Rep Data].dbo.tbldestinationList ON [RFS Stakeholders].[Client ref] = [DWS Rep Data].dbo.tbldestinationList.[Destination id] WHERE ([RFS Stakeholders].[Stakeholder ID] = @StakeholderId)">
            <SelectParameters>
                <asp:QueryStringParameter Name="StakeholderId" QueryStringField="StakeholderId" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="StakeholderInstructions" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT [Stakeholder ID] AS Stakeholder_ID, [Instructions] FROM [RFS Stakeholders] WHERE ([Stakeholder ID] = @Stakeholder_ID)"
            UpdateCommand="UPDATE [RFS Stakeholders] SET [Instructions] = @NewInstructions WHERE [Stakeholder ID] = @StakeholderId">
            <UpdateParameters>
                <asp:QueryStringParameter Name="StakeholderId" QueryStringField="StakeholderId" Type="Int32" />
                <asp:ControlParameter Name="NewInstructions" ControlID="InstructionsTextbox" PropertyName="Text" />
            </UpdateParameters>
            <SelectParameters>
                <asp:QueryStringParameter Name="Stakeholder_ID" QueryStringField="StakeholderId" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <div style="z-index: 105; left: 20px; position: relative">
            <table cellpadding="4">
                <tr>
                    <td valign="top">
                        <asp:Label ID="InstructionsLabel" AccessKey="I" AssociatedControlID="InstructionsTextbox"
                            runat="server" Text="<u>I</u>nstructions:" />
                    </td>
                    <td style="width: 400px">
                        <asp:TextBox ID="InstructionsTextbox" runat="server" Height="200px" Width="400px" TextMode="MultiLine"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <p>
                <asp:Button ID="SaveChangesButton" runat="server" Text="Save Changes" OnClick="SaveChangesButton_Click" />
            </p>
        </div>
    </div>
</asp:Content>
