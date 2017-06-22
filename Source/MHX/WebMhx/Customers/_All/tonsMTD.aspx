<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="tonsMTD.aspx.cs" Inherits="Customers__All_tonsMTD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h2>Tons Shipped MTD</h2>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" Width="70%">
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="true" ShowFooter="true" ShowGroupPanel="True"></Settings>
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" AllowEllipsisInText="True" ColumnResizeMode="NextColumn" />
        <SettingsContextMenu Enabled="True" EnableRowMenu="False"></SettingsContextMenu>
        <SettingsPager PageSize="20">
            <AllButton Visible="True"></AllButton>
            <PageSizeItemSettings Visible="True"></PageSizeItemSettings>
        </SettingsPager>

<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>

        <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0" Visible="False">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Month" SortIndex="0" SortOrder="Descending" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Destination" FieldName="Final_Destination" SortIndex="1" SortOrder="Ascending" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Load Ct MTD" FieldName="Load_Ct" VisibleIndex="3">
                <PropertiesTextEdit DisplayFormatString="n0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Tons MTD" FieldName="Tons_Delivered_MTD" VisibleIndex="4">
                <PropertiesTextEdit DisplayFormatString="n1">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Avg Tons per Load" FieldName="Avg_Ton_per_Load" ReadOnly="True" VisibleIndex="5">
                <PropertiesTextEdit DisplayFormatString="n1">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
        </Columns>
        <Styles>
            <Cell Wrap="False">
            </Cell>
        </Styles>
    </dx:ASPxGridView>
    <br />


    <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" Width="70%">
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <SettingsPager PageSize="20">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupPanel="True" />
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />

<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0" Visible="False">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="Month" SortIndex="0" SortOrder="Descending" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Shipper" FieldName="Shipper" SortIndex="1" SortOrder="Ascending" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Load Ct MTD" FieldName="Loads_MTD" VisibleIndex="3">
                <PropertiesTextEdit DisplayFormatString="n0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Tons MTD" FieldName="Tons_MTD" VisibleIndex="4">
                <PropertiesTextEdit DisplayFormatString="n1">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Avg Tons per Load" FieldName="Avg_Ton_per_Load" ReadOnly="True" VisibleIndex="5">
                <PropertiesTextEdit DisplayFormatString="n1">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
        </Columns>
        <Styles>
            <Cell Wrap="False">
            </Cell>
        </Styles>
    </dx:ASPxGridView>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT Month, [Final Destination] AS Final_Destination, [Load Ct] AS Load_Ct, [Tons Delivered MTD] AS Tons_Delivered_MTD, [Avg Ton per Load] AS Avg_Ton_per_Load FROM [COPS tons del mtd] WHERE ([Shipper Ref] = @Shipper_Ref) OR ([Dest ref] = @Shipper_Ref) ORDER BY Final_Destination">
        <SelectParameters>
            <asp:SessionParameter Name="Shipper_Ref" SessionField="context_clientid" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Month], [Shipper], [Loads MTD] AS Loads_MTD, [Tons MTD] AS Tons_MTD, [Avg Ton per Load] AS Avg_Ton_per_Load FROM [COPS tons del mtd summary by client] WHERE ([Shipper Ref] = @Shipper_Ref)">
        <SelectParameters>
            <asp:SessionParameter Name="Shipper_Ref" SessionField="context_clientid" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

