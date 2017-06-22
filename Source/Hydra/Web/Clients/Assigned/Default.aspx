<%@ Page Title="" Language="C#" MasterPageFile="~/Hydra.master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Web.Clients.Assigned.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <h2>Custom Reports</h2>

    <asp:GridView ID="_GridView1" runat="server" BackColor="White" BorderColor="#336666"
        BorderStyle="Double" BorderWidth="3px" CellPadding="4" AutoGenerateColumns="False" DataSourceID="_CustomReportsDatasource" GridLines="Horizontal">
        <RowStyle BackColor="White" ForeColor="#333333" HorizontalAlign="Left" VerticalAlign="Top" />
        <FooterStyle BackColor="White" ForeColor="#333333" />
        <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
        <EmptyDataTemplate>
            <p>Sorry, there are no custom reports available for this user account.</p>
        </EmptyDataTemplate>
        <Columns>
            <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
            <asp:HyperLinkField Text="Link" DataNavigateUrlFields="URL" DataNavigateUrlFormatString="~/{0}" />
            <asp:BoundField DataField="Report Id" HeaderText="Report Id" InsertVisible="False" ReadOnly="True" SortExpression="Report Id" Visible="False" />
            <asp:BoundField DataField="Client Id" HeaderText="Client Id" SortExpression="Client Id" Visible="False" />
            <asp:BoundField DataField="Destination" HeaderText="Destination" SortExpression="Destination" Visible="False" />
        </Columns>
        <SortedAscendingCellStyle BackColor="#F7F7F7" />
        <SortedAscendingHeaderStyle BackColor="#487575" />
        <SortedDescendingCellStyle BackColor="#E5E5E5" />
        <SortedDescendingHeaderStyle BackColor="#275353" />
    </asp:GridView>
    
    <asp:SqlDataSource ID="_CustomReportsDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        
        SelectCommand="SELECT [Hydra Assignable Reports].[Report Id], [Hydra Assignable Reports].Title, [Hydra Assignable Reports].Description, [Hydra Assignable Reports].URL, [Hydra Report Assignments].[Client Id], [DWS Rep Data].dbo.tbldestinationList.Destination FROM [Hydra Assignable Reports] INNER JOIN [Hydra Report Assignments] ON [Hydra Assignable Reports].[Report Id] = [Hydra Report Assignments].[Assignable Report Ref] INNER JOIN [DWS Rep Data].dbo.tbldestinationList ON [Hydra Report Assignments].[Client Id] = [DWS Rep Data].dbo.tbldestinationList.[Destination id] WHERE (@ContextUserId = 166073081) OR ([Hydra Report Assignments].[Client Id] = @ContextUserId) OR (@ContextUserId = 2145260460) ORDER BY [Hydra Assignable Reports].Title">
        <SelectParameters>
            <asp:SessionParameter Name="ContextUserId" SessionField="CONTEXT_CLIENTID" />
        </SelectParameters>
    </asp:SqlDataSource>
    
</asp:Content>
