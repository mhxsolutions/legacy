<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="Auditing_AuditRfsCalculationResultsResolveNoService" Title="BOPS | Auditing | RFS Calculations | No Matching Service" Codebehind="AuditRfsCalculationResultsResolveNoService.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h2>RFS Load Calculation Results - No Matching Service</h2>

    <p>
        No matching service means that the RFS revenue calculator could not determine which service should be
        applied to the load. A service "matches" if it is a transportation service whose origin matches the
        load origin and either (1) the service is marked as having an indeterminate destination or (2) the 
        service destination matches the load destination.
    </p>

    <h3>Details for <a href="http://budwaydirect.com/CopsWeb/Customers/_All/LoadTrackingReport.aspx?LoadRef=<% Response.Write(Request.Params["DocumentId"]); %>">
    Load <% Response.Write(Request.Params["DocumentId"]); %>
    </a>
    </h3>

    <p>
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CellPadding="4"
            DataSourceID="LoadDetails" ForeColor="#333333" GridLines="None">
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <Columns>
                <asp:HyperLinkField HeaderText="Load" DataTextField="Load" DataNavigateUrlFields="Load"
                    DataNavigateUrlFormatString="http://budwaydirect.com/CopsWeb/Customers/_All/LoadTrackingReport.aspx?LoadRef={0}" >
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:HyperLinkField>
                <asp:BoundField DataField="Origin Id" HeaderText="Origin Id" SortExpression="Origin Id" >
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Origin Parent Id" HeaderText="Parent Id" SortExpression="Origin Parent Id" >
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Parent Origin" HeaderText="Origin" SortExpression="Origin" >
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Destination Id" HeaderText="Destination Id" SortExpression="Destination Id" >
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Destination Parent Id" HeaderText="Parent Id" SortExpression="Destination Parent Id" >
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Parent Destination" HeaderText="Destination" SortExpression="Destination" >
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
            </Columns>
            <RowStyle BackColor="#EFF3FB" />
            <EditRowStyle BackColor="#2461BF" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <AlternatingRowStyle BackColor="White" />
            <EmptyDataTemplate>
                No details are available for the load.
            </EmptyDataTemplate>
        </asp:GridView>
        <asp:SqlDataSource ID="LoadDetails" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT tblPoscoLoads.[Load], tbldestinationList_1.Destination + ': ' + tbldestinationList_1.City + ', ' + ISNULL(tbldestinationList_1.State, '') AS Origin, tbldestinationList_2.Destination + ': ' + tbldestinationList_2.City + ', ' + ISNULL(tbldestinationList_2.State, '') AS Destination, CASE WHEN ISNULL(tbldestinationList_1.[Parent Ref] , 0) > 0 THEN Parent_1.Destination + ': ' + Parent_1.City + ', ' + ISNULL(Parent_1.State , '') ELSE tbldestinationList_1.Destination + ': ' + tbldestinationList_1.City + ', ' + ISNULL(tbldestinationList_1.State , '') END AS [Parent Origin], CASE WHEN ISNULL(tbldestinationList_2.[Parent Ref] , 0) > 0 THEN Parent_2.Destination + ': ' + Parent_2.City + ', ' + ISNULL(Parent_2.State , '') ELSE tbldestinationList_2.Destination + ': ' + tbldestinationList_2.City + ', ' + ISNULL(tbldestinationList_2.State , '') END AS [Parent Destination], tbldestinationList_1.[Destination id] AS [Origin Id], tbldestinationList_1.[Parent Ref] AS [Origin Parent Id], tbldestinationList_2.[Destination id] AS [Destination Id], tbldestinationList_2.[Parent Ref] AS [Destination Parent Id] FROM tblPoscoLoads INNER JOIN [DWS Rep Data].dbo.tbldestinationList AS tbldestinationList_1 ON tblPoscoLoads.Origin = tbldestinationList_1.[Destination id] INNER JOIN [DWS Rep Data].dbo.tbldestinationList AS tbldestinationList_2 ON tblPoscoLoads.DeliveryLocation = tbldestinationList_2.[Destination id] LEFT OUTER JOIN [DWS Rep Data].dbo.tbldestinationList AS Parent_1 ON tbldestinationList_1.[Parent Ref] = Parent_1.[Destination id] LEFT OUTER JOIN [DWS Rep Data].dbo.tbldestinationList AS Parent_2 ON tbldestinationList_2.[Parent Ref] = Parent_2.[Destination id] WHERE (tblPoscoLoads.[Load] = @LoadRef)">
            <SelectParameters>
                <asp:QueryStringParameter Name="LoadRef" QueryStringField="DocumentId" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>        

    <h3>Transportation Services for <a href="../RFS/RfsWizardSelectRfsAndForward.aspx?RFSID=<% Response.Write(Request.Params["RfsId"]); %>&amp;Target=Services">
    RFS <% Response.Write(Request.Params["RfsId"]); %></a>
    </h3>
        
    <p>
        <asp:GridView ID="GridView1" runat="server" CellPadding="4" DataSourceID="RfsServices"
            ForeColor="#333333" GridLines="None" AutoGenerateColumns="False">
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <RowStyle BackColor="#EFF3FB" />
            <EditRowStyle BackColor="#2461BF" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:HyperLinkField HeaderText="Service ID" DataTextField="ServiceId" DataNavigateUrlFields="ServiceId,Service Category Ref,RFS Ref"
                    DataNavigateUrlFormatString="~/RFS/RfsWizardRouteServiceRequest.aspx?Mode=Edit&amp;ServiceId={0}&amp;ServiceCategoryId={1}&amp;RfsId={2}"
                    SortExpression="ServiceId" >
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:HyperLinkField>
                <asp:BoundField DataField="Origin Id" HeaderText="Origin Id" SortExpression="Origin Id" >
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Origin Parent Id" HeaderText="Parent Id" SortExpression="Origin Parent Id" >
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Parent Origin" HeaderText="Origin" SortExpression="Parent Origin" >
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Destination Id" HeaderText="Destination Id" SortExpression="Destination Id" >
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Destination Parent Id" HeaderText="Parent Id" SortExpression="Destination Parent Id" >
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Parent Destination" HeaderText="Destination" SortExpression="Parent Destination" >
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
            </Columns>
            <EmptyDataTemplate>
                No services are available for the RFS.
            </EmptyDataTemplate>
        </asp:GridView>
        <asp:SqlDataSource ID="RfsServices" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT [RFS Services Requested].[Service Requested Id] AS ServiceId, [RFS Services Offered].Name, tbldestinationList_1.Destination + ': ' + tbldestinationList_1.City + ', ' + ISNULL(tbldestinationList_1.State, '') AS Origin, CASE WHEN ISNULL(tbldestinationList_1.[Parent Ref] , 0) > 0 THEN Parent_1.Destination + ': ' + Parent_1.City + ', ' + ISNULL(Parent_1.State , '') ELSE tbldestinationList_1.Destination + ': ' + tbldestinationList_1.City + ', ' + ISNULL(tbldestinationList_1.State , '') END AS [Parent Origin], CASE WHEN [Indeterminate Destination] = 0 THEN tbldestinationList_2.Destination + ': ' + tbldestinationList_2.City + ', ' + ISNULL(tbldestinationList_2.State , '') ELSE '(indeterminate)' END AS Destination, CASE WHEN [Indeterminate Destination] = 0 THEN CASE WHEN ISNULL(tbldestinationList_2.[Parent Ref] , 0) > 0 THEN Parent_2.Destination + ': ' + Parent_2.City + ', ' + ISNULL(Parent_2.State , '') ELSE tbldestinationList_2.Destination + ': ' + tbldestinationList_2.City + ', ' + ISNULL(tbldestinationList_2.State , '') END ELSE '(indeterminate)' END AS [Parent Destination], [RFS Services Offered].[Service Category Ref], [RFS Services Requested].[RFS Ref], tbldestinationList_1.[Destination id] AS [Origin Id], tbldestinationList_1.[Parent Ref] AS [Origin Parent Id], tbldestinationList_2.[Destination id] AS [Destination Id], tbldestinationList_2.[Parent Ref] AS [Destination Parent Id] FROM [RFS Services Requested] INNER JOIN [RFS Services Offered] ON [RFS Services Requested].[Service Offered Ref] = [RFS Services Offered].[Service Offered Id] INNER JOIN [RFS Cost Methods] ON [RFS Services Requested].[Cost Method Ref] = [RFS Cost Methods].[Cost Method ID] INNER JOIN [RFS Service Categories] ON [RFS Services Offered].[Service Category Ref] = [RFS Service Categories].[Service Category ID] INNER JOIN [RFS Stakeholders] AS [RFS Stakeholders_1] ON [RFS Services Requested].[Origin Ref] = [RFS Stakeholders_1].[Stakeholder ID] INNER JOIN [RFS Stakeholders] AS [RFS Stakeholders_2] ON [RFS Services Requested].[Destination Ref] = [RFS Stakeholders_2].[Stakeholder ID] INNER JOIN [DWS Rep Data].dbo.tbldestinationList AS tbldestinationList_1 ON [RFS Stakeholders_1].[Client ref] = tbldestinationList_1.[Destination id] INNER JOIN [sys Units of Measure] ON [RFS Services Requested].[Unit Ref] = [sys Units of Measure].[Unit ID] INNER JOIN [DWS Rep Data].dbo.tbldestinationList AS tbldestinationList_2 ON [RFS Stakeholders_2].[Client ref] = tbldestinationList_2.[Destination id] LEFT OUTER JOIN [DWS Rep Data].dbo.tbldestinationList AS Parent_1 ON tbldestinationList_1.[Parent Ref] = Parent_1.[Destination id] LEFT OUTER JOIN [DWS Rep Data].dbo.tbldestinationList AS Parent_2 ON tbldestinationList_2.[Parent Ref] = Parent_2.[Destination id] WHERE ([RFS Services Requested].[RFS Ref] = @RfsId) AND ([RFS Services Offered].[Service Category Ref] = 1)">
            <SelectParameters>
                <asp:QueryStringParameter Name="RfsId" QueryStringField="RfsId" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>

</asp:Content>
