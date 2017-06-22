<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="RFS_RfsWizardHelp" Title="BOPS | RFS Wizard | Help" Codebehind="RfsWizardHelp.aspx.cs" %>

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
            
            <a class="selected" href="RfsWizardHelp.aspx">Help Me!</a>
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

        <h2>What is this RFS Thing Anyway?</h2>
        <p>
            The purpose of a request for service, or RFS for short, is to describe every piece of Budway business 
            in a consistent fashion, whether it involves receiving, transloading, storage, or transportation,
            and whether it originates from our warehouse, the harbor, or elsewhere. This web interface is intended 
            to simplify the processes of defining the stakeholders, their roles, what services Budway is to render 
            for them, the rates,
            and so forth.
        </p>
        <p>
            The overall approach is simple: work your way through the tabs at the top of the page from left to
            right, adding information to the RFS as you go. Should you need a reminder, you may always come 
            back to this page by clicking the "Help" tab.
        Step by step help is available below for common tasks.</p>

        <h3>Editing an Existing RFS</h3>
        <p>
            Editing an existing RFS involves taking the following steps:
        </p>
        <ol>
            <li>Use the "Select" tab to choose the RFS to change.</li>
            <li>Use the "Main" tab to make changes to the top-level information.</li>
            <li>Use the "Stakeholders" tab to make any changes to the clients involved.</li>
            <li>Use the "Services" tab to make any changes to the services and rates.</li>
        </ol>
        <p>
            <a href="RfsWizardSelect.aspx">Click here to go directly to selection</a>, or click
            the tab at the top.
        </p>
    
        <h3>Creating a New RFS</h3>
        <p>
            Creating a new RFS involves taking the following steps:
        </p>
        <ol>
            <li>Use the "Create" tab to provide necessary information and make a new RFS.</li>
            <li>Use the "Main" tab to fill in other top-level, important information.</li>
            <li>Use the "Stakeholders" tab to specify which clients are involved and in which roles.</li>
            <li>Use the "Services" tab to specify which services, and at what rates, will be supplied.</li>
        </ol>
        <p>
            <a href="RfsWizardCreate.aspx">Click here to go directly to creation tab</a>, or click the tab at the top.
        </p>

        <a id="Stakeholder_Help"/><h2>Stakeholders and Roles</h2>

        <p>            
            A "stakeholder" is any party who has a vested interest in a given piece of business and plays
            a particular role. The following roles are used by the RFS system:
        </p>
        
        <dl>
        <dt>Shipper Stakeholders</dt><dd>Clients who actually send goods. Each RFS must have exactly <i>one</i> shipper.</dd><dt>Bill-to Stakeholders</dt><dd>Clients who pay for some (or all) of the services rendered.</dd><dt>Receiver Stakeholders</dt><dd>Clients who take ownership/custodial responsibility for goods.</dd><dt>Origin Stakeholders</dt><dd>Clients whose facilities serve as the starting half of an O/D pair.</dd><dt>Destination Stakeholders</dt><dd>Clients whose facilities serve as the ending half of an O/D pair.</dd></dl>
        

    </div>

</asp:Content>
