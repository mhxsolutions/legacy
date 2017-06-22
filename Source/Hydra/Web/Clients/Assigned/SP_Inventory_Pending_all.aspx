<%@ Page Title="Inventory Pending" Language="C#" MasterPageFile="~/Hydra.master" AutoEventWireup="true" CodeBehind="SP_Inventory_Pending_all.aspx.cs" Inherits="Web.Clients.Assigned.SP_Inventory_Pending_all" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register Src="~/Controls/SaveLayout.ascx" TagPrefix="uc1" TagName="SaveLayout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Inventory Pending</h3>
    <p>
        <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export XLSX" Theme="Office2003Olive">
        </dx:ASPxButton>
        <dx:ASPxButton ID="ASPxButton4" runat="server" OnClick="ASPxButton4_Click" Text="Export PDF" Theme="Office2003Olive">
        </dx:ASPxButton>
        <dx:ASPxButton ID="ASPxButton2" runat="server" OnClick="ASPxButton2_Click" Text="Expand All Rows" Theme="Office2003Olive">
        </dx:ASPxButton>
        <dx:ASPxButton ID="ASPxButton3" runat="server" OnClick="ASPxButton3_Click" Text="Collapse All Rows" Theme="Office2003Olive">
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
            <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowGroupFooter="VisibleAlways" ShowGroupPanel="True" />
            <SettingsBehavior EnableCustomizationWindow="True" EnableRowHotTrack="True" />
            <SettingsSearchPanel Visible="True" />
            <Columns>
                <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Profile" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="3">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Prod 1" SortIndex="1" SortOrder="Ascending" VisibleIndex="4" Caption="Vendor/Supplier">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="ETA" ReadOnly="True" VisibleIndex="11">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Prod 2" SortIndex="2" SortOrder="Ascending" VisibleIndex="5" Caption="Release#">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Prod 3" SortIndex="3" SortOrder="Ascending" VisibleIndex="6" Caption="Grade">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Pcs per Unit" VisibleIndex="7" Caption="#Bales">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Wt" VisibleIndex="8" Caption="Wt Lb">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Avg_Wt" VisibleIndex="9">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons" VisibleIndex="10">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Terminal Abr" VisibleIndex="14" Caption="Terminal">
                </dx:GridViewDataTextColumn>
            </Columns>
            <TotalSummary>
                <dx:ASPxSummaryItem FieldName="Pcs per Unit" ShowInColumn="#Bales" SummaryType="Sum" DisplayFormat="#Bales={0:n0}" />
                <dx:ASPxSummaryItem DisplayFormat="Avg={0:n1}" FieldName="Avg_Wt" ShowInColumn="Avg_Wt" SummaryType="Average" />
                <dx:ASPxSummaryItem FieldName="Tons" ShowInColumn="Tons" SummaryType="Sum" DisplayFormat="Tons={0:n0}" />
                <dx:ASPxSummaryItem FieldName="Wt" ShowInColumn="Wt Lb" SummaryType="Sum" DisplayFormat="Wt Lb={0:n0}" />
            </TotalSummary>
            <GroupSummary>
                <dx:ASPxSummaryItem FieldName="Pcs per Unit" ShowInGroupFooterColumn="#Bales" SummaryType="Sum" DisplayFormat="#Bales={0:n0}" />
                <dx:ASPxSummaryItem DisplayFormat="Avg={0:n1}" FieldName="Avg_Wt" ShowInGroupFooterColumn="Avg_Wt" SummaryType="Average" />
                <dx:ASPxSummaryItem FieldName="Tons" ShowInGroupFooterColumn="Tons" SummaryType="Sum" DisplayFormat="Tons={0:n0}" />
                <dx:ASPxSummaryItem FieldName="Wt" ShowInGroupFooterColumn="Wt Lb" SummaryType="Sum" DisplayFormat="Wt Lb={0:n0}" />
            </GroupSummary>
            <Styles>
                <Cell Wrap="False">
                </Cell>
            </Styles>
        </dx:ASPxGridView>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Inventory Pending" GridViewID="ASPxGridView1" BottomMargin="50" Landscape="True" LeftMargin="50" RightMargin="50" TopMargin="50">
        </dx:ASPxGridViewExporter>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Receiving Client Ref], [Client Name], City, Profile, [Label 1], [Prod 1], [Label 2], [Prod 2], [Label 3], [Prod 3], [Label 4], [Prod 4], [Label 5], [Prod 5], [Item ID], [Weight Label], Wt, Avg_Wt, Tons, [Unit Label], [Unit Ct], [Pcs per Unit], [Total Pcs], LNFT, Terminal, [Terminal Abr], ETA, [Company ID ref], [Product Profile Ref], [Product Type], [ATSF Product ID] FROM [Pre-Receiver Inventory Summary] WHERE ([Company ID ref] = @Company_ID_ref) AND ([ATSF Product ID] = @typeID)">
            <SelectParameters>
                <asp:Parameter DefaultValue="3" Name="Company_ID_ref" Type="Int32" />
                <asp:Parameter DefaultValue="802" Name="typeID" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <uc1:SaveLayout runat="server" ID="SaveLayout" GridViewID="ASPxGridView1"  />
    <p>
    &nbsp;</p>
    <p>
        &nbsp;</p>
</asp:Content>
