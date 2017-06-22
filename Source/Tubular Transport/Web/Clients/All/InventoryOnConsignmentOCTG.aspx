<%@ Page Title="" Language="C#" MasterPageFile="~/TubularTransport.master" AutoEventWireup="true" CodeFile="InventoryOnConsignmentOCTG.aspx.cs" Inherits="Customers__All_InventoryOnConsignmentOCTG" %>

<%@ Register assembly="DevExpress.Web.v15.1, Version=15.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>



<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        OCTG
        Consigned
        Inventory</h3>
    <br />
    Held by other Clients for current User.<br />
    This inventory is not owned by the current User.<br />
    <p>
        <asp:Button ID="ExportToExcelButton" runat="server" OnClick="ExportToExcelButton_Click"
            Text="Export to Excel" />&nbsp;</p>
    <p>
        <dx:ASPxGridViewExporter ID="InvenConsigOCTGExport" runat="server">
        </dx:ASPxGridViewExporter>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Metropolis">
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True">
            </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Inventory" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Auth ref" Visible="False" 
                    VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Terminal" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Profile" 
                    FieldName="Product Profile Description" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Description" FieldName="Ext" 
                    VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataHyperLinkColumn Caption="Product" FieldName="Product Group 1" 
                    VisibleIndex="6">
                    <PropertiesHyperLinkEdit NavigateUrlFormatString="Product_Consigned_Transactions_lookup.aspx?Profile={0}">
                    </PropertiesHyperLinkEdit>
                </dx:GridViewDataHyperLinkColumn>
                <dx:GridViewDataTextColumn Caption="Mill" FieldName="Product Group 2" 
                    VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Inspection" FieldName="Product Group 3" 
                    VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Pounds" FieldName="Weight" 
                    VisibleIndex="11">
                    <PropertiesTextEdit DisplayFormatString="{0:n1}">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Count" FieldName="Pcs" VisibleIndex="9">
                    <PropertiesTextEdit DisplayFormatString="{0:n1}">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Parent ref" Visible="False" 
                    VisibleIndex="12">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Net Weight" Visible="False" 
                    VisibleIndex="13">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Linear Ft" VisibleIndex="10" 
                    Caption="LNFT">
                    <PropertiesTextEdit DisplayFormatString="{0:n1}">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="30">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" ShowFilterBar="Visible" ShowFooter="True" />
            <Styles>
                <Cell Wrap="False">
                </Cell>
            </Styles>
        </dx:ASPxGridView>
    <br />
    &nbsp;<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT * FROM [COPSfontanaInvSummaryAuthViewer] WHERE ([Auth ref] = @Auth_ref) ORDER BY [Inventory], [Terminal], [Ext]">
        <SelectParameters>
            <asp:SessionParameter Name="Auth_ref" SessionField="context_clientID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

