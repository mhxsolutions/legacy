<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" Inherits="RFS_RfsWizardTools" Title="Untitled Page" Codebehind="RfsWizardTools.aspx.cs" %>
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
            <a class="selected" href="#">Tools</a>
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

    <div style="z-index: 104; left: 0px; width: 1000px; top: 10px; position: relative; ">

    <h2>Validate RFS</h2>
    <p>
        This tool will check the current RFS for a variety of error conditions. Click the
        button below to begin validation.
    </p>
    <p>
        <asp:Button ID="ValidateCurrentRfsButton" runat="server" OnClick="ValidateCurrentRfsButton_Click" Text="Validate Current RFS" />
    </p>
    
    <h2>Duplicate RFS</h2>
    <p>
        This tool will attempt to create a duplicate of the current RFS. If the process is successful,
        the new RFS will be selected for editing. If the process fails for any reason, a list of errors
        detected with the current RFS will be displayed instead.
    </p>
    <p>
        <asp:Button ID="DuplicateCurrentRfsButton" runat="server" Text="Duplicate Current RFS" OnClick="DuplicateCurrentRfsButton_Click" />
    </p>
        
    </div>

</asp:Content>

