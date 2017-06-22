<%@ Page Title="Custom" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeFile="Custom.aspx.cs" Inherits="Customers__All_Custom" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h2>Custom Reports</h2>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" Width="98%">
            <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="true" ShowFooter="true" ShowGroupPanel="True"></Settings>
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" AllowEllipsisInText="True" ColumnResizeMode="NextColumn" />
            <SettingsContextMenu Enabled="True" EnableRowMenu="False"></SettingsContextMenu>
            <SettingsPager PageSize="20">
                <AllButton Visible="True"></AllButton>
                <PageSizeItemSettings Visible="True"></PageSizeItemSettings>
            </SettingsPager>
            <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
            <SettingsCommandButton>
                <ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>
                <HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
            </SettingsCommandButton>
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0" Visible="False">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataHyperLinkColumn Caption=" Report" FieldName="URL" ReadOnly="True" VisibleIndex="1">
                    <PropertiesHyperLinkEdit TextField="Title">
                    </PropertiesHyperLinkEdit>
                </dx:GridViewDataHyperLinkColumn>
                <dx:GridViewDataTextColumn FieldName="Title" SortIndex="1" SortOrder="Ascending" VisibleIndex="3" Visible="False">
                </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT * FROM COPSnew_CustomReports WHERE ([Client Id] = @Client_Id) OR (@Client_Id = 166073081)">
            <SelectParameters>
                <asp:SessionParameter Name="Client_Id" SessionField="context_clientid" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>

