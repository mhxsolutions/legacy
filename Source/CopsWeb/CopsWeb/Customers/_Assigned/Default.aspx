<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Web_App.Customers._Assigned.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Custom Reports</h2>
    <div class="contentDiv">
        <asp:GridView ID="_GridView1" runat="server" BackColor="White" BorderColor="#CC9966" Width="98%"
            BorderStyle="None" BorderWidth="1px" CellPadding="4" AutoGenerateColumns="False" DataSourceID="_CustomReportsDatasource">
            <RowStyle BackColor="White" ForeColor="Black" HorizontalAlign="Left" VerticalAlign="Top" />
            <FooterStyle BackColor="White" ForeColor="Black" />
            <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
            <HeaderStyle BackColor="#660000" Font-Bold="True" ForeColor="White" />
            <EmptyDataTemplate>
                <p>Sorry, there are no custom reports available for this user account.</p>
            </EmptyDataTemplate>
            <Columns>
                <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                <asp:HyperLinkField Text="Link" DataNavigateUrlFields="URL" DataNavigateUrlFormatString="~/{0}" />
                <asp:BoundField DataField="Report Id" HeaderText="Report Id" InsertVisible="False" ReadOnly="True" SortExpression="Report Id" />
                <asp:BoundField DataField="Client Id" HeaderText="Client Id" SortExpression="Client Id" />
                <asp:BoundField DataField="Destination" HeaderText="Destination" SortExpression="Destination" />
            </Columns>
        </asp:GridView>

        <asp:SqlDataSource ID="_CustomReportsDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT [Cops Assignable Reports].[Report Id], [Cops Assignable Reports].Title, [Cops Assignable Reports].Description, [Cops Assignable Reports].URL, [Cops Report Assignments].[Client Id], [DWS Rep Data].dbo.tbldestinationList.Destination FROM [Cops Assignable Reports] INNER JOIN [Cops Report Assignments] ON [Cops Assignable Reports].[Report Id] = [Cops Report Assignments].[Assignable Report Ref] INNER JOIN [DWS Rep Data].dbo.tbldestinationList ON [Cops Report Assignments].[Client Id] = [DWS Rep Data].dbo.tbldestinationList.[Destination id] WHERE (@ContextUserId = 166073081) OR ([Cops Report Assignments].[Client Id] = @ContextUserId) OR (@ContextUserId = 2145260460) ORDER BY [Cops Assignable Reports].Title">
            <SelectParameters>
                <asp:SessionParameter Name="ContextUserId" SessionField="CONTEXT_CLIENTID" />
            </SelectParameters>
        </asp:SqlDataSource>

    </div>
</asp:Content>
