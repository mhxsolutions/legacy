<%@ Page Title="Inbound Trucks" Language="C#" MasterPageFile="~/UPA.master" AutoEventWireup="true" CodeBehind="Inbound Trucks Scheduled.aspx.cs" Inherits="Web.Clients.All.Inbound_Trucks_Scheduled" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click1" Text="Export to XLSX" Theme="Office2010Blue">
</dx:ASPxButton>
<br />
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2010Blue">
        <TotalSummary>
            <dx:ASPxSummaryItem FieldName="Trucks Scheduled" ShowInColumn="Trucks Scheduled" SummaryType="Sum" />
        </TotalSummary>
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataDateColumn Caption="Date Scheduled" FieldName="Date_Scheduled" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="DateRangePicker">
                </SettingsHeaderFilter>
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Trucks Scheduled" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
        </Columns>
        <SettingsContextMenu Enabled="True" EnableRowMenu="False">
        </SettingsContextMenu>
        <Settings ShowFooter="True" ShowTitlePanel="True" ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" />
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />

<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>

        <SettingsPopup>
            <HeaderFilter MinHeight="300px" />
        </SettingsPopup>
        <SettingsText Title="Scheduled Inbound Truck Count" />
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT [Date Scheduled] AS Date_Scheduled, [Trucks Scheduled] FROM [UPA Number of Trucks Scheduled Inbound] WHERE ([Client ID] = @Client_ID)">
        <SelectParameters>
            <asp:SessionParameter Name="Client_ID" SessionField="CONTEXT_CLIENTID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
<dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Scheduled Inbound Truck Count" GridViewID="ASPxGridView1">
</dx:ASPxGridViewExporter>
</asp:Content>
