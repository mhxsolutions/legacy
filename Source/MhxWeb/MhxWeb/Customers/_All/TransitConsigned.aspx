<%@ Page Title="In-Transit Consigned" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="TransitConsigned.aspx.cs" Inherits="Customers__All_TransitConsigned" %>

<%@ Register Src="~/Controls/ExportControl.ascx" TagPrefix="uc1" TagName="ExportControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h2>In-Transit Consigned Inventory</h2>
    <div class="contentDiv">
        Inventory held by 3rd party for current User, not owned by current User.</p>

        <uc1:ExportControl runat="server" ID="ExportControl" GridViewID="ASPxGridView1" FileName="TransitConsigned" />

    </div>

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
            <dx:GridViewDataTextColumn FieldName="Terminal" VisibleIndex="0">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="ETA" FieldName="E_T_A" VisibleIndex="2">
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="DateRangePicker"></SettingsHeaderFilter>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn Caption="Car Number" FieldName="Car_Number"
                VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Receiver" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Product_Group_1" Visible="False"
                VisibleIndex="10">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Item Ct" FieldName="Item_Count"
                VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Pounds" VisibleIndex="8">
                <PropertiesTextEdit DisplayFormatString="{0:n1}">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Shipper" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="LNFT" VisibleIndex="9">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Type" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
        </Columns>
    </dx:ASPxGridView>
    <dx:ASPxGridViewExporter ID="ASPxGridViewExporter1" runat="server">
    </dx:ASPxGridViewExporter>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT Terminal, [E T A] AS E_T_A, [Car Number] AS Car_Number, Receiver, [Product Group 1] AS Product_Group_1, [Item Count] AS Item_Count, Pounds, Shipper, LNFT, Type, Description FROM [Inventory in Transit Consignment PG1 Summary] WHERE ([Auth Viewer Ref] = @ReceiverID) ORDER BY E_T_A, Car_Number">
        <SelectParameters>
            <asp:SessionParameter Name="ReceiverID" SessionField="context_clientid" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

