<%@ Page AutoEventWireup="true" CodeFile="ProfileList.aspx.cs" Inherits="Customers__All_ProfileList" Language="C#" MasterPageFile="~/Main.master" Title="Profile List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h2>Profile List wih Authorized Viewers</h2><br />

    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" Width="98%">
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="true" ShowFooter="true" ShowGroupPanel="True"></Settings>
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" AllowEllipsisInText="True" ColumnResizeMode="NextColumn" />
        <SettingsContextMenu Enabled="True" EnableRowMenu="False"></SettingsContextMenu>
        <SettingsPager PageSize="20">
            <AllButton Visible="True"></AllButton>
            <PageSizeItemSettings Visible="True"></PageSizeItemSettings>
        </SettingsPager>
        <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
        <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
        <Columns>
            <dx:GridViewDataTextColumn FieldName="Profile" VisibleIndex="0"></dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Authorized_Viewer" Caption="Authorized Viewer" VisibleIndex="1"></dx:GridViewDataTextColumn>
        </Columns>
    </dx:ASPxGridView>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>"
        SelectCommand="SELECT [Profile], [Authorized Viewer] AS Authorized_Viewer FROM [ProfileINFO] WHERE ([Receiving Client Ref] = @Receiving_Client_Ref) ORDER BY [Profile]">
        <SelectParameters>
            <asp:SessionParameter Name="Receiving_Client_Ref" SessionField="context_clientid"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    Authorized Viewers can view your inventory with In-Transit and On Site Consigned
    Inventory reports.&nbsp;
</asp:Content>

