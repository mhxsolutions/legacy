<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" Inherits="Planning_DriverPlannerEdit" 
    Title="BOPS | Planning | Edit Driver Plan" Codebehind="DriverPlannerEdit.aspx.cs" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h2>Edit Driver Plan</h2>

    <h3><asp:Label ID="_PlanHeaderLabel" runat="server" /></h3>
    <p><asp:HyperLink ID="_NewStepHyperlink" runat="server" Text="Click here to add a new step to the end of the plan." /></p>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="_DriverPlanDatasource" ForeColor="#333333" GridLines="None">
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:BoundField DataField="Order" HeaderText="Order" SortExpression="Order" >
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Origin" HeaderText="Origin" ReadOnly="True" SortExpression="Origin" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Destination" HeaderText="Destination" ReadOnly="True" SortExpression="Destination" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Load" HeaderText="Load" ReadOnly="True" SortExpression="Load" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="PlannerAction" HeaderText="Action" ReadOnly="True" SortExpression="PlannerAction" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Transit" HeaderText="Transit" ReadOnly="True" SortExpression="Transit" >
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Arrive" HeaderText="Arrive" SortExpression="Arrive" DataFormatString="{0:HH:mm}" >
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Dwell" HeaderText="Dwell" SortExpression="Dwell" >
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Depart" HeaderText="Depart" SortExpression="Depart" DataFormatString="{0:HH:mm}" >
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Notes" HeaderText="Notes" SortExpression="Notes" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:HyperLinkField DataNavigateUrlFields="PlanRef,DetailId" DataNavigateUrlFormatString="DriverPlannerCreateStep.aspx?PlanId={0}&InsertBefore={1}" Text="Insert" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:HyperLinkField>
            <asp:HyperLinkField DataNavigateUrlFields="PlanRef,DetailId" DataNavigateUrlFormatString="DriverPlannerEditStep.aspx?PlanId={0}&DetailId={1}" Text="Edit" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:HyperLinkField>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <a href="DriverPlannerDeleteStep.aspx?PlanId=<%# Eval("PlanRef") %>&DetailId=<%# Eval("DetailId") %>" 
                        onclick='return confirm("Are you sure you want to delete the plan step?");'>Delete</a>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>

    <p><asp:Label ID="_WarningLabel" runat="server" Text="WARNING: This plan has one or more steps whose origin does not match the previous destination." /></p>

    <asp:SqlDataSource ID="_DriverPlanDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Planner Detail].[Order], [DWS Rep Data].dbo.tbldestinationList.Destination + ': ' + [DWS Rep Data].dbo.tbldestinationList.City + ', ' + ISNULL([DWS Rep Data].dbo.tbldestinationList.State, '') AS Origin, tbldestinationList_1.Destination + ': ' + tbldestinationList_1.City + ', ' + ISNULL(tbldestinationList_1.State, '') AS Destination, [Planner Detail].[Load Ref] AS [Load], [Planner Detail].Transit, [Planner Detail].[Sch Arrive] AS Arrive, [Planner Detail].Detention AS Dwell, [Planner Detail].[Sch Depart] AS Depart, [Planner Detail].Notes, [Planner Detail Action].[Planner Action] AS PlannerAction, [Planner Detail].[Planner Ref] AS PlanRef, [Planner Detail].[Planner Detail ID] AS DetailId FROM [Planner Detail] INNER JOIN [DWS Rep Data].dbo.tbldestinationList ON [Planner Detail].[Origin Ref] = [DWS Rep Data].dbo.tbldestinationList.[Destination id] INNER JOIN [DWS Rep Data].dbo.tbldestinationList AS tbldestinationList_1 ON [Planner Detail].[Dest Ref] = tbldestinationList_1.[Destination id] INNER JOIN [Planner Detail Action] ON [Planner Detail].[Action ref] = [Planner Detail Action].[Planner Action ID] WHERE ([Planner Detail].[Planner Ref] = @PlanId) ORDER BY [Planner Detail].[Order]">
        <SelectParameters>
            <asp:QueryStringParameter Name="PlanId" QueryStringField="PlanId" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
