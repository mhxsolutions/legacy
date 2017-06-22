<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_Defaultrail" 
    Title="Rail Reports" CodeBehind="Defaultrail.aspx.cs" CodeFile="Defaultrail.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Rail Reports</h3>
    Rail Reports are available for different configurations.<br />
    <br />
    1. <strong><a href="Rail.aspx">Railcars</a></strong> - This report will show current railcars in any one
    of&nbsp; four statuses (see below).<br />
    <br />
    2. <strong><a href="TransitInv.aspx">In-Transit Inventory</a></strong> - This report will show railcars Pending
    or waiting at the Rail Yard for unload and, if possible, the product on each car.
    This report requires Advanced Shipping Notices from the Shipping Client and arrangements
    with Budway Sales to provide Pre-Receivers.
    <br />
    <br />
    Railcar Status<br />
    1. <strong>Pending</strong> - in transit from Shipper to rail yard.<br />
    2. <strong>Rail Yard</strong> - the railcar has arrived at the local railyard, but
    it has not been delivered to Budway.<br />
    3. <strong>Budway Unloading</strong> - the railcar is at Budway and scheduled to
    be unloaded.<br />
    4. <strong>Budway Loading</strong> - the railcar is at Budway and is scheduled to
    be loaded.<br />
    5. <strong>Released</strong> - the railcar has been returned to the railroad.<br />
    <br />
    <strong>Origin</strong> - where the truck will be loaded<br />
    <strong>Destination</strong> - where the truck will deliver<br />
    <strong>Shipper or Shipping Client </strong>- the client who ordered the load for
    pickup<br />
    <strong>Receiver or Receiving Client </strong>- the client who will take legal posession
    of the delivery (not necessarily physical posession)<br />
</asp:Content>

