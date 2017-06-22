<%@ Page Title="Full Catalog" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="SCGcurrentStockSummary.aspx.cs" Inherits="Clients_Assigned_SCGcurrentStockSummary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h3>Petros Full Catalog with Current Inventory Totals</h3>
    <p>
        <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export to XLSX" Theme="Metropolis">
        </dx:ASPxButton>
    </p>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Width="100%">
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsAdaptivity AdaptivityMode="HideDataCells">
            </SettingsAdaptivity>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" ShowFooter="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" AllowEllipsisInText="True" ColumnResizeMode="Control" />

<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>

            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0" Visible="False">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="SCG Part Number" SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Old Desc" VisibleIndex="3" AllowTextTruncationInAdaptiveMode="True" AdaptivePriority="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="New Desc" VisibleIndex="4" AllowTextTruncationInAdaptiveMode="True" AdaptivePriority="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Count" ReadOnly="True" VisibleIndex="5" AdaptivePriority="3">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="LNFT" ReadOnly="True" VisibleIndex="6" AdaptivePriority="4">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
            </Columns>
            <Styles>
                <Cell Wrap="False">
                </Cell>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [Petros full catalog of consigned stock with current inventory]"></asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="PSEP Catalog Inventory" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    </p>
</asp:Content>

