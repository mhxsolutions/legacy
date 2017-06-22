<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true"
    Inherits="RFS_RfsStorageBillingRates" Title="BOPS | RFS Storage Rates" Codebehind="RfsStorageBillingRates.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h2>
        RFS Storage Billing Rates</h2>
     <p><a href="RfsStorageBillingEditRate.aspx?Mode=Add">Click here to create a new storage rate</a></p>
    <asp:GridView ID="StorageRatesGridview" runat="server" AutoGenerateColumns="False" DataKeyNames="RateId"
        CellPadding="4" DataSourceID="StorageRatesDatasource" ForeColor="#333333" GridLines="None" AllowSorting="True">
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:HyperLinkField DataTextField="RateId" HeaderText="ID" SortExpression="RateId" DataNavigateUrlFields="RateId"
                DataNavigateUrlFormatString="RfsStorageBillingEditRate.aspx?Mode=Edit&amp;RateId={0}">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" HorizontalAlign="Right" />
            </asp:HyperLinkField>
            <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Bill-To" HeaderText="Bill-To" SortExpression="Bill-To">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Days In Cycle" HeaderText="Cycle Days" SortExpression="Days In Cycle">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Unit Cost Per Cycle" HeaderText="Rate / Cycle"
                SortExpression="Unit Cost Per Cycle" DataFormatString="{0:c}">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Units" HeaderText="Units" ReadOnly="True" SortExpression="Units">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" />
            </asp:BoundField>
            <asp:HyperLinkField Text="Assignments" HeaderText="" DataNavigateUrlFields="RateId"
                DataNavigateUrlFormatString="RfsStorageBillingRateAssignments.aspx?RateId={0}">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" HorizontalAlign="Right" />
            </asp:HyperLinkField>
            
            <asp:TemplateField ShowHeader="False">
                <EditItemTemplate>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="DeleteRecordLinkButton" runat="server" CausesValidation="False" CommandName="Delete"
                        OnClientClick='return confirm("Are you sure you want to delete the rate?");' Text="Delete" 
                        ForeColor="controltext" />
                </ItemTemplate>
            </asp:TemplateField>
            
        </Columns>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="StorageRatesDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [RFS Storage Rates].[Rate Id] AS RateId, [RFS Storage Billing Types].Description AS Type, [DWS Rep Data].dbo.tbldestinationList.Destination + ': ' + [DWS Rep Data].dbo.tbldestinationList.City + ', ' + ISNULL([DWS Rep Data].dbo.tbldestinationList.State,'') AS [Bill-To], [RFS Storage Rates].[Days In Cycle], [RFS Storage Rates].[Unit Cost Per Cycle], CASE WHEN [Unit Ref] = 0 THEN '(none)' WHEN [Unit Ref] = 4 THEN 'Square Feet' WHEN [Unit Ref] = 6 THEN 'Tons' END AS Units, [RFS Storage Rates].Description FROM [RFS Storage Rates] INNER JOIN [RFS Storage Billing Types] ON [RFS Storage Rates].[Billing Type Ref] = [RFS Storage Billing Types].[Billing Type Id] INNER JOIN [DWS Rep Data].dbo.tbldestinationList ON [RFS Storage Rates].[Bill To Client Ref] = [DWS Rep Data].dbo.tbldestinationList.[Destination id] WHERE [RFS Storage Rates].[Deleted] = 0"
        DeleteCommand="BopsRfsStorageBillingDeleteRate" DeleteCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="RateId" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
</asp:Content>
