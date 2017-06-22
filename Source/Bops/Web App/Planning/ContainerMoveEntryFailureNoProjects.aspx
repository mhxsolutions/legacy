<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" Inherits="Planning_ContainerMoveEntryFailureNoProjects" 
    Title="BOPS | Planning | Container Move Entry" Codebehind="ContainerMoveEntryFailureNoProjects.aspx.cs" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Container Move Entry</h2>
    <p>There are no active container projects, so no container move data may be entered.</p>
    <asp:HyperLink ID="_CreateProjectHyperlink" runat="server" Text="Click here to create a new container project."
        NavigateUrl="~/Planning/ContainerCreateProject.aspx" />
</asp:Content>
