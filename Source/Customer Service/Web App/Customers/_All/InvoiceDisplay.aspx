<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_InvoiceDisplay" 
    Title="BudwayDirect | Invoice Display Error" CodeBehind="InvoiceDisplay.aspx.cs" CodeFile="InvoiceDisplay.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Invoice Display Error</h2>
    <p>An error occurred while attempting to retrieve the invoice. Please contact Budway with the desired invoice number.</p>
    <a href="InvoiceHistory.aspx">Click here to return to the invoice history report.</a>
</asp:Content>