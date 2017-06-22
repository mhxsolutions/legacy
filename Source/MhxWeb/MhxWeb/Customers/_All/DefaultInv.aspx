<%@ Page Title="Inventory Reports" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="DefaultInv.aspx.cs" Inherits="Customers__All_DefaultInv" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h2>Inventory Reports</h2>
    <br />

    <div class="contentDiv">
        1. <strong><a href="inventoryatFON.aspx">at Budway</a></strong> - This report will show your inventory at Budway terminals.<br />
        <br />
        2. <strong><a href="HarborDetail.aspx">at LA/LB Harbor</a></strong> - This report will show your inventory at the
    LA/LB Harbors pending pickup.
    <br />
        <br />
        3. <a href="SearchInventoryatFON.aspx"><strong>Search Item ID (Budway)</strong> </a>
        - This report allows the client to search
    Budway Terminal inventory for specific item ID. Not all inventory has specific item
    IDs. Please contact your CSR for details.<br />
        <br />
        4. <strong><a href="SearchHarborInv.aspx">Search Item ID (Harbor)</a> </strong>- This report allows the client to search
    LA/LB Harbor inventory for specific item ID. Not all inventory has specific item
    IDs. Please contact your CSR for details.<br />
        <br />
        <strong>Origin</strong> - where the truck will be loaded<br />
        <strong>Destination</strong> - where the truck will deliver<br />
        <strong>Shipper or Shipping Client </strong>- the client who ordered the load for
    pickup<br />
        <strong>Receiver or Receiving Client </strong>- the client who will take legal posession
    of the delivery (not necessarily physical posession)<br />
    </div>


</asp:Content>

