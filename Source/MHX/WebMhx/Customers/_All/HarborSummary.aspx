<%@ Page Title="BudwayDirect - Harbor Summary" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="HarborSummary.aspx.cs" Inherits="Customers__All_HarborSummary" %>

<%@ Register Src="~/Controls/ExportControl.ascx" TagPrefix="uc1" TagName="ExportControl" %>
<%@ Register Src="~/Controls/SaveLayoutControl.ascx" TagPrefix="uc1" TagName="SaveLayoutControl" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h2>Harbor Projects Summary</h2>

    <p>
        Select Status:
        <asp:DropDownList ID="ddlStatus" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="Status" DataValueField="Status">
        </asp:DropDownList>
    </p>

    <uc1:ExportControl runat="server" ID="ExportControl" GridViewID="ASPxGridView1" FileName="HarborSummary" />

    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT DISTINCT [Status] FROM [COPSharborSummaryStatus] ORDER BY [Status]"></asp:SqlDataSource>

    <dx:ASPxGridView ID="ASPxGridView1" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" Width="98%">
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="true" ShowFooter="true" ShowGroupPanel="True"></Settings>
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" AllowEllipsisInText="True" ColumnResizeMode="NextColumn" />
        <SettingsContextMenu Enabled="True" EnableRowMenu="False"></SettingsContextMenu>
        <SettingsPager PageSize="20">
            <AllButton Visible="True"></AllButton>
            <PageSizeItemSettings Visible="True"></PageSizeItemSettings>
        </SettingsPager>
        <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
        <Columns>
            <dx:GridViewDataDateColumn FieldName="Start Project" VisibleIndex="0" Caption="FFD" PropertiesDateEdit-DisplayFormatString="{0:d}">
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="DateRangePicker"></SettingsHeaderFilter>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Vessel" VisibleIndex="1"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Destination" VisibleIndex="2"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Delivery Order" VisibleIndex="3"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Client Ref" VisibleIndex="4"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Ct Tendered" VisibleIndex="5"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Ct Recd" VisibleIndex="6"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Loads Received" VisibleIndex="7"></dx:GridViewDataTextColumn>
            <%--            <dx:GridViewDataTextColumn FieldName="Status" VisibleIndex="9"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Parent ref" VisibleIndex="10"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Client" VisibleIndex="1"></dx:GridViewDataTextColumn>--%>
        </Columns>
    </dx:ASPxGridView>
    <br />
    <uc1:SaveLayoutControl runat="server" ID="SaveLayoutControl" GridViewID="ASPxGridView1"/>
    <br />

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT Client, [Start Project], Vessel, [Delivery Order], Destination, [Client Ref], [Ct Tendered], [Ct Recd], [Loads Received], Status, [Parent ref] FROM COPSharborSummaryStatus WHERE ([Parent ref] = @Parent_ref) AND (Status = @status_ref) ORDER BY [Start Project] DESC, Vessel, Destination">
        <SelectParameters>
            <asp:SessionParameter Name="Parent_ref" SessionField="context_clientid" Type="Int32" />
            <asp:ControlParameter ControlID="ddlStatus" DefaultValue="closed" Name="status_ref" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>

