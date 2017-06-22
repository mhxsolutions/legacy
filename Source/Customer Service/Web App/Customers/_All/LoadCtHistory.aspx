<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_LoadCtHistory" 
    Title="BudwayDirect | Load Count History" CodeBehind="LoadCtHistory.aspx.cs" CodeFile="LoadCtHistory.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Plan Date] AS Plan_Date, [Load Ct] AS Load_Ct FROM [COPSLoadCtReview] WHERE ([Parent ref] = @Parent_ref) ORDER BY [Plan Date]">
        <SelectParameters>
            <asp:SessionParameter Name="Parent_ref" SessionField="CONTEXT_CLIENTID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

