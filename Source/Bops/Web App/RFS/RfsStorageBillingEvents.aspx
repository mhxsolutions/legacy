<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="RFS_RfsStorageBillingEvents" Title="BOPS | RFS Storage Billing Events" Codebehind="RfsStorageBillingEvents.aspx.cs" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>RFS Storage Billing Events</h2>
    <asp:GridView ID="_EventsGridview" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Id" DataSourceID="_EventsDatasource" ForeColor="#333333" GridLines="None" AllowPaging="True" PageSize="20">
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                SortExpression="Id">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Event" HeaderText="Event" SortExpression="Event">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="User" HeaderText="User" SortExpression="User">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Item" HeaderText="Item" SortExpression="Item">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
        </Columns>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="_EventsDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [RFS Storage Billing Events].[Storage Event Id] AS Id, [RFS Storage Billing Event Types].Name AS Event, [RFS Storage Billing Events].Timestamp AS Time, [RFS Storage Billing Events].[User Id] AS [User], [RFS Storage Billing Events].[Item Ref] AS Item FROM [RFS Storage Billing Event Types] INNER JOIN [RFS Storage Billing Events] ON [RFS Storage Billing Event Types].[Storage Event Type Id] = [RFS Storage Billing Events].[Event Type Ref]">
    </asp:SqlDataSource>
</asp:Content>
