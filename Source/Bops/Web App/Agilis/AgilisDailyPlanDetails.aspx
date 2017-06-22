<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" Inherits="Agilis_AgilisDailyPlanDetails" Title="BOPS | Agilis | Daily Plan Details" Codebehind="AgilisDailyPlanDetails.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
        DataSourceID="AgilisDailyPlanDetails" ForeColor="#333333" GridLines="None" AllowSorting="True">
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <Columns>
            <asp:BoundField DataField="Plan Date" HeaderText="Plan Date" SortExpression="Plan Date" DataFormatString="{0:MM-dd-yy}" HtmlEncode="False" />
            <asp:BoundField DataField="Work Order Number" HeaderText="Work Order" SortExpression="Work Order Number" />
            <asp:HyperLinkField HeaderText="Load" DataTextField="Load Ref" DataNavigateUrlFields="Load Ref"
                DataNavigateUrlFormatString="http://budwaydirect.com/CopsWeb/Customers/_All/LoadTrackingReport.aspx?LoadRef={0}" />
            <asp:BoundField DataField="Last Event" HeaderText="Last Event" ReadOnly="True" SortExpression="Last Event" />
            <asp:BoundField DataField="Current Status" HeaderText="Status" SortExpression="Current Status" />
            <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" />
            <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="FirstName" />
            <asp:BoundField DataField="Tractor" HeaderText="Tractor" SortExpression="Tractor" />
            <asp:BoundField DataField="Trailer" HeaderText="Trailer" SortExpression="Trailer" />
        </Columns>
        <RowStyle BackColor="#EFF3FB" />
        <EmptyDataTemplate>
            No details found for the plan date.
        </EmptyDataTemplate>
        <EditRowStyle BackColor="#2461BF" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="AgilisDailyPlanDetails" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Agilis Imported Work Orders].[Slot Start Date] AS [Plan Date], [Agilis Imported Work Orders].[Work Order Number], MAX([Agilis Imported Work Order Job History].Timestamp) AS [Last Event], [Agilis Imported Work Orders].[Current Status], tblDriverList.FirstName, tblDriverList.LastName, [Agilis Imported Work Orders].[Load Ref], [Agilis Imported Work Orders].Tractor, [Agilis Imported Work Orders].Trailer FROM [Agilis Imported Work Orders] INNER JOIN [Agilis Imported Work Order Jobs] ON [Agilis Imported Work Orders].[Work Order Id] = [Agilis Imported Work Order Jobs].[Work Order Ref] INNER JOIN [Agilis Imported Work Order Job History] ON [Agilis Imported Work Order Jobs].[Work Order Job Id] = [Agilis Imported Work Order Job History].[Work Order Job Ref] INNER JOIN tblDriverList ON [Agilis Imported Work Orders].[Driver Number] = tblDriverList.EmployeeID GROUP BY [Agilis Imported Work Orders].[Work Order Number], [Agilis Imported Work Orders].[Current Status], [Agilis Imported Work Orders].[Slot Start Date], tblDriverList.LastName, tblDriverList.FirstName, [Agilis Imported Work Orders].[Load Ref], [Agilis Imported Work Orders].Tractor, [Agilis Imported Work Orders].Trailer HAVING ([Agilis Imported Work Orders].[Slot Start Date] >= CONVERT (VARCHAR(10), GETDATE(), 101))">
    </asp:SqlDataSource>
</asp:Content>

