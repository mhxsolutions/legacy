<%@ Page Title="" Language="C#" MasterPageFile="~/CopsWeb.master" AutoEventWireup="true" CodeBehind="LoadTrackingReport.aspx.cs" 
    Inherits="Web_App.Customers._All.LoadTrackingReport" %>

<%@ Register Src="../../Controls/LoadTrackingUnifiedHistoryControl.ascx" TagName="LoadTrackingUnifiedHistoryControl" TagPrefix="uc1" %>
<%@ Register Src="../../Controls/LoadTrackingUnifiedLoadContentsControl.ascx" TagName="LoadTrackingUnifiedLoadContentsControl" TagPrefix="uc2" %>

<asp:Content ID="LoadContentsTable" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <h2>
        <asp:Literal ID="Literal1" runat="server" Text="Load Tracking Report"/>
    </h2>

    <h3>
        General Information
    </h3>
    
    <%-- TODO: Figure out why the table formatting doesn't work --%>

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
        Load History
    </h3>

    <uc1:LoadTrackingUnifiedHistoryControl ID="LoadTrackingUnifiedHistoryControl1" runat="server" />

    <br />

    <h3>
        Load Contents
    </h3>

    <p>
        <uc2:LoadTrackingUnifiedLoadContentsControl ID="LoadTrackingUnifiedLoadContentsControl1" runat="server" />
    </p>

</asp:Content>
