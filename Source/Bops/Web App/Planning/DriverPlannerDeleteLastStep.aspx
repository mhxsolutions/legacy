<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" Inherits="Planning_DriverPlannerDeleteLastStep" 
    Title="BOPS | Planning | Delete Driver Plan Last Step" Codebehind="DriverPlannerDeleteLastStep.aspx.cs" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Delete Driver Plan Last Step</h2>
    <p>An error occurred while trying to delete the plan step. You may try again or contact IT support.</p>
    <a href="DriverPlannerEdit2.aspx?PlanId=<%=Request.QueryString["PlanId"]%>">Click here to return to the driver plan editor.</a>
</asp:Content>

