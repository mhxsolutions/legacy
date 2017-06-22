<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="RFS_RfsWizardServices" Title="BOPS | RFS Wizard | Services" Codebehind="RfsWizardServices.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div id="top-container" style="z-index: 101; left: 0px; width: 1000px;">
        <div id="tabbed-bar">
            <a href="RfsWizardSelect.aspx">Select RFS</a>

            <!-- Show the create tab only if the user has advanced permissions -->
            
            <% if (User.IsInRole("Power Users") || User.IsInRole("Administrators")) { %>
            <a href="RfsWizardCreate.aspx">Create RFS</a>
            <% } %>
            
            <!-- Show the bracketed tabs only if the user has selected/created an RFS. -->
            
            <% if (Session["CONTEXT_RFSID"] != null) { %>
                <a href="RfsWizardMain.aspx">Main</a>
                <a href="RfsWizardStakeholders.aspx">Stakeholders</a>
                <a class="selected" href="RfsWizardServices.aspx">Services</a>
            <% } %>
            
            <!-- Show the tools tab only if the user has selected/created an RFS and has advanced permissions -->
            
            <% if ((Session["CONTEXT_RFSID"] != null) && (User.IsInRole("Power Users") || User.IsInRole("Administrators"))) { %>
            <a href="RfsWizardTools.aspx">Tools</a>
            <% } %>
            
            <a href="RfsWizardHelp.aspx">Help Me!</a>
        </div>
    </div>

    <div style="z-index: 102; left: 0px; width: 1000px;">
        <div id="topbar">
            <div style="left: 0px; top: 5px; position: relative">
                <asp:Label ID="SelectedRfsLabel" runat="server" Text=""></asp:Label>            
            </div>
        </div>
    </div>

    <div style="z-index: 103; left: 0px; width: 1000px; top: 10px;">
    
        <h2>Services</h2>
        <p>In the following table, the cost information displayed is for the public rate, not private.</p>        
        <asp:GridView ID="ServicesGridview" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="ServiceId"
            DataSourceID="ServicesSummary" ForeColor="#333333" GridLines="None" AllowSorting="True" Font-Names="Verdana" Font-Size="Small">
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White"/>
            <RowStyle BackColor="#EFF3FB" />
            <EditRowStyle BackColor="#2461BF" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="ServiceId" HeaderText="Service ID" SortExpression="ServiceId" >
                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                    <ItemStyle VerticalAlign="Top" />
                </asp:BoundField>
                <asp:BoundField DataField="Service Group" HeaderText="Group" SortExpression="Service Group">
                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                    <ItemStyle VerticalAlign="Top" />
                </asp:BoundField>
                <asp:BoundField DataField="Service Category" HeaderText="Service Category" SortExpression="Service Category" >
                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                    <ItemStyle VerticalAlign="Top" />
                </asp:BoundField>
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" >
                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                    <ItemStyle VerticalAlign="Top" />
                </asp:BoundField>
                <asp:BoundField DataField="Origin" HeaderText="Origin" SortExpression="Origin" >
                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                    <ItemStyle VerticalAlign="Top" />
                </asp:BoundField>
                <asp:BoundField DataField="Destination" HeaderText="Destination" SortExpression="Destination" >
                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                    <ItemStyle VerticalAlign="Top" />
                </asp:BoundField>
                <asp:BoundField DataField="Cost Method" HeaderText="Cost Method" SortExpression="Cost Method" >
                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                    <ItemStyle VerticalAlign="Top" />
                </asp:BoundField>
                <asp:BoundField DataField="Cost" HeaderText="Cost" ReadOnly="True" SortExpression="Cost" >
                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                    <ItemStyle VerticalAlign="Top" />
                </asp:BoundField>
                <asp:BoundField DataField="Throughput" HeaderText="Throughput" SortExpression="Throughput" DataFormatString="{0:c}" HtmlEncode="False" >
                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                    <ItemStyle VerticalAlign="Top" />
                </asp:BoundField>
                <asp:BoundField DataField="Revenue" HeaderText="Revenue" SortExpression="Revenue" DataFormatString="{0:c}" HtmlEncode="False" >
                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                    <ItemStyle VerticalAlign="Top" />
                </asp:BoundField>
                <asp:BoundField DataField="Minutes" HeaderText="Minutes" SortExpression="Minutes" >
                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                    <ItemStyle VerticalAlign="Top" />
                </asp:BoundField>
                <asp:HyperLinkField DataTextField="EditLink" DataNavigateUrlFields="ServiceCategoryId,ServiceId"
                    DataNavigateUrlFormatString="RfsWizardRouteServiceRequest.aspx?mode=Edit&amp;ServiceCategoryId={0}&amp;ServiceId={1}" >
                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                    <ItemStyle VerticalAlign="Top" />
                </asp:HyperLinkField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="DeleteService" runat="server" OnClientClick="return confirm('Are you sure you want to delete the service?');"
                            CommandName="Delete">Delete
                        </asp:LinkButton>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                    <ItemStyle VerticalAlign="Top" />
                </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
                <p>No services are available for the RFS.</p>
            </EmptyDataTemplate>
        </asp:GridView>
        
        <asp:SqlDataSource ID="ServicesSummary" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT [RFS Service Categories].[Service Category], [RFS Services Offered].Name, tbldestinationList_1.Destination + ': ' + tbldestinationList_1.City + ', ' + ISNULL(tbldestinationList_1.State, '') AS Origin, CASE [RFS Services Requested].[Indeterminate Destination] WHEN 0 THEN tbldestinationList_2.Destination + ': ' + tbldestinationList_2.City + ', ' + ISNULL(tbldestinationList_2.State , '') ELSE '(indeterminate)' END AS Destination, [RFS Cost Methods].[Cost Method], CASE [RFS Services Requested].[Public Cost Method Ref] WHEN 1 THEN '$' + CAST([RFS Services Requested].[Public Cost] AS VARCHAR) WHEN 2 THEN '$' + CAST([RFS Services Requested].[Public Cost] AS VARCHAR) + ' / ' + [Unit] WHEN 3 THEN 'Matrix: ' + ISNULL([RFS Cost Matrices].[Name] , '(matrix not specified)') WHEN 4 THEN '$' + CAST([RFS Services Requested].[Public Cost] AS VARCHAR) + ' / ' + [Public Special Unit Text] END AS Cost, 'Edit' AS EditLink, [RFS Services Requested].[Service Requested Id] AS ServiceId, [RFS Services Requested].[Service Group], [RFS Services Offered].[Service Category Ref] AS ServiceCategoryId, [RFS Services Requested].[Public Estimated Throughput] AS Throughput, [RFS Services Requested].[Public Estimated Revenue] AS Revenue, [RFS Services Requested].[Estimated Minutes] AS Minutes FROM [RFS Services Requested] INNER JOIN [RFS Services Offered] ON [RFS Services Requested].[Service Offered Ref] = [RFS Services Offered].[Service Offered Id] INNER JOIN [RFS Cost Methods] ON [RFS Services Requested].[Public Cost Method Ref] = [RFS Cost Methods].[Cost Method ID] INNER JOIN [RFS Service Categories] ON [RFS Services Offered].[Service Category Ref] = [RFS Service Categories].[Service Category ID] LEFT OUTER JOIN [RFS Stakeholders] AS [RFS Stakeholders_1] ON [RFS Services Requested].[Origin Ref] = [RFS Stakeholders_1].[Stakeholder ID] LEFT OUTER JOIN [RFS Stakeholders] AS [RFS Stakeholders_2] ON [RFS Services Requested].[Destination Ref] = [RFS Stakeholders_2].[Stakeholder ID] LEFT OUTER JOIN [DWS Rep Data].dbo.tbldestinationList AS tbldestinationList_1 ON [RFS Stakeholders_1].[Client ref] = tbldestinationList_1.[Destination id] LEFT OUTER JOIN [sys Units of Measure] ON [RFS Services Requested].[Public Unit Ref] = [sys Units of Measure].[Unit ID] LEFT OUTER JOIN [DWS Rep Data].dbo.tbldestinationList AS tbldestinationList_2 ON [RFS Stakeholders_2].[Client ref] = tbldestinationList_2.[Destination id] LEFT OUTER JOIN [RFS Cost Matrices] ON [RFS Services Requested].[Public Cost Matrix Ref] = [RFS Cost Matrices].[Matrix Id] WHERE ([RFS Services Requested].[RFS Ref] = @RfsId) ORDER BY [RFS Services Requested].[Service Group]"
            DeleteCommand="DELETE FROM [RFS Services Requested] WHERE [Service Requested Id] = @ServiceId">
            <SelectParameters>
                <asp:SessionParameter Name="RfsId" SessionField="CONTEXT_RFSID" />
            </SelectParameters>
            <DeleteParameters>
                <asp:Parameter Name="ServiceId" />
            </DeleteParameters>
        </asp:SqlDataSource>

        <asp:LoginView ID="LoginView1" runat="server">
            <LoggedInTemplate>
            </LoggedInTemplate>
            <RoleGroups>
                <asp:RoleGroup Roles="Administrators,Power Users">
                <ContentTemplate>
                <h3>Adding New Services</h3>
                <p>
                    If the RFS has the proper stakeholders, new services may be added using the links that follow. Assessorial services
                    require that the RFS have a bill-to stakeholder, warehouse services require bill-to and receiver stakeholders, and
                    transportation services require bill-to, receiver, origin, and destination stakeholders.
                </p>
                <asp:HyperLink ID="AddTransportationHyperlink" runat="server" NavigateUrl="RfsWizardRequestTransporation.aspx?mode=Add"
                    Text="Click here to add a new transportation service" /><br />
                <asp:HyperLink ID="AddWarehouseHyperlink" runat="server" NavigateUrl="RfsWizardRequestWarehouse.aspx?mode=Add"
                    Text="Click here to add a new warehouse service" /><br />
                <asp:HyperLink ID="AddAssessorialHyperlink" runat="server" NavigateUrl="RfsWizardRequestAssessorial.aspx?mode=Add"
                    Text="Click here to add a new assessorial service" /><br />
                </ContentTemplate>
            </asp:RoleGroup>
            </RoleGroups>
        </asp:LoginView>
    
    </div>

</asp:Content>
