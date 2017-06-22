<%@ Page Title="" Language="C#" MasterPageFile="~/UPA.master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Web.Clients.Assigned.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <h2>Custom Reports</h2>

    <asp:GridView ID="_GridView1" runat="server" BackColor="White" BorderColor="#CC9966"
        BorderStyle="None" BorderWidth="1px" CellPadding="4" AutoGenerateColumns="False" DataSourceID="_CustomReportsDatasource">
        <RowStyle BackColor="White" ForeColor="Black" HorizontalAlign="Left" VerticalAlign="Top" />
        <FooterStyle BackColor="White" ForeColor="Black" />
        <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
        <HeaderStyle BackColor="#1B74BB" Font-Bold="True" ForeColor="White" />
        <EmptyDataTemplate>
            <p>Sorry, there are no custom reports available for this user account.</p>
        </EmptyDataTemplate>
        <Columns>
            <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
            <asp:HyperLinkField Text="Link" DataNavigateUrlFields="URL" DataNavigateUrlFormatString="~/{0}" />
            <asp:BoundField DataField="Report Id" HeaderText="Report Id" InsertVisible="False" ReadOnly="True" SortExpression="Report Id" Visible="False" />
            <asp:BoundField DataField="Client Id" HeaderText="Client Id" SortExpression="Client Id" Visible="False" />
            <asp:BoundField DataField="Destination" HeaderText="Destination" SortExpression="Destination" />
        </Columns>
    </asp:GridView>
    
    <asp:SqlDataSource ID="_CustomReportsDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>"
        
        SelectCommand="SELECT [UPA Assignable Reports].[Report Id], [UPA Assignable Reports].Title, [UPA Assignable Reports].Description, [UPA Assignable Reports].URL, [UPA Report Assignments].[Client Id], [UPA Rep Data].dbo.tbldestinationList.Destination FROM [UPA Assignable Reports] INNER JOIN [UPA Report Assignments] ON [UPA Assignable Reports].[Report Id] = [UPA Report Assignments].[Assignable Report Ref] INNER JOIN [UPA Rep Data].dbo.tbldestinationList ON [UPA Report Assignments].[Client Id] = [UPA Rep Data].dbo.tbldestinationList.[Destination id] WHERE (@ContextUserId = 2145401161) OR ([UPA Report Assignments].[Client Id] = @ContextUserId) OR (@ContextUserId = 2145401168) ORDER BY [UPA Assignable Reports].Title">
        <SelectParameters>
            <asp:SessionParameter Name="ContextUserId" SessionField="CONTEXT_CLIENTID" />
        </SelectParameters>
    </asp:SqlDataSource>
    
</asp:Content>
