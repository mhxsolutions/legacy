<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="Inventory_BisHelpRailcarToContainerWorkflow" Title="BOPS | Bulk Inventory System | Help - Railcar to Container Workflow" Codebehind="BisHelpRailcarToContainerWorkflow.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Help - Railcar to Container Workflow</h2>
    <h3>Entering Data</h3>
    <p>
        The Bulk Inventory System (BIS) container workflow is relatively straightforward, consisting of the following steps:
    </p>
    <ol>
        <li>Create new storage asset(s) from the railcar(s). Helpful links are available to 
        <a href="BisStorageAssets.aspx">view the list of storage assets</a> or to
        <a href="BisStorageCreateAssetFromRailcar.aspx">create a new storage asset from a railcar.</a>
        <b>NB: </b>In order for a railcar to be eligible, it must have a status of "Rail Yard", "Unloading", or "Loading" and
        have a positive number of pounds of material.</li>
        <li>Only containers "in play" (i.e., picked up but not yet returned) may receive material from the new 
        storage asset(s), so be sure to enter the container pickup moves via the <a href="../Planning/ContainerPlanner.aspx">container project planner.</a></li>
        <li>Enter the data for each withdrawal from the railcar(s) on the 
        <a href="BisWithdrawToContainer.aspx">withdraw to container page.</a></li>
        <li>As each railcar is emptied, deactivate it as a storage asset on the <a href="BisStorageAssets.aspx">storage assets page.</a></li>
        <li>Throughout the process, if the railcar amounts are off then adjust them manually as needed on the
        <a href="BisAdjustStorageAssetQuantity.aspx">adjust storage asset quantity page.</a></li>
    </ol>
    
    <h3>Reports</h3>
    <p>
        After the fact, there are two reports that are particularly useful in reviewing the data:
    </p>
    <ol>
        <li>The <a href="BisTransactionHistory.aspx">Transaction History</a> report shows all BIS transactions.</li>
        <li>The <a href="BisContainerProjects.aspx">Container Projects</a> report shows all of the container projects with BIS transactions, optionally drilling down
        to show the details of an individual container's loading.</li>
    </ol>
   
    
</asp:Content>

