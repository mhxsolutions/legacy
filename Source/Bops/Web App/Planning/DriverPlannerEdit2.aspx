<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" Inherits="Planning_DriverPlannerEdit2" Title="Untitled Page" Codebehind="DriverPlannerEdit2.aspx.cs" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <%-- Necessary for the AJAX control toolkit --%>
    
    <asp:ScriptManager ID="_ScriptManager1" runat="server">
    </asp:ScriptManager>

    <h2>Driver Planner</h2>
    
    <h3><asp:Label ID="_PlanHeaderLabel" runat="server" /></h3>

    <asp:GridView ID="_PlanGridview" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="_DriverPlanDatasource" 
        DataKeyNames="DetailId" ForeColor="#333333" GridLines="None">
        <EmptyDataTemplate>
            The driver's plan has no steps at the present time.
        </EmptyDataTemplate>
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:BoundField DataField="Order" HeaderText="Order" ReadOnly="True" SortExpression="Order">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Origin" HeaderText="Origin" ReadOnly="True" SortExpression="Origin" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Destination" HeaderText="Destination" ReadOnly="True" SortExpression="Destination" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Load" HeaderText="Load" ReadOnly="True" SortExpression="Load">
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
            <asp:BoundField DataField="Arrive" HeaderText="Arrive" ReadOnly="True" SortExpression="Arrive" DataFormatString="{0:HH:mm}" >
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Dwell" HeaderText="Dwell" ReadOnly="True" SortExpression="Dwell" >
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Depart" HeaderText="Depart" ReadOnly="True" SortExpression="Depart" DataFormatString="{0:HH:mm}" >
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            
            <asp:TemplateField HeaderText="Notes" SortExpression="Notes">
                <EditItemTemplate>
                    <asp:TextBox ID="_NotesTextbox" runat="server" Text='<%# Bind("Notes") %>' MaxLength="50"></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="_NotesLabel" runat="server" Text='<%# Eval("Notes")%>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:TemplateField>
            
            <asp:CommandField ShowEditButton="True" HeaderStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top" />            
            
        </Columns>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#C0FFFF" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    
    <asp:SqlDataSource ID="_DriverPlanDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Planner Detail].[Planner Detail ID] AS DetailId, [Planner Detail].[Order], [DWS Rep Data].dbo.tbldestinationList.Destination + ': ' + [DWS Rep Data].dbo.tbldestinationList.City + ', ' + ISNULL([DWS Rep Data].dbo.tbldestinationList.State, '') AS Origin, tbldestinationList_1.Destination + ': ' + tbldestinationList_1.City + ', ' + ISNULL(tbldestinationList_1.State, '') AS Destination, [Planner Detail].[Load Ref] AS [Load], [Planner Detail].Transit, [Planner Detail].[Sch Arrive] AS Arrive, [Planner Detail].Detention AS Dwell, [Planner Detail].[Sch Depart] AS Depart, [Planner Detail].Notes, [Planner Detail Action].[Planner Action] AS PlannerAction, [Planner Detail].[Planner Ref] AS PlanRef, [Planner Detail].[Planner Detail ID] AS DetailId FROM [Planner Detail] INNER JOIN [DWS Rep Data].dbo.tbldestinationList ON [Planner Detail].[Origin Ref] = [DWS Rep Data].dbo.tbldestinationList.[Destination id] INNER JOIN [DWS Rep Data].dbo.tbldestinationList AS tbldestinationList_1 ON [Planner Detail].[Dest Ref] = tbldestinationList_1.[Destination id] INNER JOIN [Planner Detail Action] ON [Planner Detail].[Action ref] = [Planner Detail Action].[Planner Action ID] WHERE ([Planner Detail].[Planner Ref] = @PlanId) ORDER BY [Planner Detail].[Order]"
        UpdateCommand="UPDATE [Planner Detail] SET [Notes]=@Notes WHERE [Planner Detail ID]=@DetailId">
        <SelectParameters>
            <asp:QueryStringParameter Name="PlanId" QueryStringField="PlanId" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="DetailId" />
        </UpdateParameters>
    </asp:SqlDataSource>
    
    <p>
        <asp:Label ID="_PostTripLabel" runat="server" Text="Post-Trip Destination:" />
        <asp:DropDownList ID="_PostTripDestinationsDropdownlist" runat="server" DataSourceID="_PostTripDestinationsDatasource" DataTextField="Name" DataValueField="Id"/><asp:SqlDataSource
            ID="_PostTripDestinationsDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
            SelectCommand="SELECT [Destination Set Assignments].[Set Ref], [Destination Set Assignments].[Destination Ref] AS Id, [DWS Rep Data].dbo.tbldestinationList.Destination + N': ' + [DWS Rep Data].dbo.tbldestinationList.City + N', ' + ISNULL([DWS Rep Data].dbo.tbldestinationList.State, N'') AS Name FROM [Destination Set Assignments] INNER JOIN [DWS Rep Data].dbo.tbldestinationList ON [Destination Set Assignments].[Destination Ref] = [DWS Rep Data].dbo.tbldestinationList.[Destination id] WHERE ([Destination Set Assignments].[Set Ref] = @PostTripSetId) ORDER BY Name">
            <SelectParameters>
                <asp:Parameter DefaultValue="1" Name="PostTripSetId" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Button ID="_PostTripButton" runat="server" Text="Plan Post-Trip" OnClick="_PostTripButton_Click" /><br />
        <asp:HyperLink ID="_DeleteLastStepHyperlink" runat="server" Text="<br/>Click here to delete the last step in the plan."
            NavigateUrl='<%# string.Format("DriverPlannerDeleteLastStep.aspx?PlanId={0}", Request.QueryString["PlanId"]) %>' />
    </p>
        
    <h3>Loads to Plan</h3>
    
    <asp:GridView ID="_BucketGridview" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Load" 
        DataSourceID="_BucketDatasource" ForeColor="#333333" GridLines="None" AllowPaging="True" AllowSorting="True">
        <EmptyDataTemplate>
            There are no loads to plan at the present time.
        </EmptyDataTemplate>
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:BoundField DataField="Load" HeaderText="Load" ReadOnly="True" SortExpression="Load" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Origin" HeaderText="Origin" ReadOnly="True" SortExpression="Origin" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Destination" HeaderText="Destination" ReadOnly="True" SortExpression="Destination" >
                <HeaderStyle HorizontalAlign="Left" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Count" HeaderText="Count" SortExpression="Count" DataFormatString="{0:N0}">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Gross Weight" HeaderText="Weight" SortExpression="Gross Weight" DataFormatString="{0:N0}">
                <HeaderStyle HorizontalAlign="Right" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:BoundField DataField="Partial" HeaderText="Partial?" SortExpression="Partial" >
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Top" />
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" />
            </asp:BoundField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton ID="_PlanLoadLinkbutton" runat="server" Text="Plan"
                        PostBackUrl='<%# string.Format("DriverPlannerPlanStep.aspx?PlanId={0}&LoadRef={1}", Request.QueryString["PlanId"], Eval("Load")) %>'>
                    </asp:LinkButton>
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
    <asp:SqlDataSource ID="_BucketDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT tblPoscoLoads.[Load], tblPoscoLoads.Origin AS [Origin Ref], tbldestinationList_1.Destination + ': ' + tbldestinationList_1.City + ', ' + ISNULL(tbldestinationList_1.State, '') AS Origin, tblPoscoLoads.DeliveryLocation AS [Destination Ref], tbldestinationList_2.Destination + ': ' + tbldestinationList_2.City + ', ' + ISNULL(tbldestinationList_2.State, '') AS Destination, tblPoscoLoads.CoilCount AS Count, tblPoscoLoads.GrossWeight AS [Gross Weight], CASE WHEN [Partial Load] = 1 THEN 'Yes' ELSE 'No' END AS Partial, Planner.[Plan ID] FROM tblDriverList INNER JOIN Planner ON tblDriverList.EmployeeID = Planner.[Driver Ref] INNER JOIN tblPoscoLoads LEFT OUTER JOIN [Planner Detail] ON tblPoscoLoads.[Load] = [Planner Detail].[Load Ref] INNER JOIN [DWS Rep Data].dbo.tbldestinationList AS tbldestinationList_1 ON tblPoscoLoads.Origin = tbldestinationList_1.[Destination id] INNER JOIN [DWS Rep Data].dbo.tbldestinationList AS tbldestinationList_2 ON tblPoscoLoads.DeliveryLocation = tbldestinationList_2.[Destination id] ON tblDriverList.[Fleet ref] = tblPoscoLoads.[Fleet ref] WHERE (tblPoscoLoads.LogOutDate IS NULL) AND (tblPoscoLoads.LoadDate <= GETDATE()) AND ([Planner Detail].[Load Ref] IS NULL) AND (ISNULL(tblPoscoLoads.[Will Call], 0) = 0) AND (Planner.[Plan ID] = @PlanId)">
        <SelectParameters>
            <asp:QueryStringParameter Name="PlanId" QueryStringField="PlanId" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>

