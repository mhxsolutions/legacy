<%@ Page Title="All Loads" Language="C#" MasterPageFile="~/UPA.master" AutoEventWireup="true" CodeBehind="AllLoads.aspx.cs" Inherits="Web.Clients.All.AllLoads" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Load List</h3>
    <p>
        <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export XLSX" Theme="Office2010Blue">
        </dx:ASPxButton>
    </p>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Load ID" Theme="Office2010Blue">
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="Load ID" ShowInGroupFooterColumn="Load ID" SummaryType="Count" />
                <dx:ASPxSummaryItem FieldName="LogOut" ShowInGroupFooterColumn="Log Out" SummaryType="Sum" />
                <dx:ASPxSummaryItem FieldName="POD" ShowInGroupFooterColumn="POD" SummaryType="Sum" />
            </TotalSummary>
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Load ID" ReadOnly="True" SortIndex="0" SortOrder="Descending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Shipment Date" VisibleIndex="4" Caption="Schedule Date">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="DateRangePicker">
                    </SettingsHeaderFilter>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Load Type" VisibleIndex="6">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Shipper" ReadOnly="True" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Destination" FieldName="Receiver" ReadOnly="True" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn Caption="Departed Terminal" FieldName="LogOut" VisibleIndex="9">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataCheckColumn Caption="Delivery Confirmed" FieldName="POD" VisibleIndex="10">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="Tally Load" Visible="False" VisibleIndex="12">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Shipper Release" FieldName="Shipper Number" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="PO Ref" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataHyperLinkColumn Caption="Delivery PDF" FieldName="PDF File" ReadOnly="True" VisibleIndex="11">
                    <PropertiesHyperLinkEdit EncodeHtml="False">
                    </PropertiesHyperLinkEdit>
                </dx:GridViewDataHyperLinkColumn>
                <dx:GridViewDataHyperLinkColumn Caption="Delivery Signature" VisibleIndex="13">
                </dx:GridViewDataHyperLinkColumn>
                <dx:GridViewDataDateColumn Caption="Shipment Date (Log Out)" FieldName="LogOutDate" VisibleIndex="5">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="DateRangePicker">
                    </SettingsHeaderFilter>
                </dx:GridViewDataDateColumn>
            </Columns>
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="20">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFilterBar="Visible" ShowFilterRowMenu="True" ShowFooter="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />

<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>

            <SettingsPopup>
                <HeaderFilter MinHeight="300px" MinWidth="200px" />
            </SettingsPopup>

            <SettingsSearchPanel Visible="True" />
            <Styles>
                <Cell Wrap="False">
                </Cell>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT [Load ID], [Shipment Date], [Load Type], Shipper, Receiver, [Shipping Client Ref], [Delivery Client Ref], [PDF File], [PDF File Name], Age, LogOut, POD, [Tally Load], [Client A], [Client B], [Client C], [Client Note], [Shipper Number], Fleet, [PO Ref], LogOutDate FROM COPSallBOLs WHERE ([Shipping Client Ref] = @Shipping_Client_Ref) OR ([Delivery Client Ref] = @Delivery_Client_Ref)">
            <SelectParameters>
                <asp:SessionParameter Name="Shipping_Client_Ref" SessionField="CONTEXT_CLIENTID" Type="Int32" />
                <asp:SessionParameter Name="Delivery_Client_Ref" SessionField="CONTEXT_CLIENTID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Outbound Material by BOL" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    </p>
</asp:Content>
