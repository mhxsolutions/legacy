<%@ Page Title="Inventory Pending" Language="C#" MasterPageFile="~/Hydra.master" AutoEventWireup="true" CodeBehind="CB_Inventory_Pending_all.aspx.cs" Inherits="Web.Clients.Assigned.CB_Inventory_Pending_all" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register Src="~/Controls/SaveLayout.ascx" TagPrefix="uc1" TagName="SaveLayout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Paper Rolls Inventory Pending</h3>
    <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export XLSX" Theme="Office2003Olive">
    </dx:ASPxButton>
    <dx:ASPxButton ID="ASPxButton4" runat="server" OnClick="ASPxButton4_Click" Text="Export PDF" Theme="Office2003Olive">
    </dx:ASPxButton>
    <dx:ASPxButton ID="ASPxButton2" runat="server" OnClick="ASPxButton2_Click" Text="Expand All Rows" Theme="Office2003Olive">
    </dx:ASPxButton>
    <dx:ASPxButton ID="ASPxButton3" runat="server" OnClick="ASPxButton3_Click" Text="Collapse All Rows" Theme="Office2003Olive">
    </dx:ASPxButton>
    <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="ATSF Product ID" Theme="Office2003Olive" Width="75%">
        <SettingsPager PageSize="200">
            <AllButton Visible="True">
            </AllButton>
            <PageSizeItemSettings ShowAllItem="True" Visible="True">
            </PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupFooter="VisibleAlways" ShowGroupPanel="True" />
        <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" AllowEllipsisInText="True" ColumnResizeMode="Control" />

<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>

        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowInCustomizationForm="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn Caption="Client" FieldName="Client Name" GroupIndex="0" ShowInCustomizationForm="True" SortIndex="0" SortOrder="Ascending" VisibleIndex="2">
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="CheckedList">
                </SettingsHeaderFilter>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Profile" GroupIndex="1" ShowInCustomizationForm="True" SortIndex="1" SortOrder="Ascending" VisibleIndex="4">
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="CheckedList">
                </SettingsHeaderFilter>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Description" FieldName="Prod 1" GroupIndex="2" ShowInCustomizationForm="True" SortIndex="2" SortOrder="Ascending" VisibleIndex="5">
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="CheckedList">
                </SettingsHeaderFilter>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="PO#" FieldName="Prod 3" ShowInCustomizationForm="True" VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Inbound Load#" FieldName="Prod 4" ShowInCustomizationForm="True" VisibleIndex="13">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Item ID" ShowInCustomizationForm="True" VisibleIndex="16">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Pounds" FieldName="Wt" ShowInCustomizationForm="True" VisibleIndex="18">
                <PropertiesTextEdit DisplayFormatString="n1">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Tons" ShowInCustomizationForm="True" VisibleIndex="20">
                <PropertiesTextEdit DisplayFormatString="n1">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Roll Ct" FieldName="Pcs per Unit" ShowInCustomizationForm="True" VisibleIndex="23">
                <PropertiesTextEdit DisplayFormatString="n0">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="LNFT" ShowInCustomizationForm="True" VisibleIndex="25">
                <PropertiesTextEdit DisplayFormatString="n1">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Terminal" FieldName="Terminal Abr" ShowInCustomizationForm="True" VisibleIndex="27">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="ETA" ShowInCustomizationForm="True" VisibleIndex="28">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Width" GroupIndex="3" ReadOnly="True" ShowInCustomizationForm="True" SortIndex="3" SortOrder="Ascending" VisibleIndex="6">
                <PropertiesTextEdit DisplayFormatString="n1">
                </PropertiesTextEdit>
                <Settings AllowHeaderFilter="True" />
                <SettingsHeaderFilter Mode="CheckedList">
                </SettingsHeaderFilter>
            </dx:GridViewDataTextColumn>
        </Columns>
        <TotalSummary>
            <dx:ASPxSummaryItem FieldName="Tons" ShowInColumn="Tons" SummaryType="Sum" />
            <dx:ASPxSummaryItem FieldName="Wt" SummaryType="Sum" />
            <dx:ASPxSummaryItem FieldName="LNFT" SummaryType="Sum" />
            <dx:ASPxSummaryItem FieldName="Pcs per Unit" SummaryType="Sum" />
        </TotalSummary>
        <GroupSummary>
            <dx:ASPxSummaryItem FieldName="Tons" SummaryType="Sum" ShowInGroupFooterColumn="Tons" />
            <dx:ASPxSummaryItem FieldName="Wt" SummaryType="Sum" DisplayFormat="Sum={0:n0}" ShowInGroupFooterColumn="Pounds" />
            <dx:ASPxSummaryItem FieldName="Pcs per Unit" SummaryType="Sum" DisplayFormat="Sum={0:n0}" ShowInGroupFooterColumn="Roll Ct" />
            <dx:ASPxSummaryItem FieldName="LNFT" SummaryType="Sum" ShowInGroupFooterColumn="LNFT" />
        </GroupSummary>
    </dx:ASPxGridView>
    <p>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Inventory Pending" GridViewID="ASPxGridView2" BottomMargin="50" Landscape="True" LeftMargin="50" RightMargin="50" TopMargin="50">
        </dx:ASPxGridViewExporter>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Receiving Client Ref], [Client Name], City, Profile, [Label 1], [Prod 1], [Label 2], [Prod 2], [Label 3], [Prod 3], [Label 4], [Prod 4], [Label 5], [Prod 5], [Item ID], [Weight Label], Wt, Avg_Wt, Tons, [Unit Label], [Unit Ct], [Pcs per Unit], [Total Pcs], LNFT, Terminal, [Terminal Abr], ETA, [Company ID ref], [Product Profile Ref], [Product Type], CAST([Prod 2] AS float) AS Width, [ATSF Product ID] FROM [Pre-Receiver Inventory Summary] WHERE ([Company ID ref] = @Company_ID_ref) AND ([ATSF Product ID] = @typeID)">
            <SelectParameters>
                <asp:Parameter DefaultValue="3" Name="Company_ID_ref" Type="Int32" />
                <asp:Parameter DefaultValue="78" Name="typeID" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <uc1:SaveLayout runat="server" ID="SaveLayout" GridViewID="ASPxGridView2" />
</asp:Content>
