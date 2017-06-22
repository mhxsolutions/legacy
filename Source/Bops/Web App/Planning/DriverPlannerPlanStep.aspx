<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" Inherits="Planning_DriverPlannerPlanStep" 
    Title="BOPS | Planning | Driver Plan Step" Codebehind="DriverPlannerPlanStep.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Driver Plan Step</h2>
    <p>An error occurred while trying to plan the step. You may try again or contact IT support.</p>
    <a href="DriverPlannerEdit2.aspx?PlanId=<%=Request.QueryString["PlanId"]%>">Click here to return to the driver plan editor.</a>
</asp:Content>
