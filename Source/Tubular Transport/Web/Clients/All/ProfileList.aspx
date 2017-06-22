<%@ Page Title="Profile List" Language="C#" MasterPageFile="~/TubularTransport.master" AutoEventWireup="true" CodeFile="ProfileList.aspx.cs" Inherits="Clients_All_ProfileList" %>

<%@ Register assembly="DevExpress.Web.v15.1, Version=15.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h3>
        Profile List of Authorized Viewers with Consigned Inventory</h3>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableTheming="True" 
            Theme="Metropolis">
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>

<Settings ShowFilterRow="True" ShowFilterBar="Visible"></Settings>
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Profile" VisibleIndex="1" SortIndex="0" 
                    SortOrder="Ascending">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Authorized_Viewer" VisibleIndex="2" 
                    Caption="Authorized Viewer" ReadOnly="True">
                </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" 
            SelectCommand="SELECT [Profile], [Authorized Viewer] AS Authorized_Viewer FROM [ProfileINFO] WHERE ([Receiving Client Ref] = @Receiving_Client_Ref) ORDER BY [Profile]">
        <SelectParameters>
            <asp:SessionParameter Name="Receiving_Client_Ref" SessionField="context_clientid"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    </p>
</asp:Content>

