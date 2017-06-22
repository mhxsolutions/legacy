<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_loadctreview" 
    Title="BudwayDirect | Load Count" CodeBehind="loadctreview.aspx.cs" CodeFile="loadctreview.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>
        Load Count Review</h2>
    <br />
    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Plan Date] AS Plan_Date, [Load Ct] AS Load_Ct FROM [COPSLoadCtReview] WHERE ([Parent ref] = @Parent_ref) ORDER BY [Plan Date], [Parents Name]">
        <SelectParameters>
            <asp:SessionParameter Name="Parent_ref" SessionField="CONTEXT_CLIENTID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

