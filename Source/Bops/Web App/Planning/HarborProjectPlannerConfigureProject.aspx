<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/BopsWeb.master"
    Inherits="Planning_HarborProjectPlannerConfigureProject" Codebehind="HarborProjectPlannerConfigureProject.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h2>
        Planning Status</h2>
    <p>
        The following project status codes may be set for internal use. "In Development"
        means that the project paperwork is not yet complete, "Not Yet Cleared" means that
        the paperwork is ready but clearance has not yet been obtained for unloading the
        vessel, and "Cleared" means that the project is ready for work.</p>
    <asp:RadioButtonList ID="PlanningStatus" runat="server">
    </asp:RadioButtonList><br />
    <!--
            <asp:ListItem Value="0">In Development</asp:ListItem>
            <asp:ListItem Value="1">Not Yet Cleared</asp:ListItem>
            <asp:ListItem Value="2">Cleared</asp:ListItem>
        -->
    <h2>
        Visibility</h2>
    <p>
        Checking the box below will remove the row defined by the project/destination pair
        from the planner. This will affect <em>only</em> its visibility on the planner;
        <em>none</em> of the project's data will be changed.</p>
    <asp:CheckBox ID="HideProject" runat="server" Text="Hide the Project" /><br />
    <br />
    <asp:Button ID="SaveChanges" runat="server" Text="Save Changes" OnClick="SaveChanges_Click" />
    <asp:Button ID="Cancel" runat="server" PostBackUrl="~/Planning/HarborProjectPlanner.aspx" Text="Cancel" />
</asp:Content>
