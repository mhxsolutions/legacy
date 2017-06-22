<%@ Page Title="Inventory Pending" Language="C#" MasterPageFile="~/Hydra.master" AutoEventWireup="true" CodeBehind="CB_Inventory_Pending.aspx.cs" Inherits="Web.Clients.All.CB_Inventory_Pending" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Inventory Pending</h3>
    <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export XLSX" Theme="Office2003Olive">
    </dx:ASPxButton>
    <dx:ASPxButton ID="ASPxButton4" runat="server" OnClick="ASPxButton4_Click" Text="Export PDF" Theme="Office2003Olive">
    </dx:ASPxButton>
    <dx:ASPxButton ID="ASPxButton2" runat="server" OnClick="ASPxButton2_Click" Text="Expand All Rows" Theme="Office2003Olive">
        </dx:ASPxButton>
        <dx:ASPxButton ID="ASPxButton3" runat="server" OnClick="ASPxButton3_Click" Text="Collapse All Rows" Theme="Office2003Olive">
        </dx:ASPxButton>
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
                <dx:GridViewDataTextColumn Caption="Profile" FieldName="Profile" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="4">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Description" FieldName="Prod 1" GroupIndex="1" SortIndex="1" SortOrder="Ascending" VisibleIndex="6">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="PO#" FieldName="Prod 3" SortIndex="3" SortOrder="Ascending" VisibleIndex="11">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Inbound Load#" FieldName="Prod 4" VisibleIndex="13">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Item ID" VisibleIndex="16">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Pounds" FieldName="Wt" VisibleIndex="18">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Tons" VisibleIndex="19">
                    <PropertiesTextEdit DisplayFormatString="n1">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Roll Ct" FieldName="Pcs per Unit" VisibleIndex="22">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="LNFT" VisibleIndex="23">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Terminal" FieldName="Terminal Abr" VisibleIndex="25">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="ETA" VisibleIndex="26">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Width" GroupIndex="2" ReadOnly="True" SortIndex="2" SortOrder="Ascending" VisibleIndex="8">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
            </Columns>
            <TotalSummary>
                <dx:ASPxSummaryItem DisplayFormat="Sum={0:n0}" FieldName="Wt" ShowInColumn="Pounds" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="Sum={0:n1}" FieldName="Tons" ShowInColumn="Tons" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="Sum={0:n0}" FieldName="Pcs per Unit" ShowInColumn="Roll Ct" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="Sum={0:n0}" FieldName="LNFT" ShowInColumn="LNFT" SummaryType="Sum" />
            </TotalSummary>
            <GroupSummary>
                <dx:ASPxSummaryItem DisplayFormat="Sum={0:n0}" FieldName="Wt" ShowInGroupFooterColumn="Pounds" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="Sum={0:n1}" FieldName="Tons" ShowInGroupFooterColumn="Tons" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="Sum={0:n0}" FieldName="Pcs per Unit" ShowInGroupFooterColumn="Roll Ct" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="Sum={0:n0}" FieldName="LNFT" ShowInGroupFooterColumn="LNFT" SummaryType="Sum" />
            </GroupSummary>
        </dx:ASPxGridView>
    </p>
    <p>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Inventory Pending" GridViewID="ASPxGridView1" BottomMargin="50" Landscape="True" LeftMargin="50" RightMargin="50" TopMargin="50">
        </dx:ASPxGridViewExporter>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DWS No Rep DataConnectionString %>" SelectCommand="SELECT [Receiving Client Ref], [Client Name], City, Profile, [Label 1], [Prod 1], [Label 2], [Prod 2], [Label 3], [Prod 3], [Label 4], [Prod 4], [Label 5], [Prod 5], [Item ID], [Weight Label], Wt, Avg_Wt, Tons, [Unit Label], [Unit Ct], [Pcs per Unit], [Total Pcs], LNFT, Terminal, [Terminal Abr], ETA, [Company ID ref], [Product Profile Ref], [Product Type], CAST([Prod 2] AS float) AS Width FROM [Pre-Receiver Inventory Summary] WHERE ([Receiving Client Ref] = @Receiving_Client_Ref) AND ([Company ID ref] = @Company_ID_ref)">
            <SelectParameters>
                <asp:SessionParameter Name="Receiving_Client_Ref" SessionField="CONTEXT_CLIENTID" Type="Int32" />
                <asp:Parameter DefaultValue="3" Name="Company_ID_ref" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>
