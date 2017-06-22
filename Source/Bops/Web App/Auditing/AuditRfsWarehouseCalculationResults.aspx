<%@ Page Language="C#" MasterPageFile="~/BopsWeb.master" AutoEventWireup="true" 
    Inherits="Auditing_AuditRfsWarehouseCalculationResults" Title="BOPS | Auditing | RFS Warehouse Calculations" Codebehind="AuditRfsWarehouseCalculationResults.aspx.cs" %>
    
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="../Controls/PopupCalendarControl.ascx" TagName="PopupCalendarControl" TagPrefix="uc1" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="_ScriptManager1" runat="server"/>
    
    <h2>RFS Warehouse Calculations</h2>
    
    <asp:Label ID="BeginDateLabel" runat="server" Text="Begin Date:" />
    <asp:TextBox ID="BeginDateTextbox" runat="server" Text="4/1/2009"></asp:TextBox>
    <cc1:CalendarExtender ID="BeginDateCalendarExtender" runat="server" TargetControlID="BeginDateTextbox" 
        PopupButtonID="BeginDateCalendarImage" />
    <asp:Image ID="BeginDateCalendarImage" runat="server" ImageUrl="~/Images/CalendarIcon16x16.png" ImageAlign="Middle" />
    <asp:Button ID="RefreshButton" runat="server" Text="Refresh" />
    <br /><br />

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="WarehouseResultsDatasource" ForeColor="#333333" GridLines="None" AllowSorting="True">
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" SortExpression="ID" >
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>   
            <asp:BoundField DataField="Date" HeaderText="Date" ReadOnly="True" SortExpression="Date" 
                DataFormatString="{0:MM-dd-yy}" HtmlEncode="False" >
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="Type" HeaderText="Type" ReadOnly="True" SortExpression="Type" >
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="TerminalOrFleet" HeaderText="Terminal/Fleet" SortExpression="TerminalOrFleet" >
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>      
            <asp:HyperLinkField HeaderText="RFS" DataTextField="RFS" DataNavigateUrlFields="RFS" 
                SortExpression="RFS" DataNavigateUrlFormatString="~/RFS/RfsWizardSelectRfsAndForward.aspx?RFSID={0}&amp;Target=Services" >
                <HeaderStyle HorizontalAlign="Left" />
            </asp:HyperLinkField>
            <asp:BoundField DataField="Last Calculation" HeaderText="Last Calculation" SortExpression="Last Calculation"
                DataFormatString="{0:MM-dd-yy}" HtmlEncode="False" >
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:HyperLinkField HeaderText="Description" DataTextField="Description" DataNavigateUrlFields="RFS,Result Type,ID,Warehouse Document Type"
                SortExpression="Description" DataNavigateUrlFormatString="AuditRfsCalculationResultsForwardToResolution.aspx?RfsId={0}&amp;ResultCode={1}&amp;DocumentId={2}&amp;DocumentType={3}&amp;ServiceCategory=2" >
                <HeaderStyle HorizontalAlign="Left" />
            </asp:HyperLinkField>
            <asp:BoundField DataField="Resolution Suggestions" HeaderText="Resolution Suggestions"
                ReadOnly="True" SortExpression="Resolution Suggestions" >
                <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
        </Columns>
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="WarehouseResultsDatasource" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="BopsGetRfsWarehouseCalculationResults" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="BeginDateTextbox" DefaultValue="4/1/2009" Name="BeginDate" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
