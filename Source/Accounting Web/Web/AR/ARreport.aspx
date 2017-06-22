<%@ Page Language="C#" MasterPageFile="~/Accounting Web.master" AutoEventWireup="true" CodeFile="ARreport.aspx.cs" Inherits="AR_ARreport" Title="AR History" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ExecConnectionString %>"
        SelectCommand="SELECT * FROM [ARhistoryReport] ORDER BY [Date]"></asp:SqlDataSource>
    
</asp:Content>

