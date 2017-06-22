
<%@ Page Language="C#" MasterPageFile="~/CustomerService.master" AutoEventWireup="true" Inherits="Customers__All_ContainerProjectsSummary" 
    Title="BudwayDirect - Container Projects Summary" CodeBehind="ContainerProjectsSummary.aspx.cs" CodeFile="ContainerProjectsSummary.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Container Projects Summary</h2>

    <asp:GridView ID="_ProjectsGridview" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Project Id" 
        DataSourceID="_SummaryDatasource" ForeColor="#333333" GridLines="None" PageSize="20" EmptyDataText="No container projects were found.">
        <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="Project Id" DataNavigateUrlFormatString="ContainerProjectDetail.aspx?ProjectId={0}" 
                DataTextField="Project Id" HeaderText="Project Id">
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
            </asp:HyperLinkField>
            <asp:BoundField DataField="Booking Id" HeaderText="Booking Id" SortExpression="Booking Id">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Total Containers" HeaderText="Total Containers" SortExpression="Total Containers">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Pickups" HeaderText="Pickups" ReadOnly="True" SortExpression="Pickups">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Returns" HeaderText="Returns" ReadOnly="True" SortExpression="Returns">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Custom Moves" HeaderText="Other" ReadOnly="True" SortExpression="Custom Moves">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Complete" HeaderText="Complete" ReadOnly="True" SortExpression="Complete">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            
        </Columns>
        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="_SummaryDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [CPS Projects].[Project Id], [CPS Projects].[Booking Id], [CPS Projects].Description, [CPS Projects].[Total Containers], SUM(CASE WHEN [Default Origin Ref] = [Origin Ref] THEN 1 ELSE 0 END) AS Pickups, SUM(CASE WHEN [Default Origin Ref] = [Destination Ref] THEN 1 ELSE 0 END) AS [Returns], SUM(CASE WHEN [Default Origin Ref] <> [Origin Ref] AND [Default Origin Ref] <> [Destination Ref] THEN 1 ELSE 0 END) AS [Custom Moves], [CPS Projects].Complete FROM [CPS Projects] INNER JOIN [CPS Movements] ON [CPS Projects].[Project Id] = [CPS Movements].[Project Ref] GROUP BY [CPS Projects].[Project Id], [CPS Projects].[Booking Id], [CPS Projects].Description, [CPS Projects].[Total Containers], [CPS Projects].Complete, [CPS Projects].[Bill To Client Ref] HAVING ([CPS Projects].[Bill To Client Ref] = @ClientId)">
        <SelectParameters>
            <asp:SessionParameter Name="ClientId" SessionField="CONTEXT_CLIENTID" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="_SummaryDatasource" EnableTheming="True" 
        KeyFieldName="Project Id" Theme="Office2003Silver">
        <Columns>
            <dx:GridViewDataHyperLinkColumn FieldName="Project Id" ReadOnly="True" 
                VisibleIndex="0" >
                <PropertiesHyperLinkEdit NavigateUrlFormatString="ContainerProjectDetail.aspx?ProjectId={0}">
                </PropertiesHyperLinkEdit>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataHyperLinkColumn>
            <dx:GridViewDataTextColumn FieldName="Booking Id" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Total Containers" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Pickups" ReadOnly="True" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Returns" ReadOnly="True" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Others" FieldName="Custom Moves" 
                ReadOnly="True" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="Complete" VisibleIndex="7">
            </dx:GridViewDataCheckColumn>
        </Columns>
        <SettingsPager PageSize="30">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings ShowAllItem="True" Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" />
    </dx:ASPxGridView>
    
    <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1" runat="server">
    </dx:ASPxGridViewExporter>
    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
        Text="Export to the Excel" />
    
</asp:Content>
