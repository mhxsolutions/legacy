<%@ Page Language="C#" MasterPageFile="~/TubularTransport.master" AutoEventWireup="true" CodeFile="LoadTrackingReportInvalidLoadError.aspx.cs" Inherits="Customers__All_LoadTrackingReportInvalidLoadError" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <span style="color: red">Data could not be found or accessed for load reference: 
    <asp:Label ID="LoadReferenceNumberLabel" runat="server" ForeColor="Red"/>
    </span>
</asp:Content>
