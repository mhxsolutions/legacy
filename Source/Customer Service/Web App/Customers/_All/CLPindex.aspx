<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_CLPindex" 
    Title="BudwayDirect - Current Load Plan Reports Index" CodeBehind="CLPindex.aspx.cs" CodeFile="CLPindex.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Current Load Plan Reports<br />
    </h3>
    Current Load Plan Reports are available for four different client configurations.<br />
    <br />
    1. <strong>to this Destination</strong> - This report will show loads from all Origins and all Shipping
    Clients. If your location will be receiving Budway loads from more than one client,
    this report will consolidate all shippers into one load plan.<br />
    <br />
    2. <strong>from this Origin</strong> - This report will show loads to all Destinations from this
    Origin.
    <br />
    <br />
    3. <strong>for this Receiver</strong> - This report will consolidate loads from any Origin to any
    Destination for a given Receiving Client, the client who will own the material upon
    delivery.<br />
    <br />
    4. <strong>for this Shipping Client </strong>- This report will consolidate loads from any Origin
    to any Destination for a given Shipping Client, the client who owned the material
    before shipment by Budway.<br />
    <br />
    <strong>Origin</strong> - where the truck will be loaded<br />
    <strong>Destination</strong> - where the truck will deliver<br />
    <strong>Shipper or Shipping Client </strong>- the client who ordered the load for
    pickup<br />
    <strong>Receiver or Receiving Client </strong>- the client who will take legal posession
    of the delivery (not necessarily physical posession)<br />
</asp:Content>

