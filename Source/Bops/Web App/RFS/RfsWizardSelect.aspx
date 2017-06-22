<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="RFS.RFS_RfsSelect" Title="BOPS | RFS Wizard | Select RFS" Codebehind="RfsWizardSelect.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div id="top-container" style="z-index: 101; left: 0px; width: 1000px;">
        <div id="tabbed-bar">
            <a class="selected" href="#">Select RFS</a>
            
            <!-- Show the create tab only if the user has advanced permissions -->
            
            <% if (User.IsInRole("Power Users") || User.IsInRole("Administrators")) { %>
            <a href="RfsWizardCreate.aspx">Create RFS</a>
            <% } %>

            <!-- Show the bracketed tabs only if the user has selected/created an RFS. -->
            
            <% if (Session["CONTEXT_RFSID"] != null) { %>
                <a href="RfsWizardMain.aspx">Main</a>
                <a href="RfsWizardStakeholders.aspx">Stakeholders</a>
                <a href="RfsWizardServices.aspx">Services</a>
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

    <div style="z-index: 104; left: 0px; width: 1000px; top: 10px; position: relative; ">
        <h3>Quick Select</h3>
        <p>To quick-select, enter the number of the RFS and click the "Select" button.</p>
        <asp:TextBox ID="QuickRfsIdTextbox" runat="server" />
        <asp:Button ID="QuickSelectButton" runat="server" Text="Select" OnClick="QuickSelectButton_Click" />

        <h3>Select From List</h3>
        <p>To select an RFS, click its RFS ID number. To filter the RFS list, select the limiting values from the drop down controls 
        at the top of the list. To return to the complete list, click the clear filters button.</p>

        <asp:Table ID="FilterTable" runat="server" CellPadding="3" BackColor="#507CD1">
            <asp:TableRow>
                <asp:TableCell Width="50">
                    <asp:DropDownList ID="RfsIdFilterDropDownList" runat="server" AutoPostBack="true" OnPreRender="DropDownLists_PreRender"
                    DataSourceID="RfsDropDownListData" DataTextField="RFS ID" DataValueField="RFS ID" Width="50"></asp:DropDownList>
                </asp:TableCell>
                <asp:TableCell Width="100">
                    <asp:DropDownList ID="SalespersonFilterDropDownList" runat="server" AutoPostBack="true" OnPreRender="DropDownLists_PreRender"
                    DataSourceID="SalespersonDropDownListData" DataTextField="Salesperson" DataValueField="Salesperson" Width="100"></asp:DropDownList>
                </asp:TableCell>
                <asp:TableCell Width="145">
                    <asp:DropDownList ID="ShipperFilterDropDownList" runat="server" AutoPostBack="true" OnPreRender="DropDownLists_PreRender"
                    DataSourceId="ShipperDropDownListData" DataTextField="Shipper" DataValueField="Shipper" Width="145"></asp:DropDownList>
                </asp:TableCell>
                <asp:TableCell Width="145">
                    <asp:DropDownList ID="VesselFilterDropDownList" runat="server" AutoPostBack="true" OnPreRender="DropDownLists_PreRender"
                    DataSourceId="VesselDropDownListData" DataTextField="Vessel" DataValueField="Vessel" Width="145"></asp:DropDownList>
                </asp:TableCell>
                <asp:TableCell Width="120">
                    <asp:DropDownList ID="CommodityFilterDropDownList" runat="server" AutoPostBack="true" OnPreRender="DropDownLists_PreRender"
                    DataSourceID="CommodityDropDownListData" DataTextField="Commodity" DataValueField="Commodity" Width="120"></asp:DropDownList>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:Button ID="ClearFiltersButton" runat="server" Text="Clear Filters" OnClick="ClearFiltersButton_Click" />
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="RfsListData" 
            ForeColor="#333333" GridLines="None" AllowPaging="True" AllowSorting="True" Font-Names="Verdana" Font-Size="Small" PageSize="50">
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <Columns>
                <asp:HyperLinkField HeaderText="RFS" DataTextField="RFS ID" DataNavigateUrlFields="RFS ID"
                    SortExpression="RFS ID" DataNavigateUrlFormatString="RfsWizardSelectRfsAndForward.aspx?RFSID={0}">
                    <ControlStyle Width="50px" />
                    <HeaderStyle HorizontalAlign="Left" Width="50px" />
                    <ItemStyle VerticalAlign="Top" />
                </asp:HyperLinkField>
                <asp:BoundField DataField="Salesperson" HeaderText="Salesperson" ReadOnly="True" SortExpression="Salesperson">
                    <ItemStyle VerticalAlign="Top" />
                    <ControlStyle Width="100px" />
                    <HeaderStyle HorizontalAlign="Left" Width="100px" />
                </asp:BoundField>
                <asp:BoundField DataField="Shipper" HeaderText="Shipper" SortExpression="Shipper">
                    <ItemStyle VerticalAlign="Top" />
                    <ControlStyle Width="180px" />
                    <HeaderStyle HorizontalAlign="Left" Width="180px" />
                </asp:BoundField>
                <asp:BoundField DataField="Vessel" HeaderText="Vessel" SortExpression="Vessel">
                    <ItemStyle VerticalAlign="Top" />
                    <ControlStyle Width="180px" />
                    <HeaderStyle HorizontalAlign="Left" Width="180px" />
                </asp:BoundField>
                <asp:BoundField DataField="Commodity" HeaderText="Commodity" SortExpression="Commodity">
                    <ItemStyle VerticalAlign="Top" />
                    <ControlStyle Width="130px" />
                    <HeaderStyle HorizontalAlign="Left" Width="130px" />
                </asp:BoundField>
                <asp:BoundField DataField="Location" HeaderText="Location" SortExpression="Location">
                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" Width="80px" />
                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" Width="80px" />
                </asp:BoundField>
                <asp:BoundField DataField="BeginDate" HeaderText="Begins" SortExpression="BeginDate" DataFormatString="{0:MM-dd-yy}" HtmlEncode="False" >
                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" Width="80px" />
                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" Width="80px" />
                </asp:BoundField>
                <asp:BoundField DataField="EndDate" HeaderText="Ends" SortExpression="EndDate" DataFormatString="{0:MM-dd-yy}" HtmlEncode="False" >
                    <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" Width="80px" />
                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" Width="80px" />
                </asp:BoundField>
                <asp:BoundField DataField="Work Description" HeaderText="Work Description" SortExpression="Work Description">
                    <ItemStyle VerticalAlign="Top" />
                    <HeaderStyle HorizontalAlign="Left" Width="200px" />
                </asp:BoundField>
            </Columns>
            <RowStyle BackColor="#EFF3FB" />
            <EditRowStyle BackColor="#2461BF" Font-Size="8pt" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
        
        <asp:SqlDataSource ID="RfsListData" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT [RFS Main].[RFS ID], CAST([RFS Main].[RFS ID] AS VARCHAR(10)) AS RfsIdText, tblDriverList.FirstName + N' ' + tblDriverList.LastName AS Salesperson, [DWS Rep Data].dbo.tbldestinationList.Destination + ': ' + [DWS Rep Data].dbo.tbldestinationList.City + ', ' + ISNULL([DWS Rep Data].dbo.tbldestinationList.State, '') AS Shipper, ISNULL([RFS Main].Vessel, '') AS Vessel, [DWS Rep Data].dbo.[ATSF Product Type].[Product Type] AS Commodity, [RFS Main].[Work Description], [RFS Main].[Begin Date] AS BeginDate, [RFS Main].[End Date] AS EndDate, [RFS Locations].Name AS Location FROM [RFS Main] INNER JOIN tblDriverList ON [RFS Main].[Salesperson ref] = tblDriverList.EmployeeID INNER JOIN [DWS Rep Data].dbo.tbldestinationList ON [RFS Main].[Shipper ref] = [DWS Rep Data].dbo.tbldestinationList.[Destination id] INNER JOIN [DWS Rep Data].dbo.[ATSF Product Type] ON [RFS Main].[Commodity ref] = [DWS Rep Data].dbo.[ATSF Product Type].[ATSF Product ID] INNER JOIN [RFS Locations] ON [RFS Main].[Location Code] = [RFS Locations].[Location Code] ORDER BY [RFS Main].[RFS ID]"
            FilterExpression="RfsIdText LIKE '{0}' AND Salesperson LIKE '{1}' AND Shipper LIKE '{2}' AND Vessel LIKE '{3}' AND Commodity LIKE '{4}'">
            <FilterParameters>
                <asp:ControlParameter Name="RfsId" ControlID="RfsIdFilterDropDownList" PropertyName="SelectedValue" DefaultValue="*" />
                <asp:ControlParameter Name="Salesperson" ControlID="SalespersonFilterDropDownList" PropertyName="SelectedValue" DefaultValue="*" />
                <asp:ControlParameter Name="Shipper" ControlID="ShipperFilterDropDownList" PropertyName="SelectedValue" DefaultValue="*" />
                <asp:ControlParameter Name="Vessel" ControlID="VesselFilterDropDownList" PropertyName="SelectedValue" DefaultValue="*" />
                <asp:ControlParameter Name="Commodity" ControlID="CommodityFilterDropDownList" PropertyName="SelectedValue" DefaultValue="*" />
            </FilterParameters>
        </asp:SqlDataSource>
        <br />
        
        <asp:SqlDataSource ID="RfsDropDownListData" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT DISTINCT [RFS ID] FROM [RFS Main]">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SalesPersonDropDownListData" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT DISTINCT tblDriverList.FirstName + N' ' + tblDriverList.LastName AS Salesperson FROM [RFS Main] INNER JOIN tblDriverList ON [RFS Main].[Salesperson ref] = tblDriverList.EmployeeID">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="ShipperDropDownListData" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT DISTINCT [DWS Rep Data].dbo.tbldestinationList.Destination + ': ' + [DWS Rep Data].dbo.tbldestinationList.City + ', ' + ISNULL([DWS Rep Data].dbo.tbldestinationList.State, '') AS Shipper FROM [RFS Main] INNER JOIN [DWS Rep Data].dbo.tbldestinationList ON [RFS Main].[Shipper ref] = [DWS Rep Data].dbo.tbldestinationList.[Destination id] ORDER BY Shipper">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="VesselDropDownListData" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT DISTINCT Vessel FROM [RFS Main] WHERE Vessel IS NOT NULL AND Vessel <> ''">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="CommodityDropDownListData" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT DISTINCT [DWS Rep Data].dbo.[ATSF Product Type].[Product Type] AS Commodity FROM [RFS Main] INNER JOIN [DWS Rep Data].dbo.[ATSF Product Type] ON [RFS Main].[Commodity ref] = [DWS Rep Data].dbo.[ATSF Product Type].[ATSF Product ID]">
        </asp:SqlDataSource>
        
    </div>
    
</asp:Content>
