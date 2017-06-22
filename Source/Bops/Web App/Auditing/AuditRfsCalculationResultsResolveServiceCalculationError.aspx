<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="Auditing_AuditRfsCalculationResultsResolveServiceCalculationError" Title="BOPS | Auditing | RFS Calculations | Service Calculation Error" Codebehind="AuditRfsCalculationResultsResolveServiceCalculationError.aspx.cs" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h2>
        RFS Calculation Results - Service Calculation Error</h2>
    <p>
        A service calculation error means that the RFS revenue calculator could not calculate
        the revenue from the supplied transportation service parameters. The list of services and 
        the specific reasons for failure are listed below.
    </p>
    
    <h3>Details for <a href="http://budwaydirect.com/CopsWeb/Customers/_All/LoadTrackingReport.aspx?LoadRef=<% Response.Write(Request.Params["DocumentId"]); %>">
    Load <% Response.Write(Request.Params["DocumentId"]); %>
    </a>
    </h3>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
        DataSourceID="ServiceCalculationResultsDatasource" ForeColor="#333333" GridLines="None">
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:HyperLinkField HeaderText="Service Id" DataTextField="Service Ref" DataNavigateUrlFields="RfsId,ServiceCategoryId,Service Ref"
                DataNavigateUrlFormatString="AuditForwardToEditRfsService.aspx?RfsId={0}&amp;ServiceCategoryId={1}&amp;ServiceId={2}" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle VerticalAlign="Top" HorizontalAlign="Left" />
            </asp:HyperLinkField>
            <asp:BoundField DataField="Public Result" HeaderText="Public Result" SortExpression="Public Result" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Public FSC Result" HeaderText="Public FSC Result" SortExpression="Public FSC Result" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Public Revenue" HeaderText="Public Revenue" SortExpression="Public Revenue" DataFormatString="{0:c}" HtmlEncode="False" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Public FSC Revenue" HeaderText="Public FSC Revenue" SortExpression="Public FSC Revenue" DataFormatString="{0:c}" HtmlEncode="False" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Private Result" HeaderText="Private Result" SortExpression="Private Result" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Private FSC Result" HeaderText="Private FSC Result" SortExpression="Private FSC Result" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Private Revenue" HeaderText="Private Revenue" SortExpression="Private Revenue" DataFormatString="{0:c}" HtmlEncode="False" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Private FSC Revenue" HeaderText="Private FSC Revenue"
                SortExpression="Private FSC Revenue" DataFormatString="{0:c}" HtmlEncode="False" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
        </Columns>
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="ServiceCalculationResultsDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [RFS Service Calculation Results].[Service Ref], [RFS Calculation Result Types].Description AS [Public Result], [FSC Calculation Result Types].Description AS [Public FSC Result], [RFS Service Calculation Results].[Public RFS Revenue] AS [Public Revenue], [RFS Service Calculation Results].[Public FSC Revenue], [RFS Calculation Result Types_1].Description AS [Private Result], [FSC Calculation Result Types_1].Description AS [Private FSC Result], [RFS Service Calculation Results].[Private RFS Revenue] AS [Private Revenue], [RFS Service Calculation Results].[Private FSC Revenue], [RFS Services Requested].[RFS Ref] AS RfsId, [RFS Services Offered].[Service Category Ref] AS ServiceCategoryId FROM [RFS Calculation Result Types] INNER JOIN [RFS Service Calculation Results] ON [RFS Calculation Result Types].[RFS Calculation Result Type ID] = [RFS Service Calculation Results].[Public RFS Result Type] INNER JOIN [FSC Calculation Result Types] ON [RFS Service Calculation Results].[Public FSC Result Type] = [FSC Calculation Result Types].[FSC Calculation Result Type ID] INNER JOIN [RFS Services Requested] ON [RFS Service Calculation Results].[Service Ref] = [RFS Services Requested].[Service Requested Id] INNER JOIN [RFS Services Offered] ON [RFS Services Requested].[Service Offered Ref] = [RFS Services Offered].[Service Offered Id] INNER JOIN [RFS Calculation Result Types] AS [RFS Calculation Result Types_1] ON [RFS Service Calculation Results].[Private RFS Result Type] = [RFS Calculation Result Types_1].[RFS Calculation Result Type ID] INNER JOIN [FSC Calculation Result Types] AS [FSC Calculation Result Types_1] ON [RFS Service Calculation Results].[Private FSC Result Type] = [FSC Calculation Result Types_1].[FSC Calculation Result Type ID] WHERE ([RFS Service Calculation Results].[Load] = @LoadRef)">
        <SelectParameters>
            <asp:QueryStringParameter Name="LoadRef" QueryStringField="DocumentId" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
