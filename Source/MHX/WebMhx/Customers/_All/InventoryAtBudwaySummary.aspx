<%@ Page AutoEventWireup="true" CodeFile="InventoryAtBudwaySummary.aspx.cs" Inherits="Customers__All_InventoryAtBudwaySummary" Language="C#" MasterPageFile="~/Main.master" Title="Inventory Summary" %>

<%@ Register Src="~/Controls/ExportControl.ascx" TagPrefix="uc1" TagName="ExportControl" %>
<%@ Register Src="~/Controls/SaveLayoutControl.ascx" TagPrefix="uc1" TagName="SaveLayoutControl" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h2>Inventory at Terminal (Summary)</h2>
    <p>
        <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export XLSX" Theme="MetropolisBlue">
        </dx:ASPxButton>
    </p>

    <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" >
        
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="true" ShowFooter="true" ShowGroupPanel="True"></Settings>
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" AllowEllipsisInText="True" ColumnResizeMode="NextColumn" />
        <SettingsContextMenu Enabled="True" EnableRowMenu="False"></SettingsContextMenu>
        <SettingsPager PageSize="20">
            <AllButton Visible="True"></AllButton>
            <PageSizeItemSettings Visible="True"></PageSizeItemSettings>
        </SettingsPager>
        <Settings VerticalScrollableHeight="500" />
        <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
        <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
        <Columns>
            <dx:GridViewDataTextColumn FieldName="Terminal" VisibleIndex="1"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Product_Profile_Description" Caption="Product Profile Description" VisibleIndex="2"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Ext" Caption="Description" VisibleIndex="3"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Product_Group_1" Caption="Product Group 1" VisibleIndex="4"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Product_Group_2" Caption="Product Group 2" VisibleIndex="5"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Product_Group_3" Caption="Product Group 3" VisibleIndex="6"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Weight" VisibleIndex="7" PropertiesTextEdit-DisplayFormatString="{0:n0}"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Net_Weight" Caption="Net Weight" VisibleIndex="8" PropertiesTextEdit-DisplayFormatString="{0:n0}"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Linear Ft" VisibleIndex="9" PropertiesTextEdit-DisplayFormatString="{0:f1}"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Unit Ct" VisibleIndex="10"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Pcs" VisibleIndex="11"></dx:GridViewDataTextColumn>
        </Columns>
    </dx:ASPxGridView>
    <br />
    <uc1:SaveLayoutControl runat="server" ID="SaveLayoutControl" GridViewID="ASPxGridView1"/>
    <br />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT Terminal, [Product Profile Description] AS Product_Profile_Description, [Product Group 1] AS Product_Group_1, Ext, [Product Group 2] AS Product_Group_2, [Product Group 3] AS Product_Group_3, Weight, Pcs, [Net Weight] AS Net_Weight, [Linear Ft], [Unit Ct] FROM COPSfontanInventorySummary WHERE ([Parent ref] = @Parent_ref2) ORDER BY Terminal, Product_Profile_Description, Product_Group_1">
        <SelectParameters>
            <asp:SessionParameter Name="Parent_ref2" SessionField="CONTEXT_CLIENTID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="InventorySummary" GridViewID="ASPxGridView2"></dx:ASPxGridViewExporter>
</asp:Content>

