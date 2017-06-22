<%@ Page Title="Trucks Arrived" Language="C#" MasterPageFile="~/UPA.master" AutoEventWireup="true" CodeBehind="TrucksArrived.aspx.cs" Inherits="Web.Clients.All.TrucksArrived" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Trucks Arrived</h3>
    <p>
        <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export XLSX" Theme="Office2010Blue">
        </dx:ASPxButton>
    </p>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2010Blue">
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="Trucks Arrived" ShowInColumn="Trucks Arrived" SummaryType="Sum" />
            </TotalSummary>
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />

<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>
            <SettingsPopup>
                <HeaderFilter MinHeight="300px" />
            </SettingsPopup>
            <Columns>
                <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataDateColumn Caption="Date Arrived" FieldName="Date_Arrived" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="DateRangePicker">
                    </SettingsHeaderFilter>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Trucks Arrived" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="25">
                <AllButton Visible="True">
                </AllButton>
            </SettingsPager>
            <Settings ShowFooter="True" ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" />
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT [Date Arrived] AS Date_Arrived, [Trucks Arrived], [Client ID] FROM [UPA Number of Trucks Arrived Inbound] WHERE ([Client ID] = @CLIENT)">
            <SelectParameters>
                <asp:SessionParameter Name="CLIENT" SessionField="CONTEXT_CLIENTID" />
            </SelectParameters>
        </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Trucks Arrived" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    </p>
</asp:Content>
