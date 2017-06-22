<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" 
    Inherits="Customers__All_InvoiceSupportingDocumentsDisplay" Title="BudwayDirect | Invoice Supporting Documents Display Error" 
    CodeBehind="InvoiceSupportingDocumentsDisplay.aspx.cs" CodeFile="InvoiceSupportingDocumentsDisplay.aspx.cs" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Invoice Supporting Documents Display Error</h2>
    <p>Either no supporting documents were available, or an error occurred while attempting to retrieve them. 
    If you believe this to be an error, please contact Budway with the desired invoice number.</p>
    <a href="InvoiceHistory.aspx">Click here to return to the invoice history report.</a>
</asp:Content>
