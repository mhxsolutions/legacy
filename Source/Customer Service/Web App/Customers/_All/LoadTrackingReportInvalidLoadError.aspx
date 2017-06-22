<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_LoadTrackingReportInvalidLoadError" 
    Title="Load Tracking Report Invalid Load Error" CodeBehind="LoadTrackingReportInvalidLoadError.aspx.cs" CodeFile="LoadTrackingReportInvalidLoadError.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <span style="color: red">Data could not be found or accessed for load reference: 
    <asp:Label ID="LoadReferenceNumberLabel" runat="server" ForeColor="Red"/>
    </span>
</asp:Content>
