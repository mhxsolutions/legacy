<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="Inventory_Default" Title="BOPS | Inventory" Codebehind="Default.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Inventory</h2>
    <h3>Bulk Inventory System</h3>
    <a href="BisStorageAssets.aspx">BIS Storage Assets</a><br />
    <a href="BisWithdrawToContainer.aspx">BIS Withdraw to Container</a><br />
    <a href="BisAdjustStorageAssetQuantity.aspx">BIS Adjust Storage Asset Quantity</a><br />
    <a href="BisTransactionHistory.aspx">BIS Transaction History</a><br />
    <a href="BisContainerProjects.aspx">BIS Container Projects</a><br /><br />
    <a href="BisHelpRailcarToContainerWorkflow.aspx">Help - Railcar to Container Workflow</a>
</asp:Content>
