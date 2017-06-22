<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers_DefaultHarbor" Title="STAR Tools" 
    CodeBehind="DefaultHarbor.aspx.cs" CodeFile="DefaultHarbor.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Harbor Reports</h3>
    Our harbor operations for Los Angeles and Long Beach maintain inventories distinct
    from our terminal systems.Please use these reports for data limited to the LA/LB
    harbor.<br />
    <br />
    <a href="HarborDetail.aspx">Current Inventory</a><br />
    <br />
    <a href="HarborSummary.aspx">Delivery Order Status<br />
        <br />
    </a><a href="HarborDetailHistory.aspx">Inventory Detail History<br />
        <br />
    </a><a href="Vessel_Loads.aspx">Loads by Vessel<br />
        <br />
    </a><a href="SearchHarborInv.aspx">Inventory search by ID<br />
    </a>
    <br />
    <strong>Origin - </strong>where the truck will be loaded<br />
    <strong>
        Destination - </strong>where the truck will deliver<br />
    <strong>
        Shipper or Shipping Client - </strong>the client who ordered the load for pickup<br />
    <strong>
        Receiver or Receiving Client </strong>- the client who will take legal posession
    of the delivery (not necessarily physical posession)<br />
</asp:Content>

