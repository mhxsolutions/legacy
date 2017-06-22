<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true"
    Inherits="RFS_RfsWizardStakeholderReferences" Title="BOPS | RFS Wizard | Stakeholder References" Codebehind="RfsWizardStakeholderReferences.aspx.cs" %>

<%@ Register Assembly="FarPoint.Web.Spread" Namespace="FarPoint.Web.Spread" TagPrefix="FarPoint" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="top-container" style="z-index: 101; left: 0px; width: 1000px;">
        <div id="tabbed-bar">
            <a href="RfsWizardSelect.aspx">Select RFS</a>
            
            <!-- Show the create tab only if the user has advanced permissions -->
            <% if (User.IsInRole("Power Users") || User.IsInRole("Administrators")) { %>
                <a href="RfsWizardCreate.aspx">Create RFS</a>
            <% } %>
            
            <!-- Show the bracketed tabs only if the user has selected/created an RFS. -->
            
            <% if (Session["CONTEXT_RFSID"] != null) { %>
                <a href="RfsWizardMain.aspx">Main</a> <a href="RfsWizardStakeholders.aspx">Stakeholders</a>
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
    <div style="z-index: 103; left: 0px; width: 1000px; top: 10px;">
        <h2>
            References for
            <asp:Label ID="StakeholderDetailsLabel" runat="server" Text="(unknown)"></asp:Label>
        </h2>
        <p>
            Use the following spreadsheet to define stakeholder references. To save a new or
            updated row, click the update button (the check mark) on the spreadsheet toolbar.
            To cancel a new or updated row, click the cancel button (the red 'X') on the spreadsheet
            toolbar. To go back to the main stakeholders page, click the tab at the top.
        </p>
        <asp:SqlDataSource ID="StakeholderReferences" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            DeleteCommand="DELETE FROM [RFS Stakeholder References] WHERE [RFS Reference ID] = @RFS_Reference_ID"
            InsertCommand="INSERT INTO [RFS Stakeholder References] ([Stakeholder ref], [Reference], [Type]) VALUES (@Stakeholder_ref, @Reference, @Type)"
            SelectCommand="SELECT [RFS Reference ID] AS RFS_Reference_ID, [Stakeholder ref] AS Stakeholder_ref, Type, Reference FROM [RFS Stakeholder References] WHERE ([Stakeholder ref] = @Stakeholder_ref)"
            UpdateCommand="UPDATE [RFS Stakeholder References] SET [Reference] = @Reference, [Type] = @Type WHERE [RFS Reference ID] = @RFS_Reference_ID">
            <DeleteParameters>
                <asp:Parameter Name="RFS_Reference_ID" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="Reference" Type="String" />
                <asp:Parameter Name="Type" Type="String" />
                <asp:Parameter Name="RFS_Reference_ID" Type="Int32" />
            </UpdateParameters>
            <SelectParameters>
                <asp:QueryStringParameter DefaultValue="0" Name="Stakeholder_ref" QueryStringField="StakeholderId"
                    Type="Int32" />
            </SelectParameters>
            <InsertParameters>
                <asp:QueryStringParameter Name="Stakeholder_ref" QueryStringField="StakeholderId"
                    Type="Int32" />
                <asp:Parameter Name="Reference" Type="String" />
                <asp:Parameter Name="Type" Type="String" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="StakeholderDetails" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT [RFS Stakeholders].[Stakeholder ID], [RFS Stakeholder Roles].Role AS Role, [DWS Rep Data].dbo.tbldestinationList.Destination AS Client FROM [RFS Stakeholders] INNER JOIN [RFS Stakeholder Roles] ON [RFS Stakeholders].[Role ref] = [RFS Stakeholder Roles].[Role Id] INNER JOIN [DWS Rep Data].dbo.tbldestinationList ON [RFS Stakeholders].[Client ref] = [DWS Rep Data].dbo.tbldestinationList.[Destination id] WHERE ([RFS Stakeholders].[Stakeholder ID] = @StakeholderId)">
            <SelectParameters>
                <asp:QueryStringParameter Name="StakeholderId" QueryStringField="StakeholderId" />
            </SelectParameters>
        </asp:SqlDataSource>
        <FarPoint:FpSpread ID="FpSpread1" runat="server" ActiveSheetViewIndex="0" BorderColor="Black"
            BorderStyle="Solid" BorderWidth="1px" DesignString='<?xml version="1.0" encoding="utf-8"?><Spread />'
            Height="200px" Style="position: absolute" Width="700px" EditModeReplace="True">
            <Sheets>
                <FarPoint:SheetView AutoGenerateColumns="False" DataKeyNames="RFS_Reference_ID" DataSourceID="StakeholderReferences"
                    DesignString="&lt;?xml version=&quot;1.0&quot; encoding=&quot;utf-8&quot;?&gt;&lt;Sheet&gt;&lt;Data&gt;&lt;RowHeader class=&quot;FarPoint.Web.Spread.Model.DefaultSheetDataModel&quot; rows=&quot;3&quot; columns=&quot;1&quot;&gt;&lt;AutoCalculation&gt;True&lt;/AutoCalculation&gt;&lt;AutoGenerateColumns&gt;True&lt;/AutoGenerateColumns&gt;&lt;ReferenceStyle&gt;A1&lt;/ReferenceStyle&gt;&lt;Iteration&gt;False&lt;/Iteration&gt;&lt;MaximumIterations&gt;1&lt;/MaximumIterations&gt;&lt;MaximumChange&gt;0.001&lt;/MaximumChange&gt;&lt;/RowHeader&gt;&lt;ColumnHeader class=&quot;FarPoint.Web.Spread.Model.DefaultSheetDataModel&quot; rows=&quot;1&quot; columns=&quot;4&quot;&gt;&lt;AutoCalculation&gt;True&lt;/AutoCalculation&gt;&lt;AutoGenerateColumns&gt;True&lt;/AutoGenerateColumns&gt;&lt;ReferenceStyle&gt;A1&lt;/ReferenceStyle&gt;&lt;Iteration&gt;False&lt;/Iteration&gt;&lt;MaximumIterations&gt;1&lt;/MaximumIterations&gt;&lt;MaximumChange&gt;0.001&lt;/MaximumChange&gt;&lt;Cells&gt;&lt;Cell row=&quot;0&quot; column=&quot;0&quot;&gt;&lt;Data type=&quot;System.String&quot;&gt;RFS_Reference_ID&lt;/Data&gt;&lt;/Cell&gt;&lt;Cell row=&quot;0&quot; column=&quot;1&quot;&gt;&lt;Data type=&quot;System.String&quot;&gt;Stakeholder_ref&lt;/Data&gt;&lt;/Cell&gt;&lt;Cell row=&quot;0&quot; column=&quot;2&quot;&gt;&lt;Data type=&quot;System.String&quot;&gt;Type&lt;/Data&gt;&lt;/Cell&gt;&lt;/Cells&gt;&lt;/ColumnHeader&gt;&lt;DataArea class=&quot;FarPoint.Web.Spread.Model.DefaultSheetDataModel&quot; rows=&quot;3&quot; columns=&quot;4&quot;&gt;&lt;AutoCalculation&gt;True&lt;/AutoCalculation&gt;&lt;AutoGenerateColumns&gt;False&lt;/AutoGenerateColumns&gt;&lt;DataKeyField class=&quot;System.String[]&quot; assembly=&quot;mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089&quot; encoded=&quot;true&quot;&gt;AAEAAAD/////AQAAAAAAAAARAQAAAAEAAAAGAgAAABBSRlNfUmVmZXJlbmNlX0lECw==&lt;/DataKeyField&gt;&lt;ReferenceStyle&gt;A1&lt;/ReferenceStyle&gt;&lt;Iteration&gt;False&lt;/Iteration&gt;&lt;MaximumIterations&gt;1&lt;/MaximumIterations&gt;&lt;MaximumChange&gt;0.001&lt;/MaximumChange&gt;&lt;SheetName&gt;Sheet1&lt;/SheetName&gt;&lt;RowIndexes class=&quot;System.Collections.ArrayList&quot; assembly=&quot;mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089&quot; encoded=&quot;true&quot;&gt;AAEAAAD/////AQAAAAAAAAAEAQAAABxTeXN0ZW0uQ29sbGVjdGlvbnMuQXJyYXlMaXN0AwAAAAZfaXRlbXMFX3NpemUIX3ZlcnNpb24FAAAICAkCAAAAAwAAAHMBAAAQAgAAAAQAAAAICAAAAAAICAEAAAAICAIAAAAKCw==&lt;/RowIndexes&gt;&lt;Columns&gt;&lt;Column index=&quot;0&quot;&gt;&lt;ColumnInfo&gt;&lt;ColumnName&gt;RFS_Reference_ID&lt;/ColumnName&gt;&lt;/ColumnInfo&gt;&lt;/Column&gt;&lt;Column index=&quot;1&quot;&gt;&lt;ColumnInfo&gt;&lt;ColumnName&gt;Stakeholder_ref&lt;/ColumnName&gt;&lt;/ColumnInfo&gt;&lt;/Column&gt;&lt;Column index=&quot;2&quot;&gt;&lt;ColumnInfo&gt;&lt;ColumnName&gt;Type&lt;/ColumnName&gt;&lt;/ColumnInfo&gt;&lt;/Column&gt;&lt;Column index=&quot;3&quot;&gt;&lt;ColumnInfo&gt;&lt;ColumnName&gt;Reference&lt;/ColumnName&gt;&lt;/ColumnInfo&gt;&lt;/Column&gt;&lt;/Columns&gt;&lt;/DataArea&gt;&lt;/Data&gt;&lt;Presentation&gt;&lt;AxisModels&gt;&lt;Column class=&quot;FarPoint.Web.Spread.Model.DefaultSheetAxisModel&quot; defaultSize=&quot;90&quot; orientation=&quot;Horizontal&quot; count=&quot;4&quot;&gt;&lt;Items&gt;&lt;Item index=&quot;-1&quot;&gt;&lt;Size&gt;90&lt;/Size&gt;&lt;SortIndicator&gt;Ascending&lt;/SortIndicator&gt;&lt;/Item&gt;&lt;/Items&gt;&lt;/Column&gt;&lt;RowHeaderColumn class=&quot;FarPoint.Web.Spread.Model.DefaultSheetAxisModel&quot; defaultSize=&quot;40&quot; orientation=&quot;Horizontal&quot; count=&quot;1&quot;&gt;&lt;Items&gt;&lt;Item index=&quot;-1&quot;&gt;&lt;Size&gt;40&lt;/Size&gt;&lt;SortIndicator&gt;Ascending&lt;/SortIndicator&gt;&lt;/Item&gt;&lt;/Items&gt;&lt;/RowHeaderColumn&gt;&lt;ColumnHeaderRow class=&quot;FarPoint.Web.Spread.Model.DefaultSheetAxisModel&quot; defaultSize=&quot;22&quot; orientation=&quot;Vertical&quot; count=&quot;1&quot;&gt;&lt;Items&gt;&lt;Item index=&quot;-1&quot;&gt;&lt;Size&gt;22&lt;/Size&gt;&lt;/Item&gt;&lt;/Items&gt;&lt;/ColumnHeaderRow&gt;&lt;/AxisModels&gt;&lt;StyleModels&gt;&lt;RowHeader class=&quot;FarPoint.Web.Spread.Model.DefaultSheetStyleModel&quot; Rows=&quot;3&quot; Columns=&quot;1&quot;&gt;&lt;AltRowCount&gt;2&lt;/AltRowCount&gt;&lt;DefaultStyle class=&quot;FarPoint.Web.Spread.NamedStyle&quot; Parent=&quot;HeaderDefault&quot; /&gt;&lt;/RowHeader&gt;&lt;ColumnHeader class=&quot;FarPoint.Web.Spread.Model.DefaultSheetStyleModel&quot; Rows=&quot;1&quot; Columns=&quot;4&quot;&gt;&lt;AltRowCount&gt;2&lt;/AltRowCount&gt;&lt;DefaultStyle class=&quot;FarPoint.Web.Spread.NamedStyle&quot; Parent=&quot;HeaderDefault&quot; /&gt;&lt;/ColumnHeader&gt;&lt;DataArea class=&quot;FarPoint.Web.Spread.Model.DefaultSheetStyleModel&quot; Rows=&quot;3&quot; Columns=&quot;4&quot;&gt;&lt;AltRowCount&gt;2&lt;/AltRowCount&gt;&lt;DefaultStyle class=&quot;FarPoint.Web.Spread.NamedStyle&quot; Parent=&quot;DataAreaDefault&quot; /&gt;&lt;ColumnStyles&gt;&lt;ColumnStyle Index=&quot;0&quot; class=&quot;FarPoint.Web.Spread.StyleInfo&quot;&gt;&lt;CellType class=&quot;FarPoint.Web.Spread.IntegerCellType&quot;&gt;&lt;ErrorMsg&gt;Integer: (ex, 123)&lt;/ErrorMsg&gt;&lt;AllowWrap&gt;False&lt;/AllowWrap&gt;&lt;IsDateFormat&gt;False&lt;/IsDateFormat&gt;&lt;GeneralCellType /&gt;&lt;IntegerCellType /&gt;&lt;/CellType&gt;&lt;/ColumnStyle&gt;&lt;ColumnStyle Index=&quot;1&quot; class=&quot;FarPoint.Web.Spread.StyleInfo&quot;&gt;&lt;CellType class=&quot;FarPoint.Web.Spread.IntegerCellType&quot;&gt;&lt;ErrorMsg&gt;Integer: (ex, 123)&lt;/ErrorMsg&gt;&lt;AllowWrap&gt;False&lt;/AllowWrap&gt;&lt;IsDateFormat&gt;False&lt;/IsDateFormat&gt;&lt;GeneralCellType /&gt;&lt;IntegerCellType /&gt;&lt;/CellType&gt;&lt;/ColumnStyle&gt;&lt;/ColumnStyles&gt;&lt;/DataArea&gt;&lt;/StyleModels&gt;&lt;MessageRowStyle class=&quot;FarPoint.Web.Spread.Appearance&quot;&gt;&lt;BackColor&gt;LightYellow&lt;/BackColor&gt;&lt;ForeColor&gt;Red&lt;/ForeColor&gt;&lt;/MessageRowStyle&gt;&lt;SheetCornerStyle class=&quot;FarPoint.Web.Spread.NamedStyle&quot; Parent=&quot;HeaderDefault&quot; /&gt;&lt;TopRow&gt;0&lt;/TopRow&gt;&lt;/Presentation&gt;&lt;/Sheet&gt;"
                    GroupBarBackColor="LightGray" SheetName="Sheet1" AllowDelete="True" AllowInsert="True"
                    AllowSort="True">
                    <SelectionBorder BorderStyle="NotSet" BorderStyleBottom="NotSet" BorderStyleLeft="NotSet"
                        BorderStyleRight="NotSet" BorderStyleTop="NotSet" />
                    <RowHeader Width="40" />
                </FarPoint:SheetView>
            </Sheets>
            <Tab ActiveCssClass="" CssClass="" />
            <Pager CssClass="" />
        </FarPoint:FpSpread>
    </div>
</asp:Content>
