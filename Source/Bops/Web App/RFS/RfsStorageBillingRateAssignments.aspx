<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="RFS_RfsStorageBillingRateAssignments" Title="BOPS | RFS Storage Rate Assignments" Codebehind="RfsStorageBillingRateAssignments.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h2>RFS Storage Billing Rate Assignments</h2>

    <p>
        <a href="RfsStorageBillingRates.aspx">Click here for the list of storage rates.</a><br />
        <a href="RfsStorageBillingEditAssignment.aspx?Mode=Add">Click here to create a new storage rate assignment.</a>
    </p>
    
    <asp:GridView ID="_AssignmentsGridview" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="AssignmentId" 
        DataSourceID="AssignmentsDatasource" ForeColor="#333333" GridLines="None" AllowSorting="True">
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:BoundField DataField="ID" HeaderText="Rate ID" InsertVisible="False" ReadOnly="True" SortExpression="ID">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:HyperLinkField DataTextField="AssignmentId" HeaderText="Assignment ID" DataNavigateUrlFields="AssignmentId"
                DataNavigateUrlFormatString="RfsStorageBillingEditAssignment.aspx?Mode=Edit&AssignmentId={0}">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" HorizontalAlign="Right" />
            </asp:HyperLinkField>
            <asp:BoundField DataField="Assignment Description" HeaderText="Description" SortExpression="Assignment Description">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="Begin Date" HeaderText="Begin Date" SortExpression="Begin Date" DataFormatString="{0:d}">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="End Date" HeaderText="End Date" SortExpression="End Date" DataFormatString="{0:d}">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Profile ID" HeaderText="Profile ID" InsertVisible="False" ReadOnly="True" SortExpression="Profile ID">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Product Class Description" HeaderText="Profile Description" SortExpression="Product Class Description">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="Receiving Client" HeaderText="Profile Receiving Client" ReadOnly="True" SortExpression="Receiving Client">
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" HorizontalAlign="Left" />
            </asp:BoundField>
            
            <asp:TemplateField ShowHeader="False">
                <EditItemTemplate>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="DeleteRecordLinkButton" runat="server" CausesValidation="False" CommandName="Delete"
                        OnClientClick='return confirm("Are you sure you want to delete the assignment?");' Text="Delete" 
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
    
    <asp:SqlDataSource ID="AssignmentsDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [RFS Storage Rates].[Rate Id] AS ID, [RFS Storage Billing Types].Description AS Type, [DWS Rep Data].dbo.tbldestinationList.Destination + ': ' + [DWS Rep Data].dbo.tbldestinationList.City + ', ' + ISNULL([DWS Rep Data].dbo.tbldestinationList.State, '') AS [Bill-To], [RFS Storage Rates].[Days In Cycle], [RFS Storage Rates].[Unit Cost Per Cycle], CASE WHEN [Unit Ref] = 0 THEN '(none)' WHEN [Unit Ref] = 4 THEN 'Square Feet' WHEN [Unit Ref] = 6 THEN 'Tons' END AS Units, [RFS Storage Rates].Description, [RFS Storage Rate Assignments].[Assignment Id] AS AssignmentId, [RFS Storage Rate Assignments].Description AS [Assignment Description], [RFS Storage Rate Assignments].[Begin Date], [RFS Storage Rate Assignments].[End Date], [Product Profiles].[Profile ID], [Product Profiles].[Product Class Description], tbldestinationList_1.Destination + ': ' + tbldestinationList_1.City + ', ' + ISNULL(tbldestinationList_1.State, '') AS [Receiving Client] FROM [RFS Storage Rates] INNER JOIN [RFS Storage Billing Types] ON [RFS Storage Rates].[Billing Type Ref] = [RFS Storage Billing Types].[Billing Type Id] INNER JOIN [DWS Rep Data].dbo.tbldestinationList ON [RFS Storage Rates].[Bill To Client Ref] = [DWS Rep Data].dbo.tbldestinationList.[Destination id] INNER JOIN [RFS Storage Rate Assignments] ON [RFS Storage Rates].[Rate Id] = [RFS Storage Rate Assignments].[Rate Ref] INNER JOIN [Product Profiles] ON [RFS Storage Rate Assignments].[Profile Ref] = [Product Profiles].[Profile ID] INNER JOIN [DWS Rep Data].dbo.tbldestinationList AS tbldestinationList_1 ON [Product Profiles].[Receiving Client Ref] = tbldestinationList_1.[Destination id] WHERE [RFS Storage Rate Assignments].[Deleted] = 0"
        DeleteCommand="UPDATE [RFS Storage Rate Assignments] SET [Deleted] = 1 WHERE [Assignment Id] = @AssignmentId">
    </asp:SqlDataSource>
    
</asp:Content>
