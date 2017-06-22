<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="Auditing_AuditRfsWarehouseCalculationResultsResolveNoService" Title="BOPS | Auditing | RFS Warehouse Calculations" Codebehind="AuditRfsWarehouseCalculationResultsResolveNoService.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>RFS Warehouse Calculation Results - No Matching Service</h2>

    <p>
        No matching service means that the RFS revenue calculator could not determine which service should be
        applied to the warehouse document. A service "matches" if it is a warehouse service whose shipper and
        receiver match shipper and receiver of the warehouse document. For receiving documents this is straightforward, 
        because they have a shipper and a receiver; for shipping documents (i.e., bills of lading), the document's 
        shipper is used to match against both the shipper and the receiver in the service.</p>

    <h3>
        Details for <% Response.Write(Request.Params["DocumentType"] == "1" ? "Receiver " : "BOL "); %> <% Response.Write(Request.Params["DocumentId"]); %>
    </h3>

    <p>
        
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CellPadding="4"
            DataSourceID="DocumentDetails" ForeColor="#333333" GridLines="None">
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                    SortExpression="ID">
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Shipper Id" HeaderText="Shipper Id" SortExpression="Shipper Id" >
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Shipper Parent Id" HeaderText="Parent Id" SortExpression="Shipper Parent Id" >
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Parent Shipper" HeaderText="Shipper" SortExpression="Parent Shipper" >
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Receiver Id" HeaderText="Receiver Id" SortExpression="Receiver Id" >
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Receiver Parent Id" HeaderText="Parent Id" SortExpression="Receiver Parent Id" >
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Parent Receiver" HeaderText="Receiver" SortExpression="Parent Receiver" >
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
                No details are available for the warehouse document.
            </EmptyDataTemplate>
        </asp:GridView>
        <asp:SqlDataSource ID="DocumentDetails" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="BopsGetRfsWarehouseDocumentDetails" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:QueryStringParameter Name="DocumentId" QueryStringField="DocumentId" Type="Int32" />
                <asp:QueryStringParameter Name="DocumentType" QueryStringField="DocumentType" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>        

    <h3>Warehouse Services for <a href='../RFS/RfsWizardSelectRfsAndForward.aspx?RFSID=<% Response.Write(Request.Params["RfsId"]); %>&Target=Services'>
    RFS <% Response.Write(Request.Params["RfsId"]); %></a>
    </h3>
        
    <p>
        <asp:GridView ID="GridView1" runat="server" CellPadding="4" DataSourceID="RfsServices"
            ForeColor="#333333" GridLines="None" AutoGenerateColumns="False" DataKeyNames="ServiceId">
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <RowStyle BackColor="#EFF3FB" />
            <EditRowStyle BackColor="#2461BF" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <AlternatingRowStyle BackColor="White" />
            <EmptyDataTemplate>
                No services are available for the RFS.
            </EmptyDataTemplate>
            <Columns>
                <asp:HyperLinkField HeaderText="Service ID" DataTextField="ServiceId" DataNavigateUrlFields="ServiceId,Service Category Ref,RFS Ref"
                    DataNavigateUrlFormatString="~/RFS/RfsWizardRouteServiceRequest.aspx?Mode=Edit&amp;ServiceId={0}&amp;ServiceCategoryId={1}&amp;RfsId={2}"
                    SortExpression="ServiceId" >
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:HyperLinkField>
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" >
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Shipper Id" HeaderText="Shipper Id" SortExpression="Shipper Id" >
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Shipper Parent Id" HeaderText="Parent Id" SortExpression="Shipper Parent Id" >
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Parent Shipper" HeaderText="Shipper" ReadOnly="True"
                    SortExpression="Parent Shipper" >
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Receiver Id" HeaderText="Receiver Id" SortExpression="Receiver Id" >
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Receiver Parent Id" HeaderText="Parent Id" SortExpression="Receiver Parent Id" >
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="Parent Receiver" HeaderText="Receiver" ReadOnly="True"
                    SortExpression="Parent Receiver" >
                    <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="RfsServices" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT [RFS Services Requested].[Service Requested Id] AS ServiceId, [RFS Services Offered].Name, tbldestinationList_1.Destination + ': ' + tbldestinationList_1.City + ', ' + ISNULL(tbldestinationList_1.State, '') AS Shipper, CASE WHEN ISNULL(tbldestinationList_1.[Parent Ref] , 0) > 0 THEN Parent_1.Destination + ': ' + Parent_1.City + ', ' + ISNULL(Parent_1.State , '') ELSE tbldestinationList_1.Destination + ': ' + tbldestinationList_1.City + ', ' + ISNULL(tbldestinationList_1.State , '') END AS [Parent Shipper], tbldestinationList_2.Destination + ': ' + tbldestinationList_2.City + ', ' + ISNULL(tbldestinationList_2.State, '') AS Receiver, CASE WHEN ISNULL(tbldestinationList_2.[Parent Ref] , 0) > 0 THEN Parent_2.Destination + ': ' + Parent_2.City + ', ' + ISNULL(Parent_2.State , '') ELSE tbldestinationList_2.Destination + ': ' + tbldestinationList_2.City + ', ' + ISNULL(tbldestinationList_2.State , '') END AS [Parent Receiver], [RFS Services Offered].[Service Category Ref], [RFS Services Requested].[RFS Ref], tbldestinationList_1.[Destination id] AS [Shipper Id], tbldestinationList_1.[Parent Ref] AS [Shipper Parent Id], tbldestinationList_2.[Destination id] AS [Receiver Id], tbldestinationList_2.[Parent Ref] AS [Receiver Parent Id] FROM [RFS Services Requested] INNER JOIN [RFS Services Offered] ON [RFS Services Requested].[Service Offered Ref] = [RFS Services Offered].[Service Offered Id] INNER JOIN [RFS Cost Methods] ON [RFS Services Requested].[Cost Method Ref] = [RFS Cost Methods].[Cost Method ID] INNER JOIN [RFS Service Categories] ON [RFS Services Offered].[Service Category Ref] = [RFS Service Categories].[Service Category ID] INNER JOIN [RFS Stakeholders] AS [RFS Stakeholders_2] ON [RFS Services Requested].[Receiver Ref] = [RFS Stakeholders_2].[Stakeholder ID] INNER JOIN [sys Units of Measure] ON [RFS Services Requested].[Unit Ref] = [sys Units of Measure].[Unit ID] INNER JOIN [DWS Rep Data].dbo.tbldestinationList AS tbldestinationList_2 ON [RFS Stakeholders_2].[Client ref] = tbldestinationList_2.[Destination id] INNER JOIN [RFS Main] ON [RFS Services Requested].[RFS Ref] = [RFS Main].[RFS ID] INNER JOIN [DWS Rep Data].dbo.tbldestinationList AS tbldestinationList_1 ON [RFS Main].[Shipper ref] = tbldestinationList_1.[Destination id] LEFT OUTER JOIN [DWS Rep Data].dbo.tbldestinationList AS Parent_1 ON tbldestinationList_1.[Parent Ref] = Parent_1.[Destination id] LEFT OUTER JOIN [DWS Rep Data].dbo.tbldestinationList AS Parent_2 ON tbldestinationList_2.[Parent Ref] = Parent_2.[Destination id] WHERE ([RFS Services Requested].[RFS Ref] = @RfsId) AND ([RFS Services Offered].[Service Category Ref] = 2)">
            <SelectParameters>
                <asp:QueryStringParameter Name="RfsId" QueryStringField="RfsId" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>

</asp:Content>
