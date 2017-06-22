<%@ Page Title="Inventory Detail" Language="C#" MasterPageFile="~/UPA.master" AutoEventWireup="true" CodeBehind="Inventory_Items.aspx.cs" Inherits="Web.Clients.All.Inventory_Items" %>
<%@ Register assembly="DevExpress.Web.v16.2, Version=16.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Inventory - Item Detail</h3>
    <p>
        <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Export to XLSX" Theme="Office2010Blue">
        </dx:ASPxButton>
    </p>
    <p>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" KeyFieldName="Receiver ID" Theme="Office2010Blue" Width="85%">
            <Columns>
                <dx:GridViewDataDateColumn FieldName="Date Received" VisibleIndex="6">
                    <Settings AllowHeaderFilter="True" />
                    <SettingsHeaderFilter Mode="DateRangePicker">
                    </SettingsHeaderFilter>
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn Caption="Project" FieldName="Product Profile Description" VisibleIndex="4" SortIndex="1" SortOrder="Ascending">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="PSEP" FieldName="Product Group 1" VisibleIndex="10" SortIndex="3" SortOrder="Ascending" Width="1.5in">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Item_ID" VisibleIndex="13" Caption="Serial #">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Count In Package" VisibleIndex="22" Caption="Pcs in Unit" Width="0.5in">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataDateColumn FieldName="As Of" ReadOnly="True" VisibleIndex="33">
                </dx:GridViewDataDateColumn>
                <dx:GridViewDataTextColumn FieldName="Items" VisibleIndex="15" Caption="Unit Ct" Width="0.5in">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Description" FieldName="Product Group 4" VisibleIndex="34" AllowTextTruncationInAdaptiveMode="True">
                    <Settings AllowEllipsisInText="True" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Product Group 5" VisibleIndex="11" Caption="PO#">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Product Type" VisibleIndex="8" Caption="Product" SortIndex="2" SortOrder="Ascending">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="UoM" VisibleIndex="31" Visible="False">
                    <PropertiesTextEdit DisplayFormatString="n0">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataCheckColumn FieldName="QC Required" VisibleIndex="32" Visible="False">
                </dx:GridViewDataCheckColumn>
                <dx:GridViewDataTextColumn FieldName="Status" VisibleIndex="2" SortIndex="1" SortOrder="Ascending" Width="1.5in">
                    <Settings AllowHeaderFilter="True" HeaderFilterMode="CheckedList" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Client PO" VisibleIndex="3" Caption="Client Ref" SortIndex="3" SortOrder="Ascending">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Heat Number" VisibleIndex="12" Caption="Heat Code">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Receiver ID" VisibleIndex="7">
                </dx:GridViewDataTextColumn>
                <dx:GridViewCommandColumn VisibleIndex="0" Visible="False">
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="Location" VisibleIndex="14">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Receiver Type" VisibleIndex="5">
                </dx:GridViewDataTextColumn>
            </Columns>
            <SettingsContextMenu Enabled="True">
                <RowMenuItemVisibility DeleteRow="False" EditRow="False" NewRow="False" />
            </SettingsContextMenu>
            <SettingsAdaptivity AdaptivityMode="HideDataCellsWindowLimit">
                <AdaptiveDetailLayoutProperties>
                    <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" />
                </AdaptiveDetailLayoutProperties>
            </SettingsAdaptivity>
            <SettingsPager PageSize="25">
                <AllButton Visible="True">
                </AllButton>
                <PageSizeItemSettings Visible="True">
                </PageSizeItemSettings>
            </SettingsPager>
            <Settings ShowFilterRow="True" ShowFilterRowMenu="True" ShowGroupPanel="True" ShowFooter="True" ShowGroupFooter="VisibleIfExpanded" VerticalScrollableHeight="500" ShowFilterBar="Auto" />
            <SettingsBehavior AllowFixedGroups="True" EnableCustomizationWindow="True" EnableRowHotTrack="True" ColumnResizeMode="Control" AllowEllipsisInText="True" />

<SettingsCommandButton>
<ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

<HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
</SettingsCommandButton>

            <SettingsPopup>
                <HeaderFilter MinHeight="300px" />
            </SettingsPopup>
            <SettingsSearchPanel Visible="True" />
            <TotalSummary>
                <dx:ASPxSummaryItem DisplayFormat="{0:n0}" FieldName="weight" ShowInColumn="Pounds" SummaryType="Sum" Visible="False" />
                <dx:ASPxSummaryItem DisplayFormat="{0:n1}" FieldName="Linear Ft" ShowInColumn="LNFT" SummaryType="Sum" Visible="False" />
                <dx:ASPxSummaryItem DisplayFormat="{0:n0}" FieldName="Items" ShowInColumn="Item Ct" SummaryType="Sum" />
            </TotalSummary>
            <GroupSummary>
                <dx:ASPxSummaryItem DisplayFormat="Count={0:n0}" FieldName="Items" SummaryType="Sum" ValueDisplayFormat="n0" />
                <dx:ASPxSummaryItem DisplayFormat="LNFT={0:n1}" FieldName="Linear Ft" SummaryType="Sum" Visible="False" />
            </GroupSummary>
            <Styles>
                <Header Wrap="True">
                </Header>
                <Cell Wrap="False">
                </Cell>
            </Styles>
        </dx:ASPxGridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:UPA No Rep DataConnectionString %>" SelectCommand="SELECT * FROM [COPSInventoryAvailable-Brief] WHERE ([Parent ref] = @Parent_ref)">
            <SelectParameters>
                <asp:SessionParameter Name="Parent_ref" SessionField="CONTEXT_CLIENTID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <dx:ASPxGridViewExporter ID="GridViewExporter1" runat="server" FileName="Stock On Hand Detail" GridViewID="ASPxGridView1">
        </dx:ASPxGridViewExporter>
    </p>
<p>
        Weight and LNFT moved to <a href="Invnetory_Sums.aspx">Stock on Hand Net Totals</a></p>
</asp:Content>
