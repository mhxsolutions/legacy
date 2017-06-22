<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/BopsWeb.master" 
    Inherits="Auditing_AuditRfsCalculationResults" Title="BOPS | Auditing | RFS Load Calculations" Codebehind="AuditRfsCalculationResults.aspx.cs" %>
    
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../Controls/PopupCalendarControl.ascx" TagName="PopupCalendarControl" TagPrefix="uc1" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <asp:ScriptManager ID="_ScriptManager1" runat="server"/>
    
    <h2>RFS Load Calculations</h2>
        
    <asp:Label ID="BeginDateLabel" runat="server" Text="Begin Date:" />
    <asp:TextBox ID="BeginDateTextbox" runat="server" Text="4/1/2009"></asp:TextBox>
    <cc1:CalendarExtender ID="BeginDateCalendarExtender" runat="server" TargetControlID="BeginDateTextbox" 
        PopupButtonID="BeginDateCalendarImage" />
    <asp:Image ID="BeginDateCalendarImage" runat="server" ImageUrl="~/Images/CalendarIcon16x16.png" ImageAlign="Middle" />
    <asp:Button ID="RefreshButton" runat="server" Text="Refresh" />
    <br />
    Fleet:
    <asp:DropDownList ID="FleetDropDownList" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="Fleet" DataValueField="Fleet">
    </asp:DropDownList>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Fleet] FROM [Fleet] WHERE (([Company ID ref] &lt;= @Company_ID_ref) AND ([Active] = @Active)) ORDER BY [Fleet]">
        <SelectParameters>
            <asp:Parameter DefaultValue="2" Name="Company_ID_ref" Type="Int32" />
            <asp:Parameter DefaultValue="-1" Name="Active" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br /><br />
        
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
        DataKeyNames="Load" DataSourceID="RfsCalculationsToReview" ForeColor="#333333"
        GridLines="None" AllowSorting="True">
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <Columns>
            <asp:HyperLinkField HeaderText="Load" DataTextField="Load" DataNavigateUrlFields="Load" SortExpression="Load"
                DataNavigateUrlFormatString="http://budwaydirect.com/CopsWeb/Customers/_All/LoadTrackingReport.aspx?LoadRef={0}" >
                <HeaderStyle HorizontalAlign="Left" />
            </asp:HyperLinkField>
            <asp:BoundField DataField="Logout Date" HeaderText="Logout Date" SortExpression="Logout Date"
                DataFormatString="{0:MM-dd-yy}" HtmlEncode="False" >
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="Fleet" HeaderText="Fleet" SortExpression="Fleet">
                <HeaderStyle HorizontalAlign="Left" />
                <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:HyperLinkField HeaderText="RFS" DataTextField="RFS" DataNavigateUrlFields="RFS" 
                SortExpression="RFS" DataNavigateUrlFormatString="~/RFS/RfsWizardSelectRfsAndForward.aspx?RFSID={0}&amp;Target=Services" >
                <HeaderStyle HorizontalAlign="Left" />
            </asp:HyperLinkField>
            <asp:BoundField DataField="Last Calculation" HeaderText="Last Calculation" SortExpression="Last Calculation"
                DataFormatString="{0:MM-dd-yy}" HtmlEncode="False" >
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:HyperLinkField HeaderText="Description" DataTextField="Description" DataNavigateUrlFields="RFS,Result Type,Load"
                SortExpression="Description" DataNavigateUrlFormatString="AuditRfsCalculationResultsForwardToResolution.aspx?RfsId={0}&amp;ResultCode={1}&amp;DocumentId={2}&amp;ServiceCategory=1" >
                <HeaderStyle HorizontalAlign="Left" />
            </asp:HyperLinkField>
            <asp:BoundField DataField="Resolution Suggestions" HeaderText="Resolution Suggestions" SortExpression="Resolution Suggestions" >
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
        </Columns>
        <RowStyle BackColor="#EFF3FB" />
        <EditRowStyle BackColor="#2461BF" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="RfsCalculationsToReview" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [RFS Calculation Results].[Load], tblPoscoLoads.LogOutDate AS [Logout Date], tblPoscoLoads.[RFS ref] AS RFS, [RFS Calculation Results].[Last Calculation], [RFS Calculation Result Types].Description, [RFS Calculation Result Types].[Resolution Suggestions], [RFS Calculation Results].[Do Not Update], [RFS Calculation Results].[Result Type], Fleet.Fleet FROM [RFS Calculation Results] INNER JOIN [RFS Calculation Result Types] ON [RFS Calculation Results].[Result Type] = [RFS Calculation Result Types].[RFS Calculation Result Type ID] INNER JOIN tblPoscoLoads ON [RFS Calculation Results].[Load] = tblPoscoLoads.[Load] INNER JOIN Fleet ON tblPoscoLoads.[Fleet ref] = Fleet.[Fleet ID] WHERE ([RFS Calculation Results].[Result Type] IN (2, 5, 6, 7, 8, 9)) AND (tblPoscoLoads.LogOutDate &gt;= @BeginDate) AND (Fleet.Fleet = @fleet) ORDER BY [Logout Date]">
        <SelectParameters>
            <asp:ControlParameter ControlID="BeginDateTextbox" DefaultValue="4/1/2009" Name="BeginDate"
                PropertyName="Text" />
            <asp:ControlParameter ControlID="FleetDropDownList" DefaultValue="bud- fontana" Name="fleet" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
