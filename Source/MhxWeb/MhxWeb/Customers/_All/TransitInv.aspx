<%@ Page AutoEventWireup="true" CodeFile="TransitInv.aspx.cs" Inherits="Customers__All_TransitInv" Language="C#" MasterPageFile="~/Main.master" Title="In-Transit Inventory" %>

<%@ Register Src="~/Controls/ExportControl.ascx" TagPrefix="uc1" TagName="ExportControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h2>In-Transit Inventory</h2>

    <uc1:ExportControl runat="server" ID="ExportControl" GridViewID="ASPxGridView1" FileName="TransitInv" />

    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" Width="98%">
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="true" ShowFooter="true" ShowGroupPanel="True"></Settings>
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" AllowEllipsisInText="True" ColumnResizeMode="NextColumn" />
        <SettingsContextMenu Enabled="True" EnableRowMenu="False"></SettingsContextMenu>
        <SettingsPager PageSize="20">
            <AllButton Visible="True"></AllButton>
            <PageSizeItemSettings Visible="True"></PageSizeItemSettings>
        </SettingsPager>
        <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Terminal" SortIndex="0"
                SortOrder="Ascending" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="ETA" FieldName="E_T_A" SortIndex="1" SortOrder="Ascending" VisibleIndex="3">
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="DateRangePicker"></SettingsHeaderFilter>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Car_Number" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Desc" FieldName="Receiver" VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Product_Group_1" Visible="False"
                VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Item Ct" FieldName="Item_Count"
                VisibleIndex="9">
                <HeaderStyle HorizontalAlign="Right" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Pounds" VisibleIndex="11">
                <PropertiesTextEdit DisplayFormatString="{0:n1}">
                </PropertiesTextEdit>
                <HeaderStyle HorizontalAlign="Right" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Shipper" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Footage" FieldName="LNFT" VisibleIndex="10">
                <PropertiesTextEdit DisplayFormatString="n1">
                </PropertiesTextEdit>
                <HeaderStyle HorizontalAlign="Right" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Profile" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Type" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
        </Columns>
    </dx:ASPxGridView>


    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT Terminal, [E T A] AS E_T_A, [Car Number] AS Car_Number, Receiver, [Product Group 1] AS Product_Group_1, [Item Count] AS Item_Count, Pounds, Shipper, LNFT, Profile, Type FROM [inventory in Transit PG1 summary] WHERE (ReceiverID = @ReceiverID) ORDER BY E_T_A, Car_Number">
        <SelectParameters>
            <asp:SessionParameter Name="ReceiverID" SessionField="context_clientid" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

