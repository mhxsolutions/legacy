<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_LoadTrackingReport" 
    Title="BudwayDirect | Load Tracking" CodeBehind="LoadTrackingReport.aspx.cs" CodeFile="LoadTrackingReport.aspx.cs"%>

<%@ Register Src="../../Controls/LoadTrackingUnifiedLoadContentsControl.ascx" TagName="LoadTrackingUnifiedLoadContentsControl"
    TagPrefix="uc2" %>
<%@ Register Src="../../Controls/LoadTrackingUnifiedHistoryControl.ascx" TagName="LoadTrackingUnifiedHistoryControl"
    TagPrefix="uc1" %>

<asp:Content ID="LoadContentsTable" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2><asp:Literal ID="Literal1" runat="server" Text="Load Tracking Report"></asp:Literal>&nbsp;</h2>
    <h3>
                General Information</h3>
    <table cellpadding="4" border="1">
        <tr>
            <td style="width: 200px">
                Load Reference Number:</td>
            <td style="width: 300px">
                <asp:Label ID="LoadReferenceNumberLabel" runat="server"></asp:Label></td>
        </tr>
        <tr>
            <td style="width: 200px">
                Origin:</td>
            <td style="width: 300px">
                <asp:Label ID="OriginLabel" runat="server"></asp:Label></td>
        </tr>
        <tr>
            <td style="width: 200px">
                Destination:</td>
            <td style="width: 300px">
                <asp:Label ID="DestinationLabel" runat="server"></asp:Label></td>
        </tr>
        <tr>
            <td style="width: 200px">
                Scheduled Arrive at Client:</td>
            <td style="width: 300px">
                <asp:Label ID="ArrivalLabel" runat="server"></asp:Label></td>
        </tr>
        <tr>
            <td style="width: 200px">
                Scheduled Depart Budway:</td>
            <td style="width: 300px">
                <asp:Label ID="DepartureLabel" runat="server"></asp:Label></td>
        </tr>
    </table>
    <br />
    <h3>
        Load History</h3>
    <uc1:LoadTrackingUnifiedHistoryControl ID="LoadTrackingUnifiedHistoryControl1" runat="server" />
    <br />
    <h3>
        Load Contents</h3>
    <p>
        <uc2:LoadTrackingUnifiedLoadContentsControl ID="LoadTrackingUnifiedLoadContentsControl1"
            runat="server" />
        &nbsp;</p>
</asp:Content>

