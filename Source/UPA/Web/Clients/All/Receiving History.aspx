<%@ Page Title="Receiving History" Language="C#" MasterPageFile="~/UPA.master" AutoEventWireup="true" CodeBehind="Receiving History.aspx.cs" Inherits="Web.Clients.All.Receiving_History" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Receiving History - Summary</h3>
    <p>
        <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export to XLSX" Theme="Office2010Blue">
        </dx:ASPxButton>
    </p>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="Receiver ID" Theme="Office2010Blue">
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Terminal" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Project" FieldName="Profile" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Receiver ID" ReadOnly="True" SortIndex="2" SortOrder="Descending" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Carrier" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Type" VisibleIndex="8">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="Date Received" SortIndex="1" SortOrder="Descending" VisibleIndex="2">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="DateRangePicker">
                    </SettingsHeaderFilter>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn Caption="PSEP" FieldName="Group 1" SortIndex="3" SortOrder="Ascending" VisibleIndex="11">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="MSP" FieldName="Group 2" VisibleIndex="13">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="SCG Stock Code" FieldName="Group 3" VisibleIndex="14">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Short Description" FieldName="Extended Description" VisibleIndex="16" Visible="False">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Long Description" FieldName="Product Group 4" VisibleIndex="19">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="PO#" FieldName="Product Group 5" VisibleIndex="12">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Pounds" VisibleIndex="23">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="LNFT" VisibleIndex="24">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Pcs Ea" VisibleIndex="26">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Pcs Tot" VisibleIndex="27">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Item Ct" FieldName="item Ct" VisibleIndex="25">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="SCG Load Ref" FieldName="Client Web Ref" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Commodity Part #" FieldName="Customer Product Num" VisibleIndex="20">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Product" FieldName="Product Type" VisibleIndex="9">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="SAP Commodity Code" VisibleIndex="10">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="UoM" VisibleIndex="28">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="QC Required" VisibleIndex="29">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn Caption="SDGE Stock Code" FieldName="Template Data 1" VisibleIndex="15">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Commodity Description" FieldName="Template Data 2" VisibleIndex="21">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataHyperLinkColumn FieldName="PDF Link" VisibleIndex="4">
                    <PropertiesHyperLinkEdit EncodeHtml="False">
                    </PropertiesHyperLinkEdit>
                </dx:GridViewDataHyperLinkColumn>
                <dx:GridViewDataTextColumn FieldName="Location" VisibleIndex="22">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsContextMenu Enabled="True">
            </SettingsContextMenu>
            <SettingsPager PageSize="25">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" ShowFilterBar="Visible" ShowFooter="True" />
            <SettingsBehavior EnableCustomizationWindow="True" />

<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>

            <SettingsPopup>
                <HeaderFilter MinHeight="300px" />
            </SettingsPopup>

            <SettingsSearchPanel Visible="True" />
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="item Ct" SummaryType="Sum" />
            </GroupSummary>
            <Styles>
                <Cell Wrap="False">
                </Cell>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [COPSReceivedHistoryWithTemplateDetail] WHERE ([client] = @client)">
            <SelectParameters>
                <asp:SessionParameter Name="client" SessionField="context_clientID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Receiving History" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    </p>
</asp:Content>
