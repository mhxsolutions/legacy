<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Web.Clients.Assigned.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="contentDiv">
        <h2>Custom Reports</h2>
        <dx:ASPxGridView ID="grdReports" runat="server" DataSourceID="_CustomReportsDatasource" Width="75%" AutoGenerateColumns="False">
            <SettingsSearchPanel Visible="False"></SettingsSearchPanel>
            <Settings ShowFilterRow="False"></Settings>
            <Columns>
                <dx:GridViewDataTextColumn FieldName="Title" VisibleIndex="1"></dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Description" Caption="Description" VisibleIndex="2"></dx:GridViewDataTextColumn>
                <dx:GridViewDataHyperLinkColumn FieldName="URL" Caption="Link" PropertiesHyperLinkEdit-NavigateUrlFormatString="~/{0}" PropertiesHyperLinkEdit-Text="Link" VisibleIndex="3"></dx:GridViewDataHyperLinkColumn>
            </Columns>
        </dx:ASPxGridView>


        <asp:SqlDataSource ID="_CustomReportsDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT [SCM Assignable Reports].[Report Id], [SCM Assignable Reports].Title, [SCM Assignable Reports].Description, [SCM Assignable Reports].URL, [SCM Report Assignments].[Client Id], [DWS Rep Data].dbo.tbldestinationList.Destination FROM [SCM Assignable Reports] INNER JOIN [SCM Report Assignments] ON [SCM Assignable Reports].[Report Id] = [SCM Report Assignments].[Assignable Report Ref] INNER JOIN [DWS Rep Data].dbo.tbldestinationList ON [SCM Report Assignments].[Client Id] = [DWS Rep Data].dbo.tbldestinationList.[Destination id] WHERE (@ContextUserId = 166073081) OR ([SCM Report Assignments].[Client Id] = @ContextUserId) OR (@ContextUserId = 2145260460) ORDER BY [SCM Assignable Reports].Title">
            <SelectParameters>
                <asp:SessionParameter Name="ContextUserId" SessionField="CONTEXT_CLIENTID" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>
