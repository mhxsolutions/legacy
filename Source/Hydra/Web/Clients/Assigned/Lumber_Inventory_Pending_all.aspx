<%@ Page Title="Inventory Pending" Language="C#" MasterPageFile="~/Hydra.master" AutoEventWireup="true" CodeBehind="Lumber_Inventory_Pending_all.aspx.cs" Inherits="Web.Clients.Assigned.Lumber_Inventory_Pending_all" %>

<%@ Register Assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Src="~/Controls/SaveLayout.ascx" TagPrefix="uc1" TagName="SaveLayout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Inventory Pending</h3>
    <p>
        <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export XLSX" Theme="Office2003Olive">
        </dx:ASPxButton>
        <dx:ASPxButton ID="ASPxButton2" runat="server" OnClick="ASPxButton2_Click" Text="Export PDF" Theme="Office2003Olive">
        </dx:ASPxButton>
        <dx:ASPxButton ID="ASPxButton3" runat="server" OnClick="ASPxButton3_Click" Text="Expand All Rows" Theme="Office2003Olive">
        </dx:ASPxButton>
        <dx:ASPxButton ID="ASPxButton4" runat="server" OnClick="ASPxButton4_Click" Text="Collapse All Rows" Theme="Office2003Olive">
        </dx:ASPxButton>
    </p>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="Office2003Olive">
            <SettingsContextMenu Enabled="True" EnableRowMenu="False">
            </SettingsContextMenu>
            <SettingsPager PageSize="200">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings ShowAllItem="True" Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" ShowFooter="True" ShowGroupFooter="VisibleAlways" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn Caption="Profile" FieldName="Profile" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="1">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Product Code" FieldName="Prod 1" SortIndex="1" SortOrder="Ascending" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Description" FieldName="Prod 2" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Length" FieldName="Prod 3" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Unit Label" VisibleIndex="18" Caption="Type">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Unit Ct" VisibleIndex="16">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Pcs each Unit" FieldName="Pcs per Unit" VisibleIndex="17">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="ETA" VisibleIndex="21">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn Caption="Terminal" FieldName="Terminal Abr" VisibleIndex="20">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Total Pcs" VisibleIndex="19">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Inbound Load#" FieldName="Prod 5" VisibleIndex="15">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Item ID" VisibleIndex="6">
                </dx:GridViewDataTextColumn>
            </Columns>
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="Unit Ct" ShowInColumn="Unit Ct" SummaryType="Sum" ValueDisplayFormat="{0:n0}" />
                <dx:ASPxSummaryItem FieldName="Total Pcs" ShowInColumn="Total Pcs" SummaryType="Sum" ValueDisplayFormat="{0:n0}" />
            </TotalSummary>
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="Unit Ct" SummaryType="Sum" ShowInGroupFooterColumn="Unit Ct" ValueDisplayFormat="{0:n0}" />
                <dx:ASPxSummaryItem FieldName="Total Pcs" ShowInGroupFooterColumn="Total Pcs" SummaryType="Sum" ValueDisplayFormat="{0:n0}" />
            </GroupSummary>
            <Styles>
                <Cell Wrap="False">
                </Cell>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Receiving Client Ref], [Client Name], City, Profile, [Label 1], [Prod 1], [Label 2], [Prod 2], [Label 3], [Prod 3], [Label 4], [Prod 4], [Label 5], [Prod 5], [Item ID], [Weight Label], Wt, Avg_Wt, Tons, [Unit Label], [Unit Ct], [Pcs per Unit], [Total Pcs], LNFT, Terminal, [Terminal Abr], ETA, [Company ID ref], [Product Profile Ref], [Product Type], [ATSF Product ID] FROM [Pre-Receiver Inventory Summary] WHERE ([Company ID ref] = @Company_ID_ref) AND ([ATSF Product ID] &lt;&gt; 78 AND [ATSF Product ID] &lt;&gt; 802)">
            <SelectParameters>
                <asp:Parameter DefaultValue="3" Name="Company_ID_ref" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Inventory Pending" GridViewID="ASPxGridView1" BottomMargin="50" Landscape="True" LeftMargin="50" RightMargin="50" TopMargin="50">
    </dx:ASPxGridViewExporter>
    <p>
        &nbsp;
    </p>
    <uc1:SaveLayout runat="server" ID="SaveLayout" GridViewID="ASPxGridView1" />
</asp:Content>
