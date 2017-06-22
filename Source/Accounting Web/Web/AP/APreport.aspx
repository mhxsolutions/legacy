<%@ Page Language="C#" MasterPageFile="~/Accounting Web.master" AutoEventWireup="true" CodeFile="APreport.aspx.cs" Inherits="AR_APreport" Title="AP Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ExecConnectionString %>"
        SelectCommand="SELECT * FROM [AP History] ORDER BY [AP Date]"></asp:SqlDataSource>
    
</asp:Content>

