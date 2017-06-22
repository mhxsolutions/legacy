<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_Defaultloadhist" 
    Title="Load History Reports" CodeBehind="Defaultloadhist.aspx.cs" CodeFile="Defaultloadhist.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Load History Reports</h3>
    Load History reports have details of delivered loads including access to delivery
    receipts and delivery details.<br />
    <br />
    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Customers/_All/LoadCtHistory.aspx">Chart</asp:HyperLink><br />
    <br />
    &nbsp;<br />
    <br />
    <strong>Origin</strong> - where the truck will be loaded<br />
    <strong>Destination</strong> - where the truck will deliver<br />
    <strong>Shipper or Shipping Client </strong>- the client who ordered the load for
    pickup<br />
    <strong>Receiver or Receiving Client </strong>- the client who will take legal posession
    of the delivery (not necessarily physical posession)<br />
</asp:Content>

