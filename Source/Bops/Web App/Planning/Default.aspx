<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" Inherits="Planning_Default" 
    Title="BOPS | Planning" Codebehind="Default.aspx.cs" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <p>The following planners are available.</p>
    <ul>
        <li><a href="ContainerPlanner.aspx">Container Projects Planner</a> (and <a href="ContainerProjectsSummary.aspx">Container Projects Summary</a>)</li>
        <li><a href="DriverPlanner.aspx">Driver Web Planner</a></li>
        <li><a href="HarborProjectPlanner.aspx">Harbor Project Planner</a></li>
    </ul>
</asp:Content>
