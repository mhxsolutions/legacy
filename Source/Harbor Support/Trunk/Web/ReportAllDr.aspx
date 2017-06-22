<%@ Page Language="C#" MasterPageFile="~/HarborWeb.master" AutoEventWireup="true" CodeFile="ReportAllDr.aspx.cs" Inherits="ReportAllDr" Title="Harbor Web | Report All DR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Report All DR</h2>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" CellPadding="4" DataKeyNames="DRID" DataSourceID="DrDatasource"
        ForeColor="#333333" GridLines="None">
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="DRID" DataNavigateUrlFormatString="EnterDr.aspx?DrId={0}" DataTextField="DRID"
                HeaderText="DRID" SortExpression="DRID" />
            <asp:BoundField DataField="Count" HeaderText="Count" SortExpression="Count" />
            <asp:BoundField DataField="Weight" HeaderText="Weight" SortExpression="Weight" />
            <asp:BoundField DataField="Last Update Time" HeaderText="Last Update Time" SortExpression="Last Update Time" />
            <asp:BoundField DataField="Gate Pass" HeaderText="Gate Pass" SortExpression="Gate Pass" />
            <asp:BoundField DataField="Load Ref" HeaderText="PUR" SortExpression="Load Ref" />
            <asp:BoundField DataField="Tractor" HeaderText="Tractor" SortExpression="Tractor" />
            <asp:BoundField DataField="Finalized" HeaderText="Finalized" SortExpression="Finalized" />
        </Columns>
        <EmptyDataTemplate>
        No DRs have been entered.
        </EmptyDataTemplate>
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="DrDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep Data ConnectionString %>"
        SelectCommand="SELECT * FROM [Hops DR Entry]"></asp:SqlDataSource>
</asp:Content>
